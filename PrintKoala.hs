{-# LANGUAGE FlexibleInstances, OverlappingInstances #-}
{-# OPTIONS_GHC -fno-warn-incomplete-patterns #-}

-- | Pretty-printer for PrintKoala.
--   Generated by the BNF converter.

module PrintKoala where

import AbsKoala
import Data.Char

-- | The top-level printing method.

printTree :: Print a => a -> String
printTree = render . prt 0

type Doc = [ShowS] -> [ShowS]

doc :: ShowS -> Doc
doc = (:)

render :: Doc -> String
render d = rend 0 (map ($ "") $ d []) "" where
  rend i ss = case ss of
    "["      :ts -> showChar '[' . rend i ts
    "("      :ts -> showChar '(' . rend i ts
    "{"      :ts -> showChar '{' . new (i+1) . rend (i+1) ts
    "}" : ";":ts -> new (i-1) . space "}" . showChar ';' . new (i-1) . rend (i-1) ts
    "}"      :ts -> new (i-1) . showChar '}' . new (i-1) . rend (i-1) ts
    ";"      :ts -> showChar ';' . new i . rend i ts
    t  : ts@(p:_) | closingOrPunctuation p -> showString t . rend i ts
    t        :ts -> space t . rend i ts
    _            -> id
  new i   = showChar '\n' . replicateS (2*i) (showChar ' ') . dropWhile isSpace
  space t = showString t . (\s -> if null s then "" else ' ':s)

  closingOrPunctuation :: String -> Bool
  closingOrPunctuation [c] = c `elem` closerOrPunct
  closingOrPunctuation _   = False

  closerOrPunct :: String
  closerOrPunct = ")],;"

parenth :: Doc -> Doc
parenth ss = doc (showChar '(') . ss . doc (showChar ')')

concatS :: [ShowS] -> ShowS
concatS = foldr (.) id

concatD :: [Doc] -> Doc
concatD = foldr (.) id

replicateS :: Int -> ShowS -> ShowS
replicateS n f = concatS (replicate n f)

-- | The printer class does the job.

class Print a where
  prt :: Int -> a -> Doc
  prtList :: Int -> [a] -> Doc
  prtList i = concatD . map (prt i)

instance Print a => Print [a] where
  prt = prtList

instance Print Char where
  prt _ s = doc (showChar '\'' . mkEsc '\'' s . showChar '\'')
  prtList _ s = doc (showChar '"' . concatS (map (mkEsc '"') s) . showChar '"')

mkEsc :: Char -> Char -> ShowS
mkEsc q s = case s of
  _ | s == q -> showChar '\\' . showChar s
  '\\'-> showString "\\\\"
  '\n' -> showString "\\n"
  '\t' -> showString "\\t"
  _ -> showChar s

prPrec :: Int -> Int -> Doc -> Doc
prPrec i j = if j < i then parenth else id

instance Print Integer where
  prt _ x = doc (shows x)

instance Print Double where
  prt _ x = doc (shows x)

instance Print Ident where
  prt _ (Ident i) = doc (showString i)

instance Print Program where
  prt i e = case e of
    Program topdefs -> prPrec i 0 (concatD [prt 0 topdefs])

instance Print TopDef where
  prt i e = case e of
    FnDef type_ id args block -> prPrec i 0 (concatD [prt 0 type_, prt 0 id, doc (showString "("), prt 0 args, doc (showString ")"), prt 0 block])
  prtList _ [x] = concatD [prt 0 x]
  prtList _ (x:xs) = concatD [prt 0 x, prt 0 xs]

instance Print [TopDef] where
  prt = prtList

instance Print Arg where
  prt i e = case e of
    Val type_ id -> prPrec i 0 (concatD [prt 0 type_, prt 0 id])
    Ref type_ id -> prPrec i 0 (concatD [prt 0 type_, doc (showString "&"), prt 0 id])
  prtList _ [] = concatD []
  prtList _ [x] = concatD [prt 0 x]
  prtList _ (x:xs) = concatD [prt 0 x, doc (showString ","), prt 0 xs]

instance Print [Arg] where
  prt = prtList

instance Print Block where
  prt i e = case e of
    Block stmts -> prPrec i 0 (concatD [doc (showString "{"), prt 0 stmts, doc (showString "}")])

instance Print [Stmt] where
  prt = prtList

instance Print Stmt where
  prt i e = case e of
    Empty -> prPrec i 0 (concatD [doc (showString ";")])
    BStmt block -> prPrec i 0 (concatD [prt 0 block])
    Decl type_ items -> prPrec i 0 (concatD [prt 0 type_, prt 0 items, doc (showString ";")])
    FDecl type_ id args block -> prPrec i 0 (concatD [prt 0 type_, prt 0 id, doc (showString "("), prt 0 args, doc (showString ")"), prt 0 block])
    GDecl type_ id args block -> prPrec i 0 (concatD [doc (showString "generator"), prt 0 type_, prt 0 id, doc (showString "("), prt 0 args, doc (showString ")"), prt 0 block])
    Ass id expr -> prPrec i 0 (concatD [prt 0 id, doc (showString "="), prt 0 expr, doc (showString ";")])
    Incr id -> prPrec i 0 (concatD [prt 0 id, doc (showString "++"), doc (showString ";")])
    Decr id -> prPrec i 0 (concatD [prt 0 id, doc (showString "--"), doc (showString ";")])
    Ret expr -> prPrec i 0 (concatD [doc (showString "return"), prt 0 expr, doc (showString ";")])
    VRet -> prPrec i 0 (concatD [doc (showString "return"), doc (showString ";")])
    Yield expr -> prPrec i 0 (concatD [doc (showString "yield"), prt 0 expr, doc (showString ";")])
    Cond expr stmt -> prPrec i 0 (concatD [doc (showString "if"), doc (showString "("), prt 0 expr, doc (showString ")"), prt 0 stmt])
    CondElse expr stmt1 stmt2 -> prPrec i 0 (concatD [doc (showString "if"), doc (showString "("), prt 0 expr, doc (showString ")"), prt 0 stmt1, doc (showString "else"), prt 0 stmt2])
    While expr stmt -> prPrec i 0 (concatD [doc (showString "while"), doc (showString "("), prt 0 expr, doc (showString ")"), prt 0 stmt])
    Break -> prPrec i 0 (concatD [doc (showString "break"), doc (showString ";")])
    Cont -> prPrec i 0 (concatD [doc (showString "continue"), doc (showString ";")])
    SExp expr -> prPrec i 0 (concatD [prt 0 expr, doc (showString ";")])
    PrintI expr -> prPrec i 0 (concatD [doc (showString "printInt"), doc (showString "("), prt 0 expr, doc (showString ")"), doc (showString ";")])
    PrintB expr -> prPrec i 0 (concatD [doc (showString "printBool"), doc (showString "("), prt 0 expr, doc (showString ")"), doc (showString ";")])
    PrintS expr -> prPrec i 0 (concatD [doc (showString "printString"), doc (showString "("), prt 0 expr, doc (showString ")"), doc (showString ";")])
  prtList _ [] = concatD []
  prtList _ (x:xs) = concatD [prt 0 x, prt 0 xs]

instance Print Index where
  prt i e = case e of
    Index expr -> prPrec i 0 (concatD [doc (showString "["), prt 0 expr, doc (showString "]")])
  prtList _ [x] = concatD [prt 0 x]
  prtList _ (x:xs) = concatD [prt 0 x, prt 0 xs]

instance Print [Index] where
  prt = prtList

instance Print Item where
  prt i e = case e of
    NoInit id -> prPrec i 0 (concatD [prt 0 id])
    Init id expr -> prPrec i 0 (concatD [prt 0 id, doc (showString "="), prt 0 expr])
  prtList _ [x] = concatD [prt 0 x]
  prtList _ (x:xs) = concatD [prt 0 x, doc (showString ","), prt 0 xs]

instance Print [Item] where
  prt = prtList

instance Print Type where
  prt i e = case e of
    Int -> prPrec i 0 (concatD [doc (showString "int")])
    Str -> prPrec i 0 (concatD [doc (showString "string")])
    Bool -> prPrec i 0 (concatD [doc (showString "boolean")])
    Void -> prPrec i 0 (concatD [doc (showString "void")])
    Fun type_ types -> prPrec i 0 (concatD [prt 0 type_, doc (showString "("), prt 0 types, doc (showString ")")])
  prtList _ [] = concatD []
  prtList _ [x] = concatD [prt 0 x]
  prtList _ (x:xs) = concatD [prt 0 x, doc (showString ","), prt 0 xs]

instance Print [Type] where
  prt = prtList

instance Print Expr where
  prt i e = case e of
    EVar id -> prPrec i 6 (concatD [prt 0 id])
    ELitInt n -> prPrec i 6 (concatD [prt 0 n])
    ELitTrue -> prPrec i 6 (concatD [doc (showString "true")])
    ELitFalse -> prPrec i 6 (concatD [doc (showString "false")])
    EApp id exprs -> prPrec i 6 (concatD [prt 0 id, doc (showString "("), prt 0 exprs, doc (showString ")")])
    GNext id -> prPrec i 6 (concatD [doc (showString "next"), doc (showString "("), prt 0 id, doc (showString ")")])
    EString str -> prPrec i 6 (concatD [prt 0 str])
    Neg expr -> prPrec i 5 (concatD [doc (showString "-"), prt 6 expr])
    Not expr -> prPrec i 5 (concatD [doc (showString "!"), prt 6 expr])
    EMul expr1 mulop expr2 -> prPrec i 4 (concatD [prt 4 expr1, prt 0 mulop, prt 5 expr2])
    EAdd expr1 addop expr2 -> prPrec i 3 (concatD [prt 3 expr1, prt 0 addop, prt 4 expr2])
    ERel expr1 relop expr2 -> prPrec i 2 (concatD [prt 2 expr1, prt 0 relop, prt 3 expr2])
    EAnd expr1 expr2 -> prPrec i 1 (concatD [prt 2 expr1, doc (showString "&&"), prt 1 expr2])
    EOr expr1 expr2 -> prPrec i 0 (concatD [prt 1 expr1, doc (showString "||"), prt 0 expr2])
  prtList _ [] = concatD []
  prtList _ [x] = concatD [prt 0 x]
  prtList _ (x:xs) = concatD [prt 0 x, doc (showString ","), prt 0 xs]

instance Print [Expr] where
  prt = prtList

instance Print AddOp where
  prt i e = case e of
    Plus -> prPrec i 0 (concatD [doc (showString "+")])
    Minus -> prPrec i 0 (concatD [doc (showString "-")])

instance Print MulOp where
  prt i e = case e of
    Times -> prPrec i 0 (concatD [doc (showString "*")])
    Div -> prPrec i 0 (concatD [doc (showString "/")])
    Mod -> prPrec i 0 (concatD [doc (showString "%")])

instance Print RelOp where
  prt i e = case e of
    LTH -> prPrec i 0 (concatD [doc (showString "<")])
    LE -> prPrec i 0 (concatD [doc (showString "<=")])
    GTH -> prPrec i 0 (concatD [doc (showString ">")])
    GE -> prPrec i 0 (concatD [doc (showString ">=")])
    EQU -> prPrec i 0 (concatD [doc (showString "==")])
    NE -> prPrec i 0 (concatD [doc (showString "!=")])

