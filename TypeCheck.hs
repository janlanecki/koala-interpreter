module TypeCheck where

  import           AbsKoala
  import           PrintKoala         (printTree)
  import           ErrM
  import           LexKoala           (tokens)
  import           ParKoala           (pProgram)
  
  import           Control.Monad.Except
  import           Control.Monad.Reader
  import           Data.Map             (Map)
  import qualified Data.Map             as Map

  type Env = Map Ident Type
  type TCM a = ExceptT String (ReaderT Env IO) a

  typeCheck :: Program -> IO (Either String ())
  typeCheck program = runReaderT (runExceptT (interpret program)) Map.empty
  
  interpret :: Program -> TCM ()
  interpret (Program topDefs) = do
    checkTopDefs topDefs
    return ()

  checkTopDefs :: [TopDef] -> TCM ()
  checkTopDefs [] = return ()
  checkTopDefs topDefs = do
    checkTopDefsMainLast topDefs Nothing Map.empty
    return ()
    where
      checkTopDefsMainLast :: [TopDef] -> Maybe TopDef -> Env -> TCM Env
      checkTopDefsMainLast [] Nothing env = return env
      checkTopDefsMainLast [] (Just topDef) env = do
        checkTopDef topDef env
        return env
      checkTopDefsMainLast (topDef:topDefs) mainDef env = do
        let FnDef typ ident args (Block stmts) = topDef
        if ident == (Ident "main")
          then checkTopDefsMainLast topDefs (Just topDef) env
          else do
            checkTopDef topDef env
            funcType <- getFuncType typ args
            let newEnv = Map.insert ident funcType env
            checkTopDefsMainLast topDefs mainDef newEnv

  checkTopDef :: TopDef -> Env -> TCM ()
  checkTopDef (FnDef typ ident args (Block stmts)) env = 
    local (\_ -> env) (checkFunc typ ident args stmts  )
  
  runBlock :: Block -> TCM ()
  runBlock (Block []) = return ()
  runBlock (Block stmts) = do
    env <- ask
    local (\_ -> env) (runStmts stmts)
  
  runStmts :: [Stmt] -> TCM ()
  runStmts [] = return ()
  runStmts stmts = do
    case (head stmts) of
      (Decl typ items) -> do
        env <- ask
        newEnv <- declare typ items env
        local (\_ -> newEnv) (runStmts $ tail stmts)
      (FDecl typ ident args (Block bstmts)) -> do
        checkFunc typ ident args bstmts
        env <- ask
        funcType <- getFuncType typ args
        local (\_ -> Map.insert ident funcType env) (runStmts $ tail stmts)
      (GDecl typ ident args (Block bstmts)) -> do
        checkFunc typ ident args bstmts
        env <- ask
        funcType <- getFuncType typ args
        local (\_ -> Map.insert ident funcType env) (runStmts $ tail stmts)
      (Ret expr) -> do
        env <- ask
        case Map.lookup (Ident "_this") env of
          Nothing -> throwError $ "Return statement not inside a function body"
          Just typ -> do
            case typ of
              Int -> checkInt expr
              Bool -> checkBool expr
              Str -> checkStr expr
              Void -> throwError "Trying to return value from void function"
      VRet -> do
        env <- ask
        case Map.lookup (Ident "_this") env of
          Nothing -> throwError "Return statement not inside a function body"
          Just typ -> do
            case typ of
              Void -> return ()
              otherwise -> throwError "Empty return statement"
      (Yield expr) -> do
        env <- ask
        case Map.lookup (Ident "_this") env of
          Nothing -> throwError $ "Yield statement not inside a function body"
          Just typ -> do
            case typ of
              Int -> checkInt expr
              Bool -> checkBool expr
              Str -> checkStr expr
              Void -> throwError $ "Trying to return value from void function"
      otherwise -> do
        runStmt $ head stmts
        runStmts $ tail stmts
  
  declare :: Type -> [Item] -> Env -> TCM Env
  declare typ [] env = return env
  declare typ (item:items) env = do
    case item of
      (NoInit ident) -> declare typ items (Map.insert ident typ env)
      (Init ident expr) -> do
        case typ of
          Int -> checkInt expr
          Str -> checkStr expr
          Bool -> checkBool expr
          otherwise -> throwError $ "Trying to an unassignable variable"
        declare typ items (Map.insert ident typ env)

  runStmt :: Stmt -> TCM ()
  runStmt Empty = return ()
  runStmt (BStmt block) = runBlock block
  runStmt (PrintI expr) = do 
    checkInt expr
    return ()
  runStmt (PrintB expr) = do
    checkBool expr
    return ()
  runStmt (PrintS expr) = do
    checkStr expr
    return ()
  runStmt (Ass ident expr) = do
    env <- ask
    case Map.lookup ident env of
      Nothing -> throwError $ "Variable " ++ showId ident ++ " undefined"
      Just Int -> checkInt expr
      Just Bool -> checkBool expr
      Just Str -> checkStr expr
      otherwise -> throwError $ "Assigning to an unassignable variable"
    return ()
  runStmt (Incr ident) = do
    env <- ask
    case Map.lookup ident env of 
      Nothing -> throwError $ "Variable " ++ showId ident ++ " undefined"
      Just Int -> return ()
      Just realType -> 
        throwError $ "Trying to decrement non int variable " ++ showId ident
  runStmt (Decr ident) = do
    env <- ask
    case Map.lookup ident env of 
      Nothing -> throwError $ "Variable " ++ showId ident ++ " undefined"
      Just Int -> return ()
      Just realType -> 
        throwError $ "Trying to decrement non int variable " ++ showId ident
  runStmt (Cond expr stmt) = do
    checkBool expr
    runStmts [stmt]
  runStmt (CondElse expr stmt1 stmt2) = do
    checkBool expr
    runStmts [stmt1]
    runStmts [stmt2]
  runStmt (While expr stmt) = do
    checkBool expr
    runStmts [stmt]
  runStmt (SExp expr) = do
    typeOf0 expr
    return ()
  runStmt _ = return ()
  
  showId :: Ident -> String
  showId (Ident name) = name
  
  typeError :: Type -> Type -> Expr -> TCM ()
  typeError expected got message =
    throwError $ "Expected type: " ++ printTree expected
      ++ " got: " ++ printTree got
      ++ "\nin expression: " ++ printTree message
    
  checkInt :: Expr -> TCM ()
  checkInt expr = do
    exprType <- typeOf0 expr
    env <- ask
    case exprType of
      Int -> return ()
      otherwise -> typeError Int exprType expr

  checkBool :: Expr -> TCM ()
  checkBool expr = do
    exprType <- typeOf0 expr
    case exprType of
      Bool -> return ()
      otherwise -> typeError Bool exprType expr

  checkStr :: Expr -> TCM ()
  checkStr expr = do
    exprType <- typeOf0 expr
    case exprType of
      Str -> return ()
      otherwise -> typeError Str exprType expr

  typeOf0 :: Expr -> TCM Type
  typeOf0 (EVar ident) = do
    env <- ask
    case Map.lookup ident env of
      Nothing -> throwError $ "Undefined variable " ++ showId ident
      Just typ -> return typ
  typeOf0 (ELitInt _) = return Int
  typeOf0 (ELitTrue) = return Bool
  typeOf0 (ELitFalse) = return Bool
  typeOf0 (EString _) = return Str
  typeOf0 (Neg expr) = do 
    checkInt expr
    return Int
  typeOf0 (Not expr) = do 
    checkBool expr
    return Bool
  typeOf0 (EMul expr1 mulOp expr2) = do
    exprType <- typeOf0 expr1
    case exprType of
      Int -> checkInt expr2
      otherwise -> typeError Int exprType expr1
    return Int
  typeOf0 (EAdd expr1 addOp expr2) = do
    exprType <- typeOf0 expr1
    case exprType of
      Int -> checkInt expr2
      otherwise -> typeError Int exprType expr1
    return Int
  typeOf0 (ERel expr1 relOp expr2) = do
    exprType <- typeOf0 expr1
    case exprType of
      Int -> checkInt expr2
      otherwise -> typeError Int exprType expr1
    return Bool
  typeOf0 (EAnd expr1 expr2) = do
    exprType <- typeOf0 expr1
    case exprType of
      Bool -> checkBool expr2
      otherwise -> typeError Bool exprType expr1
    return Bool
  typeOf0 (EOr expr1 expr2) = do
    exprType <- typeOf0 expr1
    case exprType of
      Bool -> checkBool expr2
      otherwise -> typeError Bool exprType expr1
    return Bool
  typeOf0 (GNext ident) = do
    env <- ask
    case Map.lookup ident env of
      Nothing -> throwError $ "Function " ++ showId ident ++ "undefined"
      Just (Fun typ types) -> return typ
      otherwise -> throwError $ (showId ident) ++ " is not a generator"
  typeOf0 (EApp ident exprs) = do 
    env <- ask
    case Map.lookup ident env of
      Nothing -> throwError $ "Function " ++ showId ident ++ "undefined"
      Just (Fun typ types) -> do
        typesMatch <- checkTypesMatch types exprs 
        if typesMatch
          then return typ
          else throwError $ "Function argument type does not match"
      otherwise -> throwError $ showId ident ++ " is not a function"

  checkTypesMatch :: [Type] -> [Expr] -> TCM Bool
  checkTypesMatch [] [] = return True
  checkTypesMatch (typ:types) (expr:exprs) = do
    exprType <- typeOf0 expr
    if typ == exprType
      then checkTypesMatch types exprs
      else do 
        typeError typ exprType expr
        return False
  checkTypesMatch _ _ = throwError $ "Provided incorrect number of arguments"

  checkFunc :: Type -> Ident -> [Arg] -> [Stmt] -> TCM ()
  checkFunc typ ident args stmts = do
    env <- ask
    funcType <- getFuncType typ args
    argEnv <- putArgTypes args env
    let newEnv = Map.insert (Ident "_this") typ argEnv
    let recEnv = Map.insert ident funcType newEnv
    local (\_ -> recEnv) (runStmts stmts)

  getFuncType :: Type -> [Arg] -> TCM Type
  getFuncType typ [] = return $ Fun typ []
  getFuncType typ args = do
    argTypes <- getArgTypes args []
    return $ Fun typ argTypes
      where
        getArgTypes :: [Arg] -> [Type] -> TCM [Type]
        getArgTypes [] types = return types
        getArgTypes (arg:args) types = do
          case arg of
            Val typ ident -> getArgTypes args (types ++ [typ])
            Ref typ ident -> getArgTypes args (types ++ [typ])

  putArgTypes :: [Arg] -> Env -> TCM Env
  putArgTypes [] env = return env
  putArgTypes (arg:args) env = do
    case arg of
      Val typ ident ->
        putArgTypes args (Map.insert ident typ env)
      Ref typ ident ->
        putArgTypes args (Map.insert ident typ env)
