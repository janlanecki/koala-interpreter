{-# OPTIONS_GHC -w #-}
{-# OPTIONS_GHC -fno-warn-incomplete-patterns -fno-warn-overlapping-patterns #-}
module ParKoala where
import AbsKoala
import LexKoala
import ErrM
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.19.9

data HappyAbsSyn 
	= HappyTerminal (Token)
	| HappyErrorToken Int
	| HappyAbsSyn4 (Ident)
	| HappyAbsSyn5 (Integer)
	| HappyAbsSyn6 (String)
	| HappyAbsSyn7 (Program)
	| HappyAbsSyn8 (TopDef)
	| HappyAbsSyn9 ([TopDef])
	| HappyAbsSyn10 (Arg)
	| HappyAbsSyn11 ([Arg])
	| HappyAbsSyn12 (Block)
	| HappyAbsSyn13 ([Stmt])
	| HappyAbsSyn14 (Stmt)
	| HappyAbsSyn15 (Index)
	| HappyAbsSyn16 ([Index])
	| HappyAbsSyn17 (Item)
	| HappyAbsSyn18 ([Item])
	| HappyAbsSyn19 (Type)
	| HappyAbsSyn20 ([Type])
	| HappyAbsSyn21 (Expr)
	| HappyAbsSyn28 ([Expr])
	| HappyAbsSyn29 (AddOp)
	| HappyAbsSyn30 (MulOp)
	| HappyAbsSyn31 (RelOp)

{- to allow type-synonyms as our monads (likely
 - with explicitly-specified bind and return)
 - in Haskell98, it seems that with
 - /type M a = .../, then /(HappyReduction M)/
 - is not allowed.  But Happy is a
 - code-generator that can just substitute it.
type HappyReduction m = 
	   Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> m HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> m HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> [(Token)] -> m HappyAbsSyn
-}

action_0,
 action_1,
 action_2,
 action_3,
 action_4,
 action_5,
 action_6,
 action_7,
 action_8,
 action_9,
 action_10,
 action_11,
 action_12,
 action_13,
 action_14,
 action_15,
 action_16,
 action_17,
 action_18,
 action_19,
 action_20,
 action_21,
 action_22,
 action_23,
 action_24,
 action_25,
 action_26,
 action_27,
 action_28,
 action_29,
 action_30,
 action_31,
 action_32,
 action_33,
 action_34,
 action_35,
 action_36,
 action_37,
 action_38,
 action_39,
 action_40,
 action_41,
 action_42,
 action_43,
 action_44,
 action_45,
 action_46,
 action_47,
 action_48,
 action_49,
 action_50,
 action_51,
 action_52,
 action_53,
 action_54,
 action_55,
 action_56,
 action_57,
 action_58,
 action_59,
 action_60,
 action_61,
 action_62,
 action_63,
 action_64,
 action_65,
 action_66,
 action_67,
 action_68,
 action_69,
 action_70,
 action_71,
 action_72,
 action_73,
 action_74,
 action_75,
 action_76,
 action_77,
 action_78,
 action_79,
 action_80,
 action_81,
 action_82,
 action_83,
 action_84,
 action_85,
 action_86,
 action_87,
 action_88,
 action_89,
 action_90,
 action_91,
 action_92,
 action_93,
 action_94,
 action_95,
 action_96,
 action_97,
 action_98,
 action_99,
 action_100,
 action_101,
 action_102,
 action_103,
 action_104,
 action_105,
 action_106,
 action_107,
 action_108,
 action_109,
 action_110,
 action_111,
 action_112,
 action_113,
 action_114,
 action_115,
 action_116,
 action_117,
 action_118,
 action_119,
 action_120,
 action_121,
 action_122,
 action_123,
 action_124,
 action_125,
 action_126,
 action_127,
 action_128,
 action_129,
 action_130,
 action_131,
 action_132,
 action_133,
 action_134,
 action_135,
 action_136,
 action_137,
 action_138,
 action_139,
 action_140,
 action_141,
 action_142,
 action_143,
 action_144,
 action_145,
 action_146,
 action_147,
 action_148,
 action_149 :: () => Int -> ({-HappyReduction (Err) = -}
	   Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Err) HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Err) HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> [(Token)] -> (Err) HappyAbsSyn)

happyReduce_1,
 happyReduce_2,
 happyReduce_3,
 happyReduce_4,
 happyReduce_5,
 happyReduce_6,
 happyReduce_7,
 happyReduce_8,
 happyReduce_9,
 happyReduce_10,
 happyReduce_11,
 happyReduce_12,
 happyReduce_13,
 happyReduce_14,
 happyReduce_15,
 happyReduce_16,
 happyReduce_17,
 happyReduce_18,
 happyReduce_19,
 happyReduce_20,
 happyReduce_21,
 happyReduce_22,
 happyReduce_23,
 happyReduce_24,
 happyReduce_25,
 happyReduce_26,
 happyReduce_27,
 happyReduce_28,
 happyReduce_29,
 happyReduce_30,
 happyReduce_31,
 happyReduce_32,
 happyReduce_33,
 happyReduce_34,
 happyReduce_35,
 happyReduce_36,
 happyReduce_37,
 happyReduce_38,
 happyReduce_39,
 happyReduce_40,
 happyReduce_41,
 happyReduce_42,
 happyReduce_43,
 happyReduce_44,
 happyReduce_45,
 happyReduce_46,
 happyReduce_47,
 happyReduce_48,
 happyReduce_49,
 happyReduce_50,
 happyReduce_51,
 happyReduce_52,
 happyReduce_53,
 happyReduce_54,
 happyReduce_55,
 happyReduce_56,
 happyReduce_57,
 happyReduce_58,
 happyReduce_59,
 happyReduce_60,
 happyReduce_61,
 happyReduce_62,
 happyReduce_63,
 happyReduce_64,
 happyReduce_65,
 happyReduce_66,
 happyReduce_67,
 happyReduce_68,
 happyReduce_69,
 happyReduce_70,
 happyReduce_71,
 happyReduce_72,
 happyReduce_73,
 happyReduce_74,
 happyReduce_75,
 happyReduce_76,
 happyReduce_77,
 happyReduce_78,
 happyReduce_79,
 happyReduce_80,
 happyReduce_81,
 happyReduce_82,
 happyReduce_83,
 happyReduce_84 :: () => ({-HappyReduction (Err) = -}
	   Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Err) HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Err) HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> [(Token)] -> (Err) HappyAbsSyn)

