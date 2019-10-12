module Main where

  import           TypeCheck            (typeCheck)

  import           AbsKoala
  import           ErrM
  import           LexKoala             (tokens)
  import           ParKoala             (pProgram)
  
  import           Control.Monad.Except
  import           Control.Monad.Reader
  import           Control.Monad.State
  import           Data.Bool
  import           Data.Map             (Map)
  import qualified Data.Map             as Map
  import           System.Environment   (getArgs, getProgName)
  import           System.IO
  
  data Value
    = VInt Integer
    | VStr String
    | VBool Bool
    | VVoid
    | VFunc { typ    :: Type
            , args   :: [Arg]
            , stmts  :: [Stmt]
            , locEnv :: Bindings
            , isGen  :: Bool }
    deriving (Show)
  
  type Loc = Integer
  
  type Bindings = Map Ident Loc
  
  data Env = Env
    { env  :: Bindings
    , fenv :: Ident -- name of the function/generator currently in execution
    } deriving (Show)
  
  data Store = Store
    { store   :: Map Loc Value
    , nextLoc :: Loc
    , flag    :: String -- clear, break, continue or yield
    } deriving (Show)
  
  type ExecM a = ReaderT Env (StateT Store (ExceptT String IO)) a
  
  main :: IO ()
  main = do
    args <- getArgs
    progName <- getProgName
    if null args
      then do
        contents <- getContents
        parseProgram contents
      else do
        handle <- openFile (head args) ReadMode
        contents <- hGetContents handle
        parseProgram contents
        hClose handle
  
  parseProgram :: String -> IO ()
  parseProgram input =
    case pProgram . tokens $ input of
      Ok program  -> do 
        result <- typeCheck program
        case result of
          Left error -> hPutStrLn stderr ("\nTYPECHECK FAILURE: " ++ error)
          Right () -> execute program
      Bad message -> hPutStrLn stderr ("\nSYNTAX ERROR: " ++ message)
  
  execute :: Program -> IO ()
  execute program = do
    let env = Env Map.empty (Ident "")
    report <-
      runExceptT $
      runStateT (runReaderT (interpret program) env) (Store Map.empty 0 "clear")
    case report of
      Left error -> hPutStrLn stderr ("\n" ++ "ERROR: " ++ error)
      Right _    -> return ()
    return ()
  
  interpret :: Program -> ExecM ()
  interpret (Program topDefs) = do
    env <- readTopDefs topDefs
    store <- getStore
    case Map.lookup (Ident "main") env of
      Nothing -> throwError "Function main() not defined"
      Just location -> do
        case Map.lookup location store of
          Nothing -> throwError "Function main() improperly defined"
          Just (VFunc typ args stmts localEnv isGen) -> do
            local (\_ -> (Env env (Ident "main"))) (runStmts stmts)
            return ()
  
  readTopDefs :: [TopDef] -> ExecM Bindings
  readTopDefs topDefs = readTopDefs' topDefs Map.empty
    where
      readTopDefs' :: [TopDef] -> Bindings -> ExecM Bindings
      readTopDefs' [] env = return env
      readTopDefs' ((FnDef typ ident args block):fs) env = do
        let (Block stmts) = block
        let func = VFunc typ args stmts env False
        newLoc <- newloc
        store <- getStore
        putStore $ Map.insert newLoc func store
        newEnv <- readTopDefs' fs (Map.insert ident newLoc env)
        return newEnv
  
  newloc :: ExecM Loc
  newloc = do
    (Store store nextLoc flag) <- get
    put (Store store (nextLoc + 1) flag)
    return nextLoc
  
  getStore :: ExecM (Map Loc Value)
  getStore = do
    (Store store nextLoc flag) <- get
    return store
  
  putStore :: (Map Loc Value) -> ExecM ()
  putStore newStore = do
    (Store store nextLoc flag) <- get
    put (Store newStore nextLoc flag)
  
  getEnv :: ExecM Bindings
  getEnv = do
    (Env env fid) <- ask
    return env
  
  getFuncEnv :: ExecM Ident
  getFuncEnv = do
    (Env env fenv) <- ask
    return fenv
  
  getFlag :: ExecM String
  getFlag = do
    (Store store nextLoc flag) <- get
    return flag
  
  setFlag :: String -> ExecM ()
  setFlag flag = do
    (Store store nextLoc localFlag) <- get
    put (Store store nextLoc flag)
  
  runBlock :: Block -> ExecM Value
  runBlock (Block []) = return VVoid
  runBlock (Block stmts) = do
    env <- ask
    local (\_ -> env) (runStmts stmts)
  
  runStmts :: [Stmt] -> ExecM Value
  runStmts [] = return VVoid
  runStmts stmts = do
    case (head stmts) of
      (Decl typ items) -> do
        env <- getEnv
        fenv <- getFuncEnv
        newEnv <- declare items env
        local (\_ -> (Env newEnv fenv)) (runStmts $ tail stmts)
      (FDecl typ ident args block) -> do
        env <- getEnv
        loc <- newloc
        updateFuncEnv ident loc
        store <- getStore
        fenv <- getFuncEnv
        let (Block funcStmts) = block
        let func = VFunc typ args funcStmts env False
        let newEnv = Map.insert ident loc env
        putStore (Map.insert loc func store)
        local (\_ -> (Env newEnv fenv)) (runStmts $ tail stmts)
      (GDecl typ ident args block) -> do
        env <- getEnv
        loc <- newloc
        updateFuncEnv ident loc
        store <- getStore
        fenv <- getFuncEnv
        let (Block genStmts) = block
        let func = VFunc typ args genStmts env True
        let newEnv = Map.insert ident loc env
        putStore (Map.insert loc func store)
        local (\_ -> (Env newEnv fenv)) (runStmts $ tail stmts)
      (Ret expr) -> evalExpr expr
      VRet -> return VVoid
      Break -> do
        setFlag "break"
        return VVoid
      Cont -> do
        setFlag "continue"
        return VVoid
      (Yield expr) -> do
        ret <- evalExpr expr
        setFlag "yield"
        env <- getEnv
        fenv <- getFuncEnv
        case Map.lookup fenv env of
          Nothing -> throwError $ "Function " ++ show fenv ++ " undefined"
          Just loc -> do
            store <- getStore
            case Map.lookup loc store of
              Nothing -> throwError "Function uninitialized"
              Just (VFunc typ args funcStmts funcEnv isGen) -> do
                putStore $
                  Map.insert loc (VFunc typ args (tail stmts) funcEnv isGen) store
                if isGen
                  then return ret
                  else throwError $
                       "Function " ++ show fenv ++ " is not a generator"
      otherwise -> do
        ret <- runStmt $ head stmts
        flag <- getFlag
        case flag of
          "clear" -> do
            case tail stmts of
              []        -> return ret
              otherwise -> runStmts $ tail stmts
          "yield" -> do
            setFlag "clear"
            return ret
          otherwise -> return VVoid
  
  declare :: [Item] -> Bindings -> ExecM Bindings
  declare [] env = return env
  declare items env =
    case (head items) of
      (NoInit ident) -> do
        newLoc <- newloc
        updateFuncEnv ident newLoc
        declare (tail items) (Map.insert ident newLoc env)
      (Init ident expr) -> do
        newLoc <- newloc
        updateFuncEnv ident newLoc
        val <- evalExpr expr
        store <- getStore
        putStore (Map.insert newLoc val store)
        declare (tail items) (Map.insert ident newLoc env)
  
  updateFuncEnv :: Ident -> Loc -> ExecM ()
  updateFuncEnv varId varLoc = do
    fenv <- getFuncEnv
    env <- getEnv
    case Map.lookup fenv env of
      Nothing -> throwError $ "Function " ++ show fenv ++ " is undefined"
      Just loc -> do
        store <- getStore
        case Map.lookup loc store of
          Nothing ->
            throwError $
            "Trying to use a dangling pointer to function " ++ show fenv
          Just (VFunc typ args stmts locEnv isGen) -> do
            let newEnv = Map.insert varId varLoc locEnv
            putStore $ Map.insert loc (VFunc typ args stmts newEnv isGen) store
  
  concrete :: Expr -> ExecM Value
  concrete expr = do
    val <- evalExpr expr
    case val of
      VVoid     -> throwError "Missing return or yield"
      otherwise -> return val
  
  runStmt :: Stmt -> ExecM Value
  runStmt Empty = return VVoid
  runStmt (BStmt block) = runBlock block
  runStmt (PrintI expr) = do
    (VInt result) <- concrete expr
    performIO . putStr . show $ result
    return VVoid
  runStmt (PrintB expr) = do
    (VBool result) <- concrete expr
    performIO . putStr . show $ result
    return VVoid
  runStmt (PrintS expr) = do
    (VStr result) <- concrete expr
    performIO . putStr . id $ result
    return VVoid
  runStmt (Ass ident expr) = do
    val <- concrete expr
    updateVal ident val
    return VVoid
  runStmt (Incr ident) = do
    (VInt val) <- lookupVal ident
    updateVal ident (VInt $ val + 1)
    return VVoid
  runStmt (Decr ident) = do
    (VInt val) <- lookupVal ident
    updateVal ident (VInt $ val - 1)
    return VVoid
  runStmt (Cond expr stmt) = do
    val <- evalExpr expr
    case val of
      (VBool True)  -> runStmts [stmt]
      (VBool False) -> return VVoid
      otherwise     -> throwError "Wrong condition argument"
  runStmt (CondElse expr stmt1 stmt2) = do
    val <- evalExpr expr
    case val of
      (VBool True)  -> runStmts [stmt1]
      (VBool False) -> runStmts [stmt2]
      otherwise     -> throwError "Wrong condition argument"
  runStmt (While expr stmt) = do
    case stmt of
      (BStmt (Block stmts)) -> runWhile stmts expr stmt
      otherwise             -> runWhile [stmt] expr stmt
    where
      runWhile :: [Stmt] -> Expr -> Stmt -> ExecM Value
      runWhile stmts expr stmt = do
        value <- evalExpr expr
        case value of
          (VBool val) -> do
            if val
              then do
                ret <- runStmts $ stmts ++ [(While expr stmt)]
                flag <- getFlag
                case flag of
                  "continue" -> do
                    setFlag "clear"
                    runStmt (While expr stmt)
                  "break" -> do
                    setFlag "clear"
                    return VVoid
                  otherwise -> return ret
              else return VVoid
          otherwise -> throwError $ "Wrong condition argument"
  runStmt (SExp expr) = do
    evalExpr expr
    return VVoid
  runStmt _ = return VVoid
  
  updateVal :: Ident -> Value -> ExecM ()
  updateVal ident val = do
    env <- getEnv
    store <- getStore
    case Map.lookup ident env of
      Nothing  -> throwError "Trying to write to a non-declared variable"
      Just loc -> putStore $ Map.insert loc val store
  
  lookupVal :: Ident -> ExecM Value
  lookupVal ident = do
    env <- getEnv
    case Map.lookup ident env of
      Nothing -> do
        throwError $ "Trying to read an non-declared variable " ++ showId ident
      Just loc -> do
        store <- getStore
        case Map.lookup loc store of
          Nothing  -> throwError "Using a dangling pointer"
          Just val -> return val
  
  performIO :: IO a -> ExecM a
  performIO = lift . lift . lift
  
  showId :: Ident -> String
  showId (Ident name) = name
  
  evalExpr :: Expr -> ExecM Value
  evalExpr (EVar ident) = do
    env <- getEnv
    case Map.lookup ident env of
      Nothing -> throwError $ "Variable " ++ showId ident ++ " undefined"
      Just loc -> do
        store <- getStore
        case Map.lookup loc store of
          Nothing  -> throwError "Variable uninitialized"
          Just val -> return val
  evalExpr (ELitInt i) = return (VInt i)
  evalExpr (ELitTrue) = return (VBool True)
  evalExpr (ELitFalse) = return (VBool False)
  evalExpr (EString s) = return (VStr s)
  evalExpr (Neg expr) = evalExpr $ EMul (ELitInt $ 0 - 1) Times expr
  evalExpr (Not expr) = do
    val <- evalExpr expr
    case val of
      (VBool True)  -> return (VBool False)
      (VBool False) -> return (VBool True)
      otherwise     -> throwError "Trying to negate a non-boolean value"
  evalExpr (EMul expr1 mulOp expr2) = do
    (VInt val1) <- concrete expr1
    (VInt val2) <- concrete expr2
    case mulOp of
      Times -> return $ VInt $ val1 * val2
      Div -> do
        case val2 of
          0         -> throwError $ "Division by zero"
          otherwise -> return $ VInt $ val1 `div` val2
      Mod -> return $ VInt $ val1 `mod` val2
  evalExpr (EAdd expr1 addOp expr2) = do
    (VInt val1) <- concrete expr1
    (VInt val2) <- concrete expr2
    case addOp of
      Plus  -> return $ VInt $ val1 + val2
      Minus -> return $ VInt $ val1 - val2
  evalExpr (ERel expr1 relOp expr2) = do
    (VInt val1) <- concrete expr1
    (VInt val2) <- concrete expr2
    case relOp of
      LTH -> return $ VBool $ val1 < val2
      LE  -> return $ VBool $ val1 <= val2
      GTH -> return $ VBool $ val1 > val2
      GE  -> return $ VBool $ val1 >= val2
      EQU -> return $ VBool $ val1 == val2
      NE  -> return $ VBool $ val1 /= val2
  evalExpr (EAnd expr1 expr2) = do
    (VBool val1) <- concrete expr1
    (VBool val2) <- concrete expr2
    return $ VBool $ val1 && val2
  evalExpr (EOr expr1 expr2) = do
    (VBool val1) <- concrete expr1
    (VBool val2) <- concrete expr2
    return $ VBool $ val1 || val2
  evalExpr (GNext ident) = do
    localEnv <- getEnv
    case Map.lookup ident localEnv of
      Nothing -> throwError $ "Function " ++ showId ident ++ " is undefined"
      Just loc -> do
        store <- getStore
        case Map.lookup loc store of
          Nothing ->
            throwError $
            "Trying to use a dangling pointer to function " ++ showId ident
          Just func -> runGen ident func
  evalExpr (EApp ident exprs) = do
    localEnv <- getEnv
    case Map.lookup ident localEnv of
      Nothing -> throwError $ "Function " ++ showId ident ++ " is undefined"
      Just loc -> do
        store <- getStore
        case Map.lookup loc store of
          Nothing ->
            throwError $
            "Trying to use a dangling pointer to function " ++ showId ident
          Just func -> runFunc ident loc func exprs
  
  -- params: name of the function, location where the function is defined,
  --         function to run, argument values
  runFunc :: Ident -> Loc -> Value -> [Expr] -> ExecM Value
  runFunc ident loc func exprs = do
    case func of
      (VFunc typ args stmts env isGen) -> do
        if (length args) /= (length exprs)
          then throwError $
               "Wrong number of arguments applied to function " ++ showId ident
          else do
            localEnv <- getEnv
            let unionEnv = Map.union env localEnv
            let recurEnv = Map.insert ident loc unionEnv
            argEnv <- putArgs args exprs recurEnv
            store <- getStore
            putStore $ Map.insert loc (VFunc typ args stmts argEnv isGen) store
            local (\_ -> (Env argEnv ident)) (runStmts stmts)
      otherwise ->
        throwError $ "Trying to apply arguments to non-function " ++ showId ident
  
  runGen :: Ident -> Value -> ExecM Value
  runGen ident func = do
    case func of
      (VFunc typ args stmts env True) -> do
        case stmts of
          [] -> throwError $ "Generator " ++ showId ident ++ " has finished"
          otherwise -> local (\_ -> (Env env ident)) (runStmts stmts)
      otherwise -> throwError $ showId ident ++ " is not a generator"
  
  putArgs :: [Arg] -> [Expr] -> Bindings -> ExecM Bindings
  putArgs [] _ env = return env
  putArgs _ [] env = return env
  putArgs (arg:args) (expr:exprs) env =
    case arg of
      Val typ ident -> do
        val <- concrete expr
        loc <- newloc
        store <- getStore
        putStore $ Map.insert loc val store
        putArgs args exprs (Map.insert ident loc env)
      Ref typ ident ->
        case expr of
          (EVar refIdent) -> do
            localEnv <- getEnv
            case Map.lookup refIdent localEnv of
              Nothing  -> throwError "Undefined reference argument"
              Just loc -> putArgs args exprs (Map.insert ident loc env)
          otherwise ->
            throwError "Trying to use non variable as reference argument"