happyExpList :: Happy_Data_Array.Array Int Int
happyExpList = Happy_Data_Array.listArray (0,465) ([0,0,0,8256,40,0,0,0,0,1024,0,0,0,0,0,0,0,0,0,0,0,0,0,33284,2,0,0,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,512,0,0,0,0,0,0,0,0,0,0,512,321,0,0,2048,0,0,0,0,64,0,0,0,0,4,0,2048,0,0,0,0,0,0,0,0,0,512,0,0,0,0,32,0,0,0,33284,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2112,57362,65534,30,0,17408,66,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4096,0,0,0,0,0,0,0,0,0,0,0,32768,1040,0,0,0,0,144,0,0,0,36864,60416,0,0,0,0,0,0,16,0,0,128,0,0,0,8192,0,8328,112,0,4224,4,4164,56,0,2048,0,2082,28,0,0,0,0,0,0,0,4,0,0,0,0,2,0,0,0,0,0,0,0,0,0,33024,160,0,0,32,0,0,0,0,16,0,0,0,0,8,0,0,0,0,4,0,0,0,0,2,0,0,0,2048,577,1088,897,0,0,0,0,0,0,16384,0,0,0,0,8448,8,8328,112,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,512,0,0,0,0,0,2,0,0,0,8324,8192,49282,1,0,32768,0,0,0,0,0,0,0,0,32768,1040,17408,14352,0,16384,520,8704,7176,0,8192,260,4352,3588,0,0,0,0,256,0,2048,65,1088,897,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4096,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16648,16384,33028,3,0,8324,8192,49282,1,0,0,0,0,0,0,2081,34816,28704,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,33792,32,33312,448,0,0,0,0,0,0,0,0,0,0,0,4224,4,4164,56,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,256,16,0,0,0,4096,0,0,0,0,32768,0,0,0,0,2081,34816,28704,0,0,8192,0,0,0,0,4096,0,0,0,8192,260,4352,3588,0,0,1024,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,16384,0,0,0,0,0,0,0,0,0,0,0,0,4,0,0,4096,2568,0,0,33296,32768,520,7,0,0,0,0,0,0,33296,0,0,0,0,0,0,0,0,0,2304,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,0,4,0,0,0,0,2,0,0,0,0,1,0,0,0,32768,0,0,0,0,16384,0,0,0,0,0,0,0,0,0,4096,0,0,0,0,0,0,0,0,0,33296,47108,16383,7,0,0,2,0,0,0,0,1,0,0,0,32768,0,0,0,0,0,0,0,0,32768,9232,64960,14847,0,0,0,4128,20,0,0,0,0,0,0,0,4,0,0,0,0,4096,0,0,0,0,0,0,0,0,0,0,0,0,0,8448,8,8328,112,0,0,0,0,0,0,0,0,0,0,0,0,0,16384,0,0,1024,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16384,4616,65248,7423,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_pProgram","Ident","Integer","String","Program","TopDef","ListTopDef","Arg","ListArg","Block","ListStmt","Stmt","Index","ListIndex","Item","ListItem","Type","ListType","Expr6","Expr5","Expr4","Expr3","Expr2","Expr1","Expr","ListExpr","AddOp","MulOp","RelOp","'!'","'!='","'%'","'&'","'&&'","'('","')'","'*'","'+'","'++'","','","'-'","'--'","'/'","';'","'<'","'<='","'='","'=='","'>'","'>='","'['","']'","'boolean'","'break'","'continue'","'else'","'false'","'generator'","'if'","'int'","'next'","'printBool'","'printInt'","'printString'","'return'","'string'","'true'","'void'","'while'","'yield'","'{'","'||'","'}'","L_ident","L_integ","L_quoted","%eof"]
        bit_start = st * 79
        bit_end = (st + 1) * 79
        read_bit = readArrayBit happyExpList
        bits = map read_bit [bit_start..bit_end - 1]
        bits_indexed = zip bits [0..78]
        token_strs_expected = concatMap f bits_indexed
        f (False, _) = []
        f (True, nr) = [token_strs !! nr]

action_0 (55) = happyShift action_7
action_0 (62) = happyShift action_8
action_0 (68) = happyShift action_9
action_0 (70) = happyShift action_10
action_0 (7) = happyGoto action_3
action_0 (8) = happyGoto action_4
action_0 (9) = happyGoto action_5
action_0 (19) = happyGoto action_6
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (76) = happyShift action_2
action_1 _ = happyFail (happyExpListPerState 1)

action_2 _ = happyReduce_1

action_3 (79) = happyAccept
action_3 _ = happyFail (happyExpListPerState 3)

action_4 (55) = happyShift action_7
action_4 (62) = happyShift action_8
action_4 (68) = happyShift action_9
action_4 (70) = happyShift action_10
action_4 (8) = happyGoto action_4
action_4 (9) = happyGoto action_12
action_4 (19) = happyGoto action_6
action_4 _ = happyReduce_6

action_5 _ = happyReduce_4

action_6 (76) = happyShift action_2
action_6 (4) = happyGoto action_11
action_6 _ = happyFail (happyExpListPerState 6)

action_7 _ = happyReduce_45

action_8 _ = happyReduce_43

action_9 _ = happyReduce_44

action_10 _ = happyReduce_46

action_11 (37) = happyShift action_13
action_11 _ = happyFail (happyExpListPerState 11)

action_12 _ = happyReduce_7

action_13 (55) = happyShift action_7
action_13 (62) = happyShift action_8
action_13 (68) = happyShift action_9
action_13 (70) = happyShift action_10
action_13 (10) = happyGoto action_14
action_13 (11) = happyGoto action_15
action_13 (19) = happyGoto action_16
action_13 _ = happyReduce_10

action_14 (42) = happyShift action_20
action_14 _ = happyReduce_11

action_15 (38) = happyShift action_19
action_15 _ = happyFail (happyExpListPerState 15)

action_16 (35) = happyShift action_18
action_16 (76) = happyShift action_2
action_16 (4) = happyGoto action_17
action_16 _ = happyFail (happyExpListPerState 16)

action_17 _ = happyReduce_8

action_18 (76) = happyShift action_2
action_18 (4) = happyGoto action_24
action_18 _ = happyFail (happyExpListPerState 18)

action_19 (73) = happyShift action_23
action_19 (12) = happyGoto action_22
action_19 _ = happyFail (happyExpListPerState 19)

action_20 (55) = happyShift action_7
action_20 (62) = happyShift action_8
action_20 (68) = happyShift action_9
action_20 (70) = happyShift action_10
action_20 (10) = happyGoto action_14
action_20 (11) = happyGoto action_21
action_20 (19) = happyGoto action_16
action_20 _ = happyReduce_10

action_21 _ = happyReduce_12

action_22 _ = happyReduce_5

action_23 (13) = happyGoto action_25
action_23 _ = happyReduce_14

action_24 _ = happyReduce_9

action_25 (32) = happyShift action_39
action_25 (37) = happyShift action_40
action_25 (43) = happyShift action_41
action_25 (46) = happyShift action_42
action_25 (55) = happyShift action_7
action_25 (56) = happyShift action_43
action_25 (57) = happyShift action_44
action_25 (59) = happyShift action_45
action_25 (60) = happyShift action_46
action_25 (61) = happyShift action_47
action_25 (62) = happyShift action_8
action_25 (63) = happyShift action_48
action_25 (64) = happyShift action_49
action_25 (65) = happyShift action_50
action_25 (66) = happyShift action_51
action_25 (67) = happyShift action_52
action_25 (68) = happyShift action_9
action_25 (69) = happyShift action_53
action_25 (70) = happyShift action_10
action_25 (71) = happyShift action_54
action_25 (72) = happyShift action_55
action_25 (73) = happyShift action_23
action_25 (75) = happyShift action_56
action_25 (76) = happyShift action_2
action_25 (77) = happyShift action_57
action_25 (78) = happyShift action_58
action_25 (4) = happyGoto action_26
action_25 (5) = happyGoto action_27
action_25 (6) = happyGoto action_28
action_25 (12) = happyGoto action_29
action_25 (14) = happyGoto action_30
action_25 (19) = happyGoto action_31
action_25 (21) = happyGoto action_32
action_25 (22) = happyGoto action_33
action_25 (23) = happyGoto action_34
action_25 (24) = happyGoto action_35
action_25 (25) = happyGoto action_36
action_25 (26) = happyGoto action_37
action_25 (27) = happyGoto action_38
action_25 _ = happyFail (happyExpListPerState 25)

action_26 (37) = happyShift action_95
action_26 (41) = happyShift action_96
action_26 (44) = happyShift action_97
action_26 (49) = happyShift action_98
action_26 _ = happyReduce_50

action_27 _ = happyReduce_51

action_28 _ = happyReduce_56

action_29 _ = happyReduce_17

action_30 _ = happyReduce_15

action_31 (76) = happyShift action_2
action_31 (4) = happyGoto action_92
action_31 (17) = happyGoto action_93
action_31 (18) = happyGoto action_94
action_31 _ = happyFail (happyExpListPerState 31)

action_32 _ = happyReduce_60

action_33 _ = happyReduce_62

action_34 (34) = happyShift action_89
action_34 (39) = happyShift action_90
action_34 (45) = happyShift action_91
action_34 (30) = happyGoto action_88
action_34 _ = happyReduce_64

action_35 (40) = happyShift action_86
action_35 (43) = happyShift action_87
action_35 (29) = happyGoto action_85
action_35 _ = happyReduce_66

action_36 (33) = happyShift action_78
action_36 (36) = happyShift action_79
action_36 (47) = happyShift action_80
action_36 (48) = happyShift action_81
action_36 (50) = happyShift action_82
action_36 (51) = happyShift action_83
action_36 (52) = happyShift action_84
action_36 (31) = happyGoto action_77
action_36 _ = happyReduce_68

action_37 (74) = happyShift action_76
action_37 _ = happyReduce_70

action_38 (46) = happyShift action_75
action_38 _ = happyFail (happyExpListPerState 38)

action_39 (37) = happyShift action_40
action_39 (59) = happyShift action_45
action_39 (63) = happyShift action_48
action_39 (69) = happyShift action_53
action_39 (76) = happyShift action_2
action_39 (77) = happyShift action_57
action_39 (78) = happyShift action_58
action_39 (4) = happyGoto action_59
action_39 (5) = happyGoto action_27
action_39 (6) = happyGoto action_28
action_39 (21) = happyGoto action_74
action_39 _ = happyFail (happyExpListPerState 39)

action_40 (32) = happyShift action_39
action_40 (37) = happyShift action_40
action_40 (43) = happyShift action_41
action_40 (59) = happyShift action_45
action_40 (63) = happyShift action_48
action_40 (69) = happyShift action_53
action_40 (76) = happyShift action_2
action_40 (77) = happyShift action_57
action_40 (78) = happyShift action_58
action_40 (4) = happyGoto action_59
action_40 (5) = happyGoto action_27
action_40 (6) = happyGoto action_28
action_40 (21) = happyGoto action_32
action_40 (22) = happyGoto action_33
action_40 (23) = happyGoto action_34
action_40 (24) = happyGoto action_35
action_40 (25) = happyGoto action_36
action_40 (26) = happyGoto action_37
action_40 (27) = happyGoto action_73
action_40 _ = happyFail (happyExpListPerState 40)

action_41 (37) = happyShift action_40
action_41 (59) = happyShift action_45
action_41 (63) = happyShift action_48
action_41 (69) = happyShift action_53
action_41 (76) = happyShift action_2
action_41 (77) = happyShift action_57
action_41 (78) = happyShift action_58
action_41 (4) = happyGoto action_59
action_41 (5) = happyGoto action_27
action_41 (6) = happyGoto action_28
action_41 (21) = happyGoto action_72
action_41 _ = happyFail (happyExpListPerState 41)

action_42 _ = happyReduce_16

action_43 (46) = happyShift action_71
action_43 _ = happyFail (happyExpListPerState 43)

action_44 (46) = happyShift action_70
action_44 _ = happyFail (happyExpListPerState 44)

action_45 _ = happyReduce_53

action_46 (55) = happyShift action_7
action_46 (62) = happyShift action_8
action_46 (68) = happyShift action_9
action_46 (70) = happyShift action_10
action_46 (19) = happyGoto action_69
action_46 _ = happyFail (happyExpListPerState 46)

action_47 (37) = happyShift action_68
action_47 _ = happyFail (happyExpListPerState 47)

action_48 (37) = happyShift action_67
action_48 _ = happyFail (happyExpListPerState 48)

action_49 (37) = happyShift action_66
action_49 _ = happyFail (happyExpListPerState 49)

action_50 (37) = happyShift action_65
action_50 _ = happyFail (happyExpListPerState 50)

action_51 (37) = happyShift action_64
action_51 _ = happyFail (happyExpListPerState 51)

action_52 (32) = happyShift action_39
action_52 (37) = happyShift action_40
action_52 (43) = happyShift action_41
action_52 (46) = happyShift action_63
action_52 (59) = happyShift action_45
action_52 (63) = happyShift action_48
action_52 (69) = happyShift action_53
action_52 (76) = happyShift action_2
action_52 (77) = happyShift action_57
action_52 (78) = happyShift action_58
action_52 (4) = happyGoto action_59
action_52 (5) = happyGoto action_27
action_52 (6) = happyGoto action_28
action_52 (21) = happyGoto action_32
action_52 (22) = happyGoto action_33
action_52 (23) = happyGoto action_34
action_52 (24) = happyGoto action_35
action_52 (25) = happyGoto action_36
action_52 (26) = happyGoto action_37
action_52 (27) = happyGoto action_62
action_52 _ = happyFail (happyExpListPerState 52)

action_53 _ = happyReduce_52

action_54 (37) = happyShift action_61
action_54 _ = happyFail (happyExpListPerState 54)

action_55 (32) = happyShift action_39
action_55 (37) = happyShift action_40
action_55 (43) = happyShift action_41
action_55 (59) = happyShift action_45
action_55 (63) = happyShift action_48
action_55 (69) = happyShift action_53
action_55 (76) = happyShift action_2
action_55 (77) = happyShift action_57
action_55 (78) = happyShift action_58
action_55 (4) = happyGoto action_59
action_55 (5) = happyGoto action_27
action_55 (6) = happyGoto action_28
action_55 (21) = happyGoto action_32
action_55 (22) = happyGoto action_33
action_55 (23) = happyGoto action_34
action_55 (24) = happyGoto action_35
action_55 (25) = happyGoto action_36
action_55 (26) = happyGoto action_37
action_55 (27) = happyGoto action_60
action_55 _ = happyFail (happyExpListPerState 55)

action_56 _ = happyReduce_13

action_57 _ = happyReduce_2

action_58 _ = happyReduce_3

action_59 (37) = happyShift action_95
action_59 _ = happyReduce_50

action_60 (46) = happyShift action_122
action_60 _ = happyFail (happyExpListPerState 60)

action_61 (32) = happyShift action_39
action_61 (37) = happyShift action_40
action_61 (43) = happyShift action_41
action_61 (59) = happyShift action_45
action_61 (63) = happyShift action_48
action_61 (69) = happyShift action_53
action_61 (76) = happyShift action_2
action_61 (77) = happyShift action_57
action_61 (78) = happyShift action_58
action_61 (4) = happyGoto action_59
action_61 (5) = happyGoto action_27
action_61 (6) = happyGoto action_28
action_61 (21) = happyGoto action_32
action_61 (22) = happyGoto action_33
action_61 (23) = happyGoto action_34
action_61 (24) = happyGoto action_35
action_61 (25) = happyGoto action_36
action_61 (26) = happyGoto action_37
action_61 (27) = happyGoto action_121
action_61 _ = happyFail (happyExpListPerState 61)

action_62 (46) = happyShift action_120
action_62 _ = happyFail (happyExpListPerState 62)

action_63 _ = happyReduce_25

action_64 (32) = happyShift action_39
action_64 (37) = happyShift action_40
action_64 (43) = happyShift action_41
action_64 (59) = happyShift action_45
action_64 (63) = happyShift action_48
action_64 (69) = happyShift action_53
action_64 (76) = happyShift action_2
action_64 (77) = happyShift action_57
action_64 (78) = happyShift action_58
action_64 (4) = happyGoto action_59
action_64 (5) = happyGoto action_27
action_64 (6) = happyGoto action_28
action_64 (21) = happyGoto action_32
action_64 (22) = happyGoto action_33
action_64 (23) = happyGoto action_34
action_64 (24) = happyGoto action_35
action_64 (25) = happyGoto action_36
action_64 (26) = happyGoto action_37
action_64 (27) = happyGoto action_119
action_64 _ = happyFail (happyExpListPerState 64)

action_65 (32) = happyShift action_39
action_65 (37) = happyShift action_40
action_65 (43) = happyShift action_41
action_65 (59) = happyShift action_45
action_65 (63) = happyShift action_48
action_65 (69) = happyShift action_53
action_65 (76) = happyShift action_2
action_65 (77) = happyShift action_57
action_65 (78) = happyShift action_58
action_65 (4) = happyGoto action_59
action_65 (5) = happyGoto action_27
action_65 (6) = happyGoto action_28
action_65 (21) = happyGoto action_32
action_65 (22) = happyGoto action_33
action_65 (23) = happyGoto action_34
action_65 (24) = happyGoto action_35
action_65 (25) = happyGoto action_36
action_65 (26) = happyGoto action_37
action_65 (27) = happyGoto action_118
action_65 _ = happyFail (happyExpListPerState 65)

action_66 (32) = happyShift action_39
action_66 (37) = happyShift action_40
action_66 (43) = happyShift action_41
action_66 (59) = happyShift action_45
action_66 (63) = happyShift action_48
action_66 (69) = happyShift action_53
action_66 (76) = happyShift action_2
action_66 (77) = happyShift action_57
action_66 (78) = happyShift action_58
action_66 (4) = happyGoto action_59
action_66 (5) = happyGoto action_27
action_66 (6) = happyGoto action_28
action_66 (21) = happyGoto action_32
action_66 (22) = happyGoto action_33
action_66 (23) = happyGoto action_34
action_66 (24) = happyGoto action_35
action_66 (25) = happyGoto action_36
action_66 (26) = happyGoto action_37
action_66 (27) = happyGoto action_117
action_66 _ = happyFail (happyExpListPerState 66)

action_67 (76) = happyShift action_2
action_67 (4) = happyGoto action_116
action_67 _ = happyFail (happyExpListPerState 67)

action_68 (32) = happyShift action_39
action_68 (37) = happyShift action_40
action_68 (43) = happyShift action_41
action_68 (59) = happyShift action_45
action_68 (63) = happyShift action_48
action_68 (69) = happyShift action_53
action_68 (76) = happyShift action_2
action_68 (77) = happyShift action_57
action_68 (78) = happyShift action_58
action_68 (4) = happyGoto action_59
action_68 (5) = happyGoto action_27
action_68 (6) = happyGoto action_28
action_68 (21) = happyGoto action_32
action_68 (22) = happyGoto action_33
action_68 (23) = happyGoto action_34
action_68 (24) = happyGoto action_35
action_68 (25) = happyGoto action_36
action_68 (26) = happyGoto action_37
action_68 (27) = happyGoto action_115
action_68 _ = happyFail (happyExpListPerState 68)

action_69 (76) = happyShift action_2
action_69 (4) = happyGoto action_114
action_69 _ = happyFail (happyExpListPerState 69)

action_70 _ = happyReduce_31

action_71 _ = happyReduce_30

action_72 _ = happyReduce_58

action_73 (38) = happyShift action_113
action_73 _ = happyFail (happyExpListPerState 73)

action_74 _ = happyReduce_59

action_75 _ = happyReduce_32

action_76 (32) = happyShift action_39
action_76 (37) = happyShift action_40
action_76 (43) = happyShift action_41
action_76 (59) = happyShift action_45
action_76 (63) = happyShift action_48
action_76 (69) = happyShift action_53
action_76 (76) = happyShift action_2
action_76 (77) = happyShift action_57
action_76 (78) = happyShift action_58
action_76 (4) = happyGoto action_59
action_76 (5) = happyGoto action_27
action_76 (6) = happyGoto action_28
action_76 (21) = happyGoto action_32
action_76 (22) = happyGoto action_33
action_76 (23) = happyGoto action_34
action_76 (24) = happyGoto action_35
action_76 (25) = happyGoto action_36
action_76 (26) = happyGoto action_37
action_76 (27) = happyGoto action_112
action_76 _ = happyFail (happyExpListPerState 76)

action_77 (32) = happyShift action_39
action_77 (37) = happyShift action_40
action_77 (43) = happyShift action_41
action_77 (59) = happyShift action_45
action_77 (63) = happyShift action_48
action_77 (69) = happyShift action_53
action_77 (76) = happyShift action_2
action_77 (77) = happyShift action_57
action_77 (78) = happyShift action_58
action_77 (4) = happyGoto action_59
action_77 (5) = happyGoto action_27
action_77 (6) = happyGoto action_28
action_77 (21) = happyGoto action_32
action_77 (22) = happyGoto action_33
action_77 (23) = happyGoto action_34
action_77 (24) = happyGoto action_111
action_77 _ = happyFail (happyExpListPerState 77)

action_78 _ = happyReduce_84

action_79 (32) = happyShift action_39
action_79 (37) = happyShift action_40
action_79 (43) = happyShift action_41
action_79 (59) = happyShift action_45
action_79 (63) = happyShift action_48
action_79 (69) = happyShift action_53
action_79 (76) = happyShift action_2
action_79 (77) = happyShift action_57
action_79 (78) = happyShift action_58
action_79 (4) = happyGoto action_59
action_79 (5) = happyGoto action_27
action_79 (6) = happyGoto action_28
action_79 (21) = happyGoto action_32
action_79 (22) = happyGoto action_33
action_79 (23) = happyGoto action_34
action_79 (24) = happyGoto action_35
action_79 (25) = happyGoto action_36
action_79 (26) = happyGoto action_110
action_79 _ = happyFail (happyExpListPerState 79)

action_80 _ = happyReduce_79

action_81 _ = happyReduce_80

action_82 _ = happyReduce_83

action_83 _ = happyReduce_81

action_84 _ = happyReduce_82

action_85 (32) = happyShift action_39
action_85 (37) = happyShift action_40
action_85 (43) = happyShift action_41
action_85 (59) = happyShift action_45
action_85 (63) = happyShift action_48
action_85 (69) = happyShift action_53
action_85 (76) = happyShift action_2
action_85 (77) = happyShift action_57
action_85 (78) = happyShift action_58
action_85 (4) = happyGoto action_59
action_85 (5) = happyGoto action_27
action_85 (6) = happyGoto action_28
action_85 (21) = happyGoto action_32
action_85 (22) = happyGoto action_33
action_85 (23) = happyGoto action_109
action_85 _ = happyFail (happyExpListPerState 85)

action_86 _ = happyReduce_74

action_87 _ = happyReduce_75

action_88 (32) = happyShift action_39
action_88 (37) = happyShift action_40
action_88 (43) = happyShift action_41
action_88 (59) = happyShift action_45
action_88 (63) = happyShift action_48
action_88 (69) = happyShift action_53
action_88 (76) = happyShift action_2
action_88 (77) = happyShift action_57
action_88 (78) = happyShift action_58
action_88 (4) = happyGoto action_59
action_88 (5) = happyGoto action_27
action_88 (6) = happyGoto action_28
action_88 (21) = happyGoto action_32
action_88 (22) = happyGoto action_108
action_88 _ = happyFail (happyExpListPerState 88)

action_89 _ = happyReduce_78

action_90 _ = happyReduce_76

action_91 _ = happyReduce_77

action_92 (37) = happyShift action_106
action_92 (49) = happyShift action_107
action_92 _ = happyReduce_39

action_93 (42) = happyShift action_105
action_93 _ = happyReduce_41

action_94 (46) = happyShift action_104
action_94 _ = happyFail (happyExpListPerState 94)

action_95 (32) = happyShift action_39
action_95 (37) = happyShift action_40
action_95 (43) = happyShift action_41
action_95 (59) = happyShift action_45
action_95 (63) = happyShift action_48
action_95 (69) = happyShift action_53
action_95 (76) = happyShift action_2
action_95 (77) = happyShift action_57
action_95 (78) = happyShift action_58
action_95 (4) = happyGoto action_59
action_95 (5) = happyGoto action_27
action_95 (6) = happyGoto action_28
action_95 (21) = happyGoto action_32
action_95 (22) = happyGoto action_33
action_95 (23) = happyGoto action_34
action_95 (24) = happyGoto action_35
action_95 (25) = happyGoto action_36
action_95 (26) = happyGoto action_37
action_95 (27) = happyGoto action_102
action_95 (28) = happyGoto action_103
action_95 _ = happyReduce_71

action_96 (46) = happyShift action_101
action_96 _ = happyFail (happyExpListPerState 96)

action_97 (46) = happyShift action_100
action_97 _ = happyFail (happyExpListPerState 97)

action_98 (32) = happyShift action_39
action_98 (37) = happyShift action_40
action_98 (43) = happyShift action_41
action_98 (59) = happyShift action_45
action_98 (63) = happyShift action_48
action_98 (69) = happyShift action_53
action_98 (76) = happyShift action_2
action_98 (77) = happyShift action_57
action_98 (78) = happyShift action_58
action_98 (4) = happyGoto action_59
action_98 (5) = happyGoto action_27
action_98 (6) = happyGoto action_28
action_98 (21) = happyGoto action_32
action_98 (22) = happyGoto action_33
action_98 (23) = happyGoto action_34
action_98 (24) = happyGoto action_35
action_98 (25) = happyGoto action_36
action_98 (26) = happyGoto action_37
action_98 (27) = happyGoto action_99
action_98 _ = happyFail (happyExpListPerState 98)

action_99 (46) = happyShift action_136
action_99 _ = happyFail (happyExpListPerState 99)

action_100 _ = happyReduce_23

action_101 _ = happyReduce_22

action_102 (42) = happyShift action_135
action_102 _ = happyReduce_72

action_103 (38) = happyShift action_134
action_103 _ = happyFail (happyExpListPerState 103)

action_104 _ = happyReduce_18

action_105 (76) = happyShift action_2
action_105 (4) = happyGoto action_132
action_105 (17) = happyGoto action_93
action_105 (18) = happyGoto action_133
action_105 _ = happyFail (happyExpListPerState 105)

action_106 (55) = happyShift action_7
action_106 (62) = happyShift action_8
action_106 (68) = happyShift action_9
action_106 (70) = happyShift action_10
action_106 (10) = happyGoto action_14
action_106 (11) = happyGoto action_131
action_106 (19) = happyGoto action_16
action_106 _ = happyReduce_10

action_107 (32) = happyShift action_39
action_107 (37) = happyShift action_40
action_107 (43) = happyShift action_41
action_107 (59) = happyShift action_45
action_107 (63) = happyShift action_48
action_107 (69) = happyShift action_53
action_107 (76) = happyShift action_2
action_107 (77) = happyShift action_57
action_107 (78) = happyShift action_58
action_107 (4) = happyGoto action_59
action_107 (5) = happyGoto action_27
action_107 (6) = happyGoto action_28
action_107 (21) = happyGoto action_32
action_107 (22) = happyGoto action_33
action_107 (23) = happyGoto action_34
action_107 (24) = happyGoto action_35
action_107 (25) = happyGoto action_36
action_107 (26) = happyGoto action_37
action_107 (27) = happyGoto action_130
action_107 _ = happyFail (happyExpListPerState 107)

action_108 _ = happyReduce_61

action_109 (34) = happyShift action_89
action_109 (39) = happyShift action_90
action_109 (45) = happyShift action_91
action_109 (30) = happyGoto action_88
action_109 _ = happyReduce_63

action_110 _ = happyReduce_67

action_111 (40) = happyShift action_86
action_111 (43) = happyShift action_87
action_111 (29) = happyGoto action_85
action_111 _ = happyReduce_65

action_112 _ = happyReduce_69

action_113 _ = happyReduce_57

action_114 (37) = happyShift action_129
action_114 _ = happyFail (happyExpListPerState 114)

action_115 (38) = happyShift action_128
action_115 _ = happyFail (happyExpListPerState 115)

action_116 (38) = happyShift action_127
action_116 _ = happyFail (happyExpListPerState 116)

action_117 (38) = happyShift action_126
action_117 _ = happyFail (happyExpListPerState 117)

action_118 (38) = happyShift action_125
action_118 _ = happyFail (happyExpListPerState 118)

action_119 (38) = happyShift action_124
action_119 _ = happyFail (happyExpListPerState 119)

action_120 _ = happyReduce_24

action_121 (38) = happyShift action_123
action_121 _ = happyFail (happyExpListPerState 121)

action_122 _ = happyReduce_26

action_123 (32) = happyShift action_39
action_123 (37) = happyShift action_40
action_123 (43) = happyShift action_41
action_123 (46) = happyShift action_42
action_123 (55) = happyShift action_7
action_123 (56) = happyShift action_43
action_123 (57) = happyShift action_44
action_123 (59) = happyShift action_45
action_123 (60) = happyShift action_46
action_123 (61) = happyShift action_47
action_123 (62) = happyShift action_8
action_123 (63) = happyShift action_48
action_123 (64) = happyShift action_49
action_123 (65) = happyShift action_50
action_123 (66) = happyShift action_51
action_123 (67) = happyShift action_52
action_123 (68) = happyShift action_9
action_123 (69) = happyShift action_53
action_123 (70) = happyShift action_10
action_123 (71) = happyShift action_54
action_123 (72) = happyShift action_55
action_123 (73) = happyShift action_23
action_123 (76) = happyShift action_2
action_123 (77) = happyShift action_57
action_123 (78) = happyShift action_58
action_123 (4) = happyGoto action_26
action_123 (5) = happyGoto action_27
action_123 (6) = happyGoto action_28
action_123 (12) = happyGoto action_29
action_123 (14) = happyGoto action_144
action_123 (19) = happyGoto action_31
action_123 (21) = happyGoto action_32
action_123 (22) = happyGoto action_33
action_123 (23) = happyGoto action_34
action_123 (24) = happyGoto action_35
action_123 (25) = happyGoto action_36
action_123 (26) = happyGoto action_37
action_123 (27) = happyGoto action_38
action_123 _ = happyFail (happyExpListPerState 123)

action_124 (46) = happyShift action_143
action_124 _ = happyFail (happyExpListPerState 124)

action_125 (46) = happyShift action_142
action_125 _ = happyFail (happyExpListPerState 125)

action_126 (46) = happyShift action_141
action_126 _ = happyFail (happyExpListPerState 126)

action_127 _ = happyReduce_55

action_128 (32) = happyShift action_39
action_128 (37) = happyShift action_40
action_128 (43) = happyShift action_41
action_128 (46) = happyShift action_42
action_128 (55) = happyShift action_7
action_128 (56) = happyShift action_43
action_128 (57) = happyShift action_44
action_128 (59) = happyShift action_45
action_128 (60) = happyShift action_46
action_128 (61) = happyShift action_47
action_128 (62) = happyShift action_8
action_128 (63) = happyShift action_48
action_128 (64) = happyShift action_49
action_128 (65) = happyShift action_50
action_128 (66) = happyShift action_51
action_128 (67) = happyShift action_52
action_128 (68) = happyShift action_9
action_128 (69) = happyShift action_53
action_128 (70) = happyShift action_10
action_128 (71) = happyShift action_54
action_128 (72) = happyShift action_55
action_128 (73) = happyShift action_23
action_128 (76) = happyShift action_2
action_128 (77) = happyShift action_57
action_128 (78) = happyShift action_58
action_128 (4) = happyGoto action_26
action_128 (5) = happyGoto action_27
action_128 (6) = happyGoto action_28
action_128 (12) = happyGoto action_29
action_128 (14) = happyGoto action_140
action_128 (19) = happyGoto action_31
action_128 (21) = happyGoto action_32
action_128 (22) = happyGoto action_33
action_128 (23) = happyGoto action_34
action_128 (24) = happyGoto action_35
action_128 (25) = happyGoto action_36
action_128 (26) = happyGoto action_37
action_128 (27) = happyGoto action_38
action_128 _ = happyFail (happyExpListPerState 128)

action_129 (55) = happyShift action_7
action_129 (62) = happyShift action_8
action_129 (68) = happyShift action_9
action_129 (70) = happyShift action_10
action_129 (10) = happyGoto action_14
action_129 (11) = happyGoto action_139
action_129 (19) = happyGoto action_16
action_129 _ = happyReduce_10

action_130 _ = happyReduce_40

action_131 (38) = happyShift action_138
action_131 _ = happyFail (happyExpListPerState 131)

action_132 (49) = happyShift action_107
action_132 _ = happyReduce_39

action_133 _ = happyReduce_42

action_134 _ = happyReduce_54

action_135 (32) = happyShift action_39
action_135 (37) = happyShift action_40
action_135 (43) = happyShift action_41
action_135 (59) = happyShift action_45
action_135 (63) = happyShift action_48
action_135 (69) = happyShift action_53
action_135 (76) = happyShift action_2
action_135 (77) = happyShift action_57
action_135 (78) = happyShift action_58
action_135 (4) = happyGoto action_59
action_135 (5) = happyGoto action_27
action_135 (6) = happyGoto action_28
action_135 (21) = happyGoto action_32
action_135 (22) = happyGoto action_33
action_135 (23) = happyGoto action_34
action_135 (24) = happyGoto action_35
action_135 (25) = happyGoto action_36
action_135 (26) = happyGoto action_37
action_135 (27) = happyGoto action_102
action_135 (28) = happyGoto action_137
action_135 _ = happyReduce_71

action_136 _ = happyReduce_21

action_137 _ = happyReduce_73

action_138 (73) = happyShift action_23
action_138 (12) = happyGoto action_147
action_138 _ = happyFail (happyExpListPerState 138)

action_139 (38) = happyShift action_146
action_139 _ = happyFail (happyExpListPerState 139)

action_140 (58) = happyShift action_145
action_140 _ = happyReduce_27

action_141 _ = happyReduce_34

action_142 _ = happyReduce_33

action_143 _ = happyReduce_35

action_144 _ = happyReduce_29

action_145 (32) = happyShift action_39
action_145 (37) = happyShift action_40
action_145 (43) = happyShift action_41
action_145 (46) = happyShift action_42
action_145 (55) = happyShift action_7
action_145 (56) = happyShift action_43
action_145 (57) = happyShift action_44
action_145 (59) = happyShift action_45
action_145 (60) = happyShift action_46
action_145 (61) = happyShift action_47
action_145 (62) = happyShift action_8
action_145 (63) = happyShift action_48
action_145 (64) = happyShift action_49
action_145 (65) = happyShift action_50
action_145 (66) = happyShift action_51
action_145 (67) = happyShift action_52
action_145 (68) = happyShift action_9
action_145 (69) = happyShift action_53
action_145 (70) = happyShift action_10
action_145 (71) = happyShift action_54
action_145 (72) = happyShift action_55
action_145 (73) = happyShift action_23
action_145 (76) = happyShift action_2
action_145 (77) = happyShift action_57
action_145 (78) = happyShift action_58
action_145 (4) = happyGoto action_26
action_145 (5) = happyGoto action_27
action_145 (6) = happyGoto action_28
action_145 (12) = happyGoto action_29
action_145 (14) = happyGoto action_149
action_145 (19) = happyGoto action_31
action_145 (21) = happyGoto action_32
action_145 (22) = happyGoto action_33
action_145 (23) = happyGoto action_34
action_145 (24) = happyGoto action_35
action_145 (25) = happyGoto action_36
action_145 (26) = happyGoto action_37
action_145 (27) = happyGoto action_38
action_145 _ = happyFail (happyExpListPerState 145)

action_146 (73) = happyShift action_23
action_146 (12) = happyGoto action_148
action_146 _ = happyFail (happyExpListPerState 146)

action_147 _ = happyReduce_19

action_148 _ = happyReduce_20

action_149 _ = happyReduce_28

happyReduce_1 = happySpecReduce_1  4 happyReduction_1
happyReduction_1 (HappyTerminal (PT _ (TV happy_var_1)))
	 =  HappyAbsSyn4
		 (Ident happy_var_1
	)
happyReduction_1 _  = notHappyAtAll 

happyReduce_2 = happySpecReduce_1  5 happyReduction_2
happyReduction_2 (HappyTerminal (PT _ (TI happy_var_1)))
	 =  HappyAbsSyn5
		 ((read ( happy_var_1)) :: Integer
	)
happyReduction_2 _  = notHappyAtAll 

happyReduce_3 = happySpecReduce_1  6 happyReduction_3
happyReduction_3 (HappyTerminal (PT _ (TL happy_var_1)))
	 =  HappyAbsSyn6
		 (happy_var_1
	)
happyReduction_3 _  = notHappyAtAll 

happyReduce_4 = happySpecReduce_1  7 happyReduction_4
happyReduction_4 (HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn7
		 (AbsKoala.Program happy_var_1
	)
happyReduction_4 _  = notHappyAtAll 

happyReduce_5 = happyReduce 6 8 happyReduction_5
happyReduction_5 ((HappyAbsSyn12  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn11  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_2) `HappyStk`
	(HappyAbsSyn19  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn8
		 (AbsKoala.FnDef happy_var_1 happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_6 = happySpecReduce_1  9 happyReduction_6
happyReduction_6 (HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn9
		 ((:[]) happy_var_1
	)
happyReduction_6 _  = notHappyAtAll 

happyReduce_7 = happySpecReduce_2  9 happyReduction_7
happyReduction_7 (HappyAbsSyn9  happy_var_2)
	(HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn9
		 ((:) happy_var_1 happy_var_2
	)
happyReduction_7 _ _  = notHappyAtAll 

happyReduce_8 = happySpecReduce_2  10 happyReduction_8
happyReduction_8 (HappyAbsSyn4  happy_var_2)
	(HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn10
		 (AbsKoala.Val happy_var_1 happy_var_2
	)
happyReduction_8 _ _  = notHappyAtAll 

happyReduce_9 = happySpecReduce_3  10 happyReduction_9
happyReduction_9 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn10
		 (AbsKoala.Ref happy_var_1 happy_var_3
	)
happyReduction_9 _ _ _  = notHappyAtAll 

happyReduce_10 = happySpecReduce_0  11 happyReduction_10
happyReduction_10  =  HappyAbsSyn11
		 ([]
	)

happyReduce_11 = happySpecReduce_1  11 happyReduction_11
happyReduction_11 (HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn11
		 ((:[]) happy_var_1
	)
happyReduction_11 _  = notHappyAtAll 

happyReduce_12 = happySpecReduce_3  11 happyReduction_12
happyReduction_12 (HappyAbsSyn11  happy_var_3)
	_
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn11
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_12 _ _ _  = notHappyAtAll 

happyReduce_13 = happySpecReduce_3  12 happyReduction_13
happyReduction_13 _
	(HappyAbsSyn13  happy_var_2)
	_
	 =  HappyAbsSyn12
		 (AbsKoala.Block (reverse happy_var_2)
	)
happyReduction_13 _ _ _  = notHappyAtAll 

happyReduce_14 = happySpecReduce_0  13 happyReduction_14
happyReduction_14  =  HappyAbsSyn13
		 ([]
	)

happyReduce_15 = happySpecReduce_2  13 happyReduction_15
happyReduction_15 (HappyAbsSyn14  happy_var_2)
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn13
		 (flip (:) happy_var_1 happy_var_2
	)
happyReduction_15 _ _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_1  14 happyReduction_16
happyReduction_16 _
	 =  HappyAbsSyn14
		 (AbsKoala.Empty
	)

happyReduce_17 = happySpecReduce_1  14 happyReduction_17
happyReduction_17 (HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn14
		 (AbsKoala.BStmt happy_var_1
	)
happyReduction_17 _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_3  14 happyReduction_18
happyReduction_18 _
	(HappyAbsSyn18  happy_var_2)
	(HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn14
		 (AbsKoala.Decl happy_var_1 happy_var_2
	)
happyReduction_18 _ _ _  = notHappyAtAll 

happyReduce_19 = happyReduce 6 14 happyReduction_19
happyReduction_19 ((HappyAbsSyn12  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn11  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_2) `HappyStk`
	(HappyAbsSyn19  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn14
		 (AbsKoala.FDecl happy_var_1 happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_20 = happyReduce 7 14 happyReduction_20
happyReduction_20 ((HappyAbsSyn12  happy_var_7) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn11  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	(HappyAbsSyn19  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn14
		 (AbsKoala.GDecl happy_var_2 happy_var_3 happy_var_5 happy_var_7
	) `HappyStk` happyRest

happyReduce_21 = happyReduce 4 14 happyReduction_21
happyReduction_21 (_ `HappyStk`
	(HappyAbsSyn21  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn14
		 (AbsKoala.Ass happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_22 = happySpecReduce_3  14 happyReduction_22
happyReduction_22 _
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn14
		 (AbsKoala.Incr happy_var_1
	)
happyReduction_22 _ _ _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_3  14 happyReduction_23
happyReduction_23 _
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn14
		 (AbsKoala.Decr happy_var_1
	)
happyReduction_23 _ _ _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_3  14 happyReduction_24
happyReduction_24 _
	(HappyAbsSyn21  happy_var_2)
	_
	 =  HappyAbsSyn14
		 (AbsKoala.Ret happy_var_2
	)
happyReduction_24 _ _ _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_2  14 happyReduction_25
happyReduction_25 _
	_
	 =  HappyAbsSyn14
		 (AbsKoala.VRet
	)

happyReduce_26 = happySpecReduce_3  14 happyReduction_26
happyReduction_26 _
	(HappyAbsSyn21  happy_var_2)
	_
	 =  HappyAbsSyn14
		 (AbsKoala.Yield happy_var_2
	)
happyReduction_26 _ _ _  = notHappyAtAll 

happyReduce_27 = happyReduce 5 14 happyReduction_27
happyReduction_27 ((HappyAbsSyn14  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn21  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn14
		 (AbsKoala.Cond happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_28 = happyReduce 7 14 happyReduction_28
happyReduction_28 ((HappyAbsSyn14  happy_var_7) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn14  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn21  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn14
		 (AbsKoala.CondElse happy_var_3 happy_var_5 happy_var_7
	) `HappyStk` happyRest

happyReduce_29 = happyReduce 5 14 happyReduction_29
happyReduction_29 ((HappyAbsSyn14  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn21  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn14
		 (AbsKoala.While happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_30 = happySpecReduce_2  14 happyReduction_30
happyReduction_30 _
	_
	 =  HappyAbsSyn14
		 (AbsKoala.Break
	)

happyReduce_31 = happySpecReduce_2  14 happyReduction_31
happyReduction_31 _
	_
	 =  HappyAbsSyn14
		 (AbsKoala.Cont
	)

happyReduce_32 = happySpecReduce_2  14 happyReduction_32
happyReduction_32 _
	(HappyAbsSyn21  happy_var_1)
	 =  HappyAbsSyn14
		 (AbsKoala.SExp happy_var_1
	)
happyReduction_32 _ _  = notHappyAtAll 

happyReduce_33 = happyReduce 5 14 happyReduction_33
happyReduction_33 (_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn21  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn14
		 (AbsKoala.PrintI happy_var_3
	) `HappyStk` happyRest

happyReduce_34 = happyReduce 5 14 happyReduction_34
happyReduction_34 (_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn21  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn14
		 (AbsKoala.PrintB happy_var_3
	) `HappyStk` happyRest

happyReduce_35 = happyReduce 5 14 happyReduction_35
happyReduction_35 (_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn21  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn14
		 (AbsKoala.PrintS happy_var_3
	) `HappyStk` happyRest

happyReduce_36 = happySpecReduce_3  15 happyReduction_36
happyReduction_36 _
	(HappyAbsSyn21  happy_var_2)
	_
	 =  HappyAbsSyn15
		 (AbsKoala.Index happy_var_2
	)
happyReduction_36 _ _ _  = notHappyAtAll 

happyReduce_37 = happySpecReduce_1  16 happyReduction_37
happyReduction_37 (HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn16
		 ((:[]) happy_var_1
	)
happyReduction_37 _  = notHappyAtAll 

happyReduce_38 = happySpecReduce_2  16 happyReduction_38
happyReduction_38 (HappyAbsSyn16  happy_var_2)
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn16
		 ((:) happy_var_1 happy_var_2
	)
happyReduction_38 _ _  = notHappyAtAll 

happyReduce_39 = happySpecReduce_1  17 happyReduction_39
happyReduction_39 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn17
		 (AbsKoala.NoInit happy_var_1
	)
happyReduction_39 _  = notHappyAtAll 

happyReduce_40 = happySpecReduce_3  17 happyReduction_40
happyReduction_40 (HappyAbsSyn21  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn17
		 (AbsKoala.Init happy_var_1 happy_var_3
	)
happyReduction_40 _ _ _  = notHappyAtAll 

happyReduce_41 = happySpecReduce_1  18 happyReduction_41
happyReduction_41 (HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn18
		 ((:[]) happy_var_1
	)
happyReduction_41 _  = notHappyAtAll 

happyReduce_42 = happySpecReduce_3  18 happyReduction_42
happyReduction_42 (HappyAbsSyn18  happy_var_3)
	_
	(HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn18
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_42 _ _ _  = notHappyAtAll 

happyReduce_43 = happySpecReduce_1  19 happyReduction_43
happyReduction_43 _
	 =  HappyAbsSyn19
		 (AbsKoala.Int
	)

happyReduce_44 = happySpecReduce_1  19 happyReduction_44
happyReduction_44 _
	 =  HappyAbsSyn19
		 (AbsKoala.Str
	)

happyReduce_45 = happySpecReduce_1  19 happyReduction_45
happyReduction_45 _
	 =  HappyAbsSyn19
		 (AbsKoala.Bool
	)

happyReduce_46 = happySpecReduce_1  19 happyReduction_46
happyReduction_46 _
	 =  HappyAbsSyn19
		 (AbsKoala.Void
	)

happyReduce_47 = happySpecReduce_0  20 happyReduction_47
happyReduction_47  =  HappyAbsSyn20
		 ([]
	)

happyReduce_48 = happySpecReduce_1  20 happyReduction_48
happyReduction_48 (HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn20
		 ((:[]) happy_var_1
	)
happyReduction_48 _  = notHappyAtAll 

happyReduce_49 = happySpecReduce_3  20 happyReduction_49
happyReduction_49 (HappyAbsSyn20  happy_var_3)
	_
	(HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn20
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_49 _ _ _  = notHappyAtAll 

happyReduce_50 = happySpecReduce_1  21 happyReduction_50
happyReduction_50 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn21
		 (AbsKoala.EVar happy_var_1
	)
happyReduction_50 _  = notHappyAtAll 

happyReduce_51 = happySpecReduce_1  21 happyReduction_51
happyReduction_51 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn21
		 (AbsKoala.ELitInt happy_var_1
	)
happyReduction_51 _  = notHappyAtAll 

happyReduce_52 = happySpecReduce_1  21 happyReduction_52
happyReduction_52 _
	 =  HappyAbsSyn21
		 (AbsKoala.ELitTrue
	)

happyReduce_53 = happySpecReduce_1  21 happyReduction_53
happyReduction_53 _
	 =  HappyAbsSyn21
		 (AbsKoala.ELitFalse
	)

happyReduce_54 = happyReduce 4 21 happyReduction_54
happyReduction_54 (_ `HappyStk`
	(HappyAbsSyn28  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn21
		 (AbsKoala.EApp happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_55 = happyReduce 4 21 happyReduction_55
happyReduction_55 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn21
		 (AbsKoala.GNext happy_var_3
	) `HappyStk` happyRest

happyReduce_56 = happySpecReduce_1  21 happyReduction_56
happyReduction_56 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn21
		 (AbsKoala.EString happy_var_1
	)
happyReduction_56 _  = notHappyAtAll 

happyReduce_57 = happySpecReduce_3  21 happyReduction_57
happyReduction_57 _
	(HappyAbsSyn21  happy_var_2)
	_
	 =  HappyAbsSyn21
		 (happy_var_2
	)
happyReduction_57 _ _ _  = notHappyAtAll 

happyReduce_58 = happySpecReduce_2  22 happyReduction_58
happyReduction_58 (HappyAbsSyn21  happy_var_2)
	_
	 =  HappyAbsSyn21
		 (AbsKoala.Neg happy_var_2
	)
happyReduction_58 _ _  = notHappyAtAll 

happyReduce_59 = happySpecReduce_2  22 happyReduction_59
happyReduction_59 (HappyAbsSyn21  happy_var_2)
	_
	 =  HappyAbsSyn21
		 (AbsKoala.Not happy_var_2
	)
happyReduction_59 _ _  = notHappyAtAll 

happyReduce_60 = happySpecReduce_1  22 happyReduction_60
happyReduction_60 (HappyAbsSyn21  happy_var_1)
	 =  HappyAbsSyn21
		 (happy_var_1
	)
happyReduction_60 _  = notHappyAtAll 

happyReduce_61 = happySpecReduce_3  23 happyReduction_61
happyReduction_61 (HappyAbsSyn21  happy_var_3)
	(HappyAbsSyn30  happy_var_2)
	(HappyAbsSyn21  happy_var_1)
	 =  HappyAbsSyn21
		 (AbsKoala.EMul happy_var_1 happy_var_2 happy_var_3
	)
happyReduction_61 _ _ _  = notHappyAtAll 

happyReduce_62 = happySpecReduce_1  23 happyReduction_62
happyReduction_62 (HappyAbsSyn21  happy_var_1)
	 =  HappyAbsSyn21
		 (happy_var_1
	)
happyReduction_62 _  = notHappyAtAll 

happyReduce_63 = happySpecReduce_3  24 happyReduction_63
happyReduction_63 (HappyAbsSyn21  happy_var_3)
	(HappyAbsSyn29  happy_var_2)
	(HappyAbsSyn21  happy_var_1)
	 =  HappyAbsSyn21
		 (AbsKoala.EAdd happy_var_1 happy_var_2 happy_var_3
	)
happyReduction_63 _ _ _  = notHappyAtAll 

happyReduce_64 = happySpecReduce_1  24 happyReduction_64
happyReduction_64 (HappyAbsSyn21  happy_var_1)
	 =  HappyAbsSyn21
		 (happy_var_1
	)
happyReduction_64 _  = notHappyAtAll 

happyReduce_65 = happySpecReduce_3  25 happyReduction_65
happyReduction_65 (HappyAbsSyn21  happy_var_3)
	(HappyAbsSyn31  happy_var_2)
	(HappyAbsSyn21  happy_var_1)
	 =  HappyAbsSyn21
		 (AbsKoala.ERel happy_var_1 happy_var_2 happy_var_3
	)
happyReduction_65 _ _ _  = notHappyAtAll 

happyReduce_66 = happySpecReduce_1  25 happyReduction_66
happyReduction_66 (HappyAbsSyn21  happy_var_1)
	 =  HappyAbsSyn21
		 (happy_var_1
	)
happyReduction_66 _  = notHappyAtAll 

happyReduce_67 = happySpecReduce_3  26 happyReduction_67
happyReduction_67 (HappyAbsSyn21  happy_var_3)
	_
	(HappyAbsSyn21  happy_var_1)
	 =  HappyAbsSyn21
		 (AbsKoala.EAnd happy_var_1 happy_var_3
	)
happyReduction_67 _ _ _  = notHappyAtAll 

happyReduce_68 = happySpecReduce_1  26 happyReduction_68
happyReduction_68 (HappyAbsSyn21  happy_var_1)
	 =  HappyAbsSyn21
		 (happy_var_1
	)
happyReduction_68 _  = notHappyAtAll 

happyReduce_69 = happySpecReduce_3  27 happyReduction_69
happyReduction_69 (HappyAbsSyn21  happy_var_3)
	_
	(HappyAbsSyn21  happy_var_1)
	 =  HappyAbsSyn21
		 (AbsKoala.EOr happy_var_1 happy_var_3
	)
happyReduction_69 _ _ _  = notHappyAtAll 

happyReduce_70 = happySpecReduce_1  27 happyReduction_70
happyReduction_70 (HappyAbsSyn21  happy_var_1)
	 =  HappyAbsSyn21
		 (happy_var_1
	)
happyReduction_70 _  = notHappyAtAll 

happyReduce_71 = happySpecReduce_0  28 happyReduction_71
happyReduction_71  =  HappyAbsSyn28
		 ([]
	)

happyReduce_72 = happySpecReduce_1  28 happyReduction_72
happyReduction_72 (HappyAbsSyn21  happy_var_1)
	 =  HappyAbsSyn28
		 ((:[]) happy_var_1
	)
happyReduction_72 _  = notHappyAtAll 

happyReduce_73 = happySpecReduce_3  28 happyReduction_73
happyReduction_73 (HappyAbsSyn28  happy_var_3)
	_
	(HappyAbsSyn21  happy_var_1)
	 =  HappyAbsSyn28
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_73 _ _ _  = notHappyAtAll 

happyReduce_74 = happySpecReduce_1  29 happyReduction_74
happyReduction_74 _
	 =  HappyAbsSyn29
		 (AbsKoala.Plus
	)

happyReduce_75 = happySpecReduce_1  29 happyReduction_75
happyReduction_75 _
	 =  HappyAbsSyn29
		 (AbsKoala.Minus
	)

happyReduce_76 = happySpecReduce_1  30 happyReduction_76
happyReduction_76 _
	 =  HappyAbsSyn30
		 (AbsKoala.Times
	)

happyReduce_77 = happySpecReduce_1  30 happyReduction_77
happyReduction_77 _
	 =  HappyAbsSyn30
		 (AbsKoala.Div
	)

happyReduce_78 = happySpecReduce_1  30 happyReduction_78
happyReduction_78 _
	 =  HappyAbsSyn30
		 (AbsKoala.Mod
	)

happyReduce_79 = happySpecReduce_1  31 happyReduction_79
happyReduction_79 _
	 =  HappyAbsSyn31
		 (AbsKoala.LTH
	)

happyReduce_80 = happySpecReduce_1  31 happyReduction_80
happyReduction_80 _
	 =  HappyAbsSyn31
		 (AbsKoala.LE
	)

happyReduce_81 = happySpecReduce_1  31 happyReduction_81
happyReduction_81 _
	 =  HappyAbsSyn31
		 (AbsKoala.GTH
	)

happyReduce_82 = happySpecReduce_1  31 happyReduction_82
happyReduction_82 _
	 =  HappyAbsSyn31
		 (AbsKoala.GE
	)

happyReduce_83 = happySpecReduce_1  31 happyReduction_83
happyReduction_83 _
	 =  HappyAbsSyn31
		 (AbsKoala.EQU
	)

happyReduce_84 = happySpecReduce_1  31 happyReduction_84
happyReduction_84 _
	 =  HappyAbsSyn31
		 (AbsKoala.NE
	)

happyNewToken action sts stk [] =
	action 79 79 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	PT _ (TS _ 1) -> cont 32;
	PT _ (TS _ 2) -> cont 33;
	PT _ (TS _ 3) -> cont 34;
	PT _ (TS _ 4) -> cont 35;
	PT _ (TS _ 5) -> cont 36;
	PT _ (TS _ 6) -> cont 37;
	PT _ (TS _ 7) -> cont 38;
	PT _ (TS _ 8) -> cont 39;
	PT _ (TS _ 9) -> cont 40;
	PT _ (TS _ 10) -> cont 41;
	PT _ (TS _ 11) -> cont 42;
	PT _ (TS _ 12) -> cont 43;
	PT _ (TS _ 13) -> cont 44;
	PT _ (TS _ 14) -> cont 45;
	PT _ (TS _ 15) -> cont 46;
	PT _ (TS _ 16) -> cont 47;
	PT _ (TS _ 17) -> cont 48;
	PT _ (TS _ 18) -> cont 49;
	PT _ (TS _ 19) -> cont 50;
	PT _ (TS _ 20) -> cont 51;
	PT _ (TS _ 21) -> cont 52;
	PT _ (TS _ 22) -> cont 53;
	PT _ (TS _ 23) -> cont 54;
	PT _ (TS _ 24) -> cont 55;
	PT _ (TS _ 25) -> cont 56;
	PT _ (TS _ 26) -> cont 57;
	PT _ (TS _ 27) -> cont 58;
	PT _ (TS _ 28) -> cont 59;
	PT _ (TS _ 29) -> cont 60;
	PT _ (TS _ 30) -> cont 61;
	PT _ (TS _ 31) -> cont 62;
	PT _ (TS _ 32) -> cont 63;
	PT _ (TS _ 33) -> cont 64;
	PT _ (TS _ 34) -> cont 65;
	PT _ (TS _ 35) -> cont 66;
	PT _ (TS _ 36) -> cont 67;
	PT _ (TS _ 37) -> cont 68;
	PT _ (TS _ 38) -> cont 69;
	PT _ (TS _ 39) -> cont 70;
	PT _ (TS _ 40) -> cont 71;
	PT _ (TS _ 41) -> cont 72;
	PT _ (TS _ 42) -> cont 73;
	PT _ (TS _ 43) -> cont 74;
	PT _ (TS _ 44) -> cont 75;
	PT _ (TV happy_dollar_dollar) -> cont 76;
	PT _ (TI happy_dollar_dollar) -> cont 77;
	PT _ (TL happy_dollar_dollar) -> cont 78;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 79 tk tks = happyError' (tks, explist)
happyError_ explist _ tk tks = happyError' ((tk:tks), explist)

happyThen :: () => Err a -> (a -> Err b) -> Err b
happyThen = (thenM)
happyReturn :: () => a -> Err a
happyReturn = (returnM)
happyThen1 m k tks = (thenM) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> Err a
happyReturn1 = \a tks -> (returnM) a
happyError' :: () => ([(Token)], [String]) -> Err a
happyError' = (\(tokens, _) -> happyError tokens)
pProgram tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn7 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


returnM :: a -> Err a
returnM = return

thenM :: Err a -> (a -> Err b) -> Err b
thenM = (>>=)

happyError :: [Token] -> Err a
happyError ts =
  Bad $ "syntax error at " ++ tokenPos ts ++ 
  case ts of
    [] -> []
    [Err _] -> " due to lexer error"
    t:_ -> " before `" ++ id(prToken t) ++ "'"

myLexer = tokens
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "<built-in>" #-}
{-# LINE 1 "<command-line>" #-}







# 1 "/usr/include/stdc-predef.h" 1 3 4

# 17 "/usr/include/stdc-predef.h" 3 4














































{-# LINE 7 "<command-line>" #-}
{-# LINE 1 "/opt/ghc/8.2.2/lib/ghc-8.2.2/include/ghcversion.h" #-}















{-# LINE 7 "<command-line>" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp 









{-# LINE 43 "templates/GenericTemplate.hs" #-}

data Happy_IntList = HappyCons Int Happy_IntList







{-# LINE 65 "templates/GenericTemplate.hs" #-}

{-# LINE 75 "templates/GenericTemplate.hs" #-}

{-# LINE 84 "templates/GenericTemplate.hs" #-}

infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is (1), it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
         (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action

{-# LINE 137 "templates/GenericTemplate.hs" #-}

{-# LINE 147 "templates/GenericTemplate.hs" #-}
indexShortOffAddr arr off = arr Happy_Data_Array.! off


{-# INLINE happyLt #-}
happyLt x y = (x < y)






readArrayBit arr bit =
    Bits.testBit (indexShortOffAddr arr (bit `div` 16)) (bit `mod` 16)






-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Int ->                    -- token number
         Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k - ((1) :: Int)) sts of
         sts1@(((st1@(HappyState (action))):(_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
         let drop_stk = happyDropStk k stk





             _ = nt :: Int
             new_state = action

          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n - ((1) :: Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n - ((1)::Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction

{-# LINE 267 "templates/GenericTemplate.hs" #-}
happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery ((1) is the error token)

-- parse error if we are in recovery and we fail again
happyFail explist (1) tk old_st _ stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--      trace "failing" $ 
        happyError_ explist i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  (1) tk old_st (((HappyState (action))):(sts)) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        action (1) (1) tk (HappyState (action)) sts ((saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail explist i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
        action (1) (1) tk (HappyState (action)) sts ( (HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--      happySeq = happyDoSeq
-- otherwise it emits
--      happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.

{-# LINE 333 "templates/GenericTemplate.hs" #-}
{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
