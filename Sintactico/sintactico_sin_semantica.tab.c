/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton implementation for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "2.3"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Using locations.  */
#define YYLSP_NEEDED 0



/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     VOID = 258,
     FLOAT = 259,
     CONSTANT = 260,
     STRING = 261,
     STRING_C = 262,
     IDENTIFICATOR = 263,
     COMMENT = 264,
     CARACTER = 265,
     LCORCH = 266,
     RCORCH = 267,
     LPARENT = 268,
     RPARENT = 269,
     LKEY = 270,
     RKEY = 271,
     POINT = 272,
     INC = 273,
     DEC = 274,
     ANDOP = 275,
     MULTOP = 276,
     ADDOP = 277,
     MINUSOP = 278,
     VIRGUOP = 279,
     NOTOP = 280,
     DIVOP = 281,
     MODOP = 282,
     LDESP = 283,
     RDESP = 284,
     LOWOP = 285,
     GREATOP = 286,
     LOWEQOP = 287,
     GREATEQOP = 288,
     EQUOP = 289,
     NOTEQOP = 290,
     ELEVADOOP = 291,
     OROP = 292,
     AND = 293,
     OR = 294,
     TWOPOINT = 295,
     SEMICOLON = 296,
     ASIGOP = 297,
     PRODASIGOP = 298,
     DIVASIGOP = 299,
     MODASIGOP = 300,
     SUMASIGOP = 301,
     RESASIGOP = 302,
     COLON = 303,
     BREAK = 304,
     CASE = 305,
     CHAR = 306,
     CONST = 307,
     DEFAULT = 308,
     DO = 309,
     DOUBLE = 310,
     ELSE = 311,
     FOR = 312,
     GOTO = 313,
     IF = 314,
     INT = 315,
     RETURN = 316,
     STRUCT = 317,
     SWITCH = 318,
     TYPEDEF = 319,
     UNION = 320,
     WHILE = 321,
     ESPACIO = 322,
     NUMERO = 323
   };
#endif
/* Tokens.  */
#define VOID 258
#define FLOAT 259
#define CONSTANT 260
#define STRING 261
#define STRING_C 262
#define IDENTIFICATOR 263
#define COMMENT 264
#define CARACTER 265
#define LCORCH 266
#define RCORCH 267
#define LPARENT 268
#define RPARENT 269
#define LKEY 270
#define RKEY 271
#define POINT 272
#define INC 273
#define DEC 274
#define ANDOP 275
#define MULTOP 276
#define ADDOP 277
#define MINUSOP 278
#define VIRGUOP 279
#define NOTOP 280
#define DIVOP 281
#define MODOP 282
#define LDESP 283
#define RDESP 284
#define LOWOP 285
#define GREATOP 286
#define LOWEQOP 287
#define GREATEQOP 288
#define EQUOP 289
#define NOTEQOP 290
#define ELEVADOOP 291
#define OROP 292
#define AND 293
#define OR 294
#define TWOPOINT 295
#define SEMICOLON 296
#define ASIGOP 297
#define PRODASIGOP 298
#define DIVASIGOP 299
#define MODASIGOP 300
#define SUMASIGOP 301
#define RESASIGOP 302
#define COLON 303
#define BREAK 304
#define CASE 305
#define CHAR 306
#define CONST 307
#define DEFAULT 308
#define DO 309
#define DOUBLE 310
#define ELSE 311
#define FOR 312
#define GOTO 313
#define IF 314
#define INT 315
#define RETURN 316
#define STRUCT 317
#define SWITCH 318
#define TYPEDEF 319
#define UNION 320
#define WHILE 321
#define ESPACIO 322
#define NUMERO 323




/* Copy the first part of user declarations.  */
#line 10 "sintactico_sin_semantica.y"

	#include <stdio.h>
	#include <stdlib.h>
	
	extern FILE *yyin; 	/* declarado en lexico */
	extern int numlin; 	/* lexico le da valores */
	//extern char yytext[];
	int yydebug=1; 		/* modo debug si -t */



/* Enabling traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

/* Enabling the token table.  */
#ifndef YYTOKEN_TABLE
# define YYTOKEN_TABLE 0
#endif

#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif



/* Copy the second part of user declarations.  */


/* Line 216 of yacc.c.  */
#line 253 "sintactico_sin_semantica.tab.c"

#ifdef short
# undef short
#endif

#ifdef YYTYPE_UINT8
typedef YYTYPE_UINT8 yytype_uint8;
#else
typedef unsigned char yytype_uint8;
#endif

#ifdef YYTYPE_INT8
typedef YYTYPE_INT8 yytype_int8;
#elif (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
typedef signed char yytype_int8;
#else
typedef short int yytype_int8;
#endif

#ifdef YYTYPE_UINT16
typedef YYTYPE_UINT16 yytype_uint16;
#else
typedef unsigned short int yytype_uint16;
#endif

#ifdef YYTYPE_INT16
typedef YYTYPE_INT16 yytype_int16;
#else
typedef short int yytype_int16;
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif ! defined YYSIZE_T && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned int
# endif
#endif

#define YYSIZE_MAXIMUM ((YYSIZE_T) -1)

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(msgid) dgettext ("bison-runtime", msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(msgid) msgid
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(e) ((void) (e))
#else
# define YYUSE(e) /* empty */
#endif

/* Identity function, used to suppress warnings about constant conditions.  */
#ifndef lint
# define YYID(n) (n)
#else
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static int
YYID (int i)
#else
static int
YYID (i)
    int i;
#endif
{
  return i;
}
#endif

#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#     ifndef _STDLIB_H
#      define _STDLIB_H 1
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's `empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (YYID (0))
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined _STDLIB_H \
       && ! ((defined YYMALLOC || defined malloc) \
	     && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef _STDLIB_H
#    define _STDLIB_H 1
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
	 || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yytype_int16 yyss;
  YYSTYPE yyvs;
  };

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (yytype_int16) + sizeof (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

/* Copy COUNT objects from FROM to TO.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(To, From, Count) \
      __builtin_memcpy (To, From, (Count) * sizeof (*(From)))
#  else
#   define YYCOPY(To, From, Count)		\
      do					\
	{					\
	  YYSIZE_T yyi;				\
	  for (yyi = 0; yyi < (Count); yyi++)	\
	    (To)[yyi] = (From)[yyi];		\
	}					\
      while (YYID (0))
#  endif
# endif

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack)					\
    do									\
      {									\
	YYSIZE_T yynewbytes;						\
	YYCOPY (&yyptr->Stack, Stack, yysize);				\
	Stack = &yyptr->Stack;						\
	yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
	yyptr += yynewbytes / sizeof (*yyptr);				\
      }									\
    while (YYID (0))

#endif

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  3
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   895

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  69
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  60
/* YYNRULES -- Number of rules.  */
#define YYNRULES  162
/* YYNRULES -- Number of states.  */
#define YYNSTATES  299

/* YYTRANSLATE(YYLEX) -- Bison symbol number corresponding to YYLEX.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   323

#define YYTRANSLATE(YYX)						\
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[YYLEX] -- Bison symbol number corresponding to YYLEX.  */
static const yytype_uint8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40,    41,    42,    43,    44,
      45,    46,    47,    48,    49,    50,    51,    52,    53,    54,
      55,    56,    57,    58,    59,    60,    61,    62,    63,    64,
      65,    66,    67,    68
};

#if YYDEBUG
/* YYPRHS[YYN] -- Index of the first RHS symbol of rule number YYN in
   YYRHS.  */
static const yytype_uint16 yyprhs[] =
{
       0,     0,     3,     5,     7,     9,    11,    13,    15,    18,
      20,    23,    26,    31,    37,    43,    44,    48,    53,    58,
      59,    62,    69,    71,    73,    75,    77,    80,    84,    86,
      90,    93,   103,   112,   115,   118,   121,   122,   125,   127,
     129,   130,   132,   134,   136,   138,   140,   143,   145,   147,
     149,   151,   153,   156,   160,   163,   167,   171,   178,   180,
     183,   185,   189,   194,   196,   200,   204,   209,   212,   216,
     219,   223,   226,   230,   233,   237,   241,   246,   251,   252,
     256,   259,   264,   267,   271,   276,   281,   287,   289,   297,
     307,   315,   318,   324,   325,   333,   335,   336,   348,   350,
     352,   354,   356,   358,   363,   365,   367,   369,   371,   375,
     377,   379,   385,   389,   393,   394,   396,   399,   402,   405,
     408,   411,   413,   415,   417,   419,   421,   423,   425,   429,
     433,   437,   439,   443,   447,   449,   453,   457,   459,   463,
     467,   471,   475,   477,   481,   485,   487,   491,   493,   497,
     499,   503,   505,   509,   511,   515,   517,   519,   523,   525,
     529,   531,   535
};

/* YYRHS -- A `-1'-separated list of the rules' RHS.  */
static const yytype_int16 yyrhs[] =
{
      76,     0,    -1,     3,    -1,     4,    -1,    51,    -1,    55,
      -1,    60,    -1,    98,    -1,    71,    98,    -1,   128,    -1,
     128,    92,    -1,    21,   128,    -1,   128,    73,    48,   128,
      -1,   128,    73,    48,   128,    92,    -1,   128,    73,    48,
      21,   128,    -1,    -1,    73,    48,   128,    -1,    73,    48,
     128,    92,    -1,    73,    48,    21,   128,    -1,    -1,    75,
     128,    -1,    75,    15,    71,    16,    72,    41,    -1,    62,
      -1,    65,    -1,    81,    -1,    93,    -1,    93,    92,    -1,
      75,   128,   128,    -1,    77,    -1,    78,    48,    77,    -1,
      64,    99,    -1,    70,     8,    13,    78,    14,    15,    83,
      85,    16,    -1,    70,     8,    13,    14,    15,    83,    85,
      16,    -1,    81,    80,    -1,    81,    99,    -1,    81,    79,
      -1,    -1,    99,    82,    -1,    99,    -1,    82,    -1,    -1,
      86,    -1,    87,    -1,    88,    -1,    89,    -1,    84,    -1,
      85,    84,    -1,   104,    -1,   100,    -1,   106,    -1,   102,
      -1,   101,    -1,    49,    41,    -1,    58,   128,    41,    -1,
      61,    41,    -1,    61,   127,    41,    -1,   128,    40,    84,
      -1,    50,    68,    40,    15,    85,    16,    -1,    41,    -1,
     127,    41,    -1,   128,    -1,    15,    91,    16,    -1,    15,
      91,    48,    16,    -1,    90,    -1,    91,    48,    90,    -1,
      11,    68,    12,    -1,    92,    11,    68,    12,    -1,    11,
      12,    -1,    92,    11,    12,    -1,    70,     8,    -1,    70,
      21,     8,    -1,    70,     8,    -1,    70,    21,     8,    -1,
      70,     8,    -1,    70,    21,     8,    -1,    96,    48,     8,
      -1,    96,    48,     8,    92,    -1,    96,    48,    21,     8,
      -1,    -1,    75,     8,     8,    -1,    94,    41,    -1,    94,
      92,    96,    41,    -1,    97,    41,    -1,    95,    96,    41,
      -1,    95,    42,   127,    41,    -1,    95,    92,    96,    41,
      -1,    95,    92,    42,    90,    41,    -1,    74,    -1,    59,
      13,   127,    14,    15,    85,    16,    -1,    54,    15,    85,
      16,    66,    13,   127,    14,    41,    -1,    63,    13,   127,
      14,    15,   103,    16,    -1,    88,   103,    -1,    53,    40,
      15,    85,    16,    -1,    -1,    66,    13,   127,    14,    15,
      85,    16,    -1,   127,    -1,    -1,    57,    13,   105,    41,
     105,    41,   105,    14,    15,    85,    16,    -1,    20,    -1,
      21,    -1,    24,    -1,    25,    -1,   112,    -1,    13,    70,
      14,   108,    -1,   128,    -1,    68,    -1,     6,    -1,     7,
      -1,    13,   127,    14,    -1,    10,    -1,   109,    -1,     8,
      11,   126,    12,   111,    -1,   110,    17,   128,    -1,    11,
     126,    12,    -1,    -1,   110,    -1,   107,     8,    -1,   112,
      18,    -1,   112,    19,    -1,    18,   110,    -1,    19,   110,
      -1,    42,    -1,    43,    -1,    44,    -1,    45,    -1,    46,
      -1,    47,    -1,   108,    -1,   114,    21,   108,    -1,   114,
      26,   108,    -1,   114,    27,   108,    -1,   114,    -1,   115,
      22,   114,    -1,   115,    23,   114,    -1,   115,    -1,   116,
      28,   115,    -1,   116,    29,   115,    -1,   116,    -1,   117,
      30,   116,    -1,   117,    31,   116,    -1,   117,    32,   116,
      -1,   117,    33,   116,    -1,   117,    -1,   118,    34,   117,
      -1,   118,    35,   117,    -1,   118,    -1,   119,    20,   118,
      -1,   119,    -1,   120,    36,   119,    -1,   120,    -1,   121,
      37,   120,    -1,   121,    -1,   122,    38,   121,    -1,   122,
      -1,   123,    39,   122,    -1,   123,    -1,   124,    -1,   112,
     113,   125,    -1,   125,    -1,   126,    48,   125,    -1,   125,
      -1,   127,    48,   125,    -1,     8,    -1
};

/* YYRLINE[YYN] -- source line where rule number YYN was defined.  */
static const yytype_uint16 yyrline[] =
{
       0,    36,    36,    37,    38,    39,    40,    46,    47,    51,
      52,    53,    54,    55,    56,    57,    61,    62,    63,    64,
      68,    69,    74,    75,    81,    87,    88,    89,    93,    94,
      99,   109,   113,   118,   119,   120,   121,   125,   126,   130,
     131,   135,   136,   137,   138,   145,   146,   150,   151,   152,
     153,   154,   158,   160,   161,   162,   166,   167,   173,   174,
     179,   180,   181,   185,   186,   191,   192,   193,   194,   199,
     200,   204,   205,   209,   210,   214,   215,   216,   217,   227,
     231,   232,   233,   237,   238,   239,   240,   241,   248,   266,
     278,   282,   283,   284,   291,   295,   296,   304,   312,   313,
     316,   317,   321,   322,   327,   332,   333,   334,   335,   336,
     342,   343,   344,   348,   349,   353,   354,   355,   356,   357,
     358,   362,   363,   364,   365,   366,   367,   371,   372,   373,
     374,   378,   379,   380,   385,   386,   387,   391,   392,   393,
     394,   395,   400,   401,   402,   406,   407,   411,   412,   416,
     417,   421,   422,   426,   427,   431,   435,   436,   440,   441,
     446,   447,   451
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || YYTOKEN_TABLE
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "VOID", "FLOAT", "CONSTANT", "STRING",
  "STRING_C", "IDENTIFICATOR", "COMMENT", "CARACTER", "LCORCH", "RCORCH",
  "LPARENT", "RPARENT", "LKEY", "RKEY", "POINT", "INC", "DEC", "ANDOP",
  "MULTOP", "ADDOP", "MINUSOP", "VIRGUOP", "NOTOP", "DIVOP", "MODOP",
  "LDESP", "RDESP", "LOWOP", "GREATOP", "LOWEQOP", "GREATEQOP", "EQUOP",
  "NOTEQOP", "ELEVADOOP", "OROP", "AND", "OR", "TWOPOINT", "SEMICOLON",
  "ASIGOP", "PRODASIGOP", "DIVASIGOP", "MODASIGOP", "SUMASIGOP",
  "RESASIGOP", "COLON", "BREAK", "CASE", "CHAR", "CONST", "DEFAULT", "DO",
  "DOUBLE", "ELSE", "FOR", "GOTO", "IF", "INT", "RETURN", "STRUCT",
  "SWITCH", "TYPEDEF", "UNION", "WHILE", "ESPACIO", "NUMERO", "$accept",
  "tipo", "declaraciones_variables_struct", "identificadores_struct",
  "mas_identificadores_struct", "especificacion_struct_o_union",
  "struct_o_union", "programa", "parametro", "paso_parametros",
  "definicion_tipo", "declaracion_funcion", "declaraciones",
  "declaraciones_variables", "posible_declaraciones_variables",
  "sentencia", "lista_sentencias", "sentencias_control",
  "sentencias_salto", "sentencias_etiquetas", "sentencias_expresiones",
  "inicializador", "lista_inicializador", "corchetes",
  "declaracion_variable_simple_parametro",
  "declaracion_variable_simple_struct", "declaracion_variable_simple",
  "mas_identificadores", "declaracion_struct_struct",
  "declaracion_variables_struct", "declaracion_variables", "sentencia_if",
  "sentencia_do_while", "sentencia_switch", "muchas_sentencias_etiquetas",
  "sentencia_while", "posible_expresion", "sentencia_for",
  "operador_unario", "expresion_cast", "expresion_primaria",
  "expresion_asignable", "posible_matriz", "expresion_unaria",
  "operador_asignacion", "expresion_multiplicativa", "expresion_aditiva",
  "expresion_shift", "expresion_relacional", "expresion_igualdad",
  "expresion_and", "expresion_exclusiva_or", "expresion_inclusiva_or",
  "expresion_logica_and", "expresion_logica_or", "expresion_condicional",
  "expresion_asignacion", "expresion_vector", "expresion", "identificador", 0
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[YYLEX-NUM] -- Internal token number corresponding to
   token YYLEX-NUM.  */
static const yytype_uint16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286,   287,   288,   289,   290,   291,   292,   293,   294,
     295,   296,   297,   298,   299,   300,   301,   302,   303,   304,
     305,   306,   307,   308,   309,   310,   311,   312,   313,   314,
     315,   316,   317,   318,   319,   320,   321,   322,   323
};
# endif

/* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    69,    70,    70,    70,    70,    70,    71,    71,    72,
      72,    72,    72,    72,    72,    72,    73,    73,    73,    73,
      74,    74,    75,    75,    76,    77,    77,    77,    78,    78,
      79,    80,    80,    81,    81,    81,    81,    82,    82,    83,
      83,    84,    84,    84,    84,    85,    85,    86,    86,    86,
      86,    86,    87,    87,    87,    87,    88,    88,    89,    89,
      90,    90,    90,    91,    91,    92,    92,    92,    92,    93,
      93,    94,    94,    95,    95,    96,    96,    96,    96,    97,
      98,    98,    98,    99,    99,    99,    99,    99,   100,   101,
     102,   103,   103,   103,   104,   105,   105,   106,   107,   107,
     107,   107,   108,   108,   109,   109,   109,   109,   109,   109,
     110,   110,   110,   111,   111,   112,   112,   112,   112,   112,
     112,   113,   113,   113,   113,   113,   113,   114,   114,   114,
     114,   115,   115,   115,   116,   116,   116,   117,   117,   117,
     117,   117,   118,   118,   118,   119,   119,   120,   120,   121,
     121,   122,   122,   123,   123,   124,   125,   125,   126,   126,
     127,   127,   128
};

/* YYR2[YYN] -- Number of symbols composing right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     1,     1,     1,     1,     1,     1,     2,     1,
       2,     2,     4,     5,     5,     0,     3,     4,     4,     0,
       2,     6,     1,     1,     1,     1,     2,     3,     1,     3,
       2,     9,     8,     2,     2,     2,     0,     2,     1,     1,
       0,     1,     1,     1,     1,     1,     2,     1,     1,     1,
       1,     1,     2,     3,     2,     3,     3,     6,     1,     2,
       1,     3,     4,     1,     3,     3,     4,     2,     3,     2,
       3,     2,     3,     2,     3,     3,     4,     4,     0,     3,
       2,     4,     2,     3,     4,     4,     5,     1,     7,     9,
       7,     2,     5,     0,     7,     1,     0,    11,     1,     1,
       1,     1,     1,     4,     1,     1,     1,     1,     3,     1,
       1,     5,     3,     3,     0,     1,     2,     2,     2,     2,
       2,     1,     1,     1,     1,     1,     1,     1,     3,     3,
       3,     1,     3,     3,     1,     3,     3,     1,     3,     3,
       3,     3,     1,     3,     3,     1,     3,     1,     3,     1,
       3,     1,     3,     1,     3,     1,     1,     3,     1,     3,
       1,     3,     1
};

/* YYDEFACT[STATE-NAME] -- Default rule to reduce with in state
   STATE-NUM when YYTABLE doesn't specify something else to do.  Zero
   means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
      36,     0,    24,     1,     2,     3,     4,     5,     6,    22,
       0,    23,     0,    87,     0,    35,    33,    78,    34,     0,
      30,    73,     0,   162,     0,    20,     0,     0,    78,     0,
      73,     0,    74,     0,     0,     0,     0,     0,     7,    67,
       0,   106,   107,   162,   109,     0,     0,     0,    98,    99,
     100,   101,   105,     0,   127,   110,   115,   102,   131,   134,
     137,   142,   145,   147,   149,   151,   153,   155,   156,   160,
       0,   104,     0,     0,     0,    83,     0,     0,     0,     0,
      28,     0,    25,    71,     0,    15,     8,     0,    80,    78,
      82,    65,     0,     0,     0,     0,   119,   120,   116,     0,
     117,   118,   121,   122,   123,   124,   125,   126,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,    84,     0,    68,
       0,     0,     0,    60,    85,    75,     0,    40,    69,     0,
       0,     0,     0,    26,    72,     0,     0,     9,    79,     0,
     158,     0,     0,   108,   112,   157,   128,   102,   129,   130,
     132,   133,   135,   136,   138,   139,   140,   141,   143,   144,
     146,   148,   150,   152,   154,   161,    66,    63,     0,    86,
      76,    77,    39,     0,    38,    70,    27,    40,    29,    11,
      21,     0,    10,    81,   114,     0,   103,    61,     0,    58,
       0,     0,     0,     0,     0,     0,     0,     0,     0,    45,
       0,    41,    42,    43,    44,    48,    51,    50,    47,    49,
       0,   104,    37,     0,     0,     0,   111,   159,    62,    64,
      52,     0,     0,    96,     0,     0,    54,     0,     0,     0,
      32,    46,    59,     0,     0,     0,    12,     0,     0,     0,
       0,    95,    53,     0,    55,     0,     0,    56,    31,    14,
      13,   113,     0,     0,    96,     0,     0,     0,     0,     0,
       0,     0,    93,     0,    57,     0,    96,     0,     0,    93,
       0,     0,     0,     0,     0,    88,     0,    91,    90,    94,
       0,     0,     0,    89,     0,     0,     0,    92,    97
};

/* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int16 yydefgoto[] =
{
      -1,    19,    34,   146,   191,    13,    14,     1,    80,    81,
      15,    16,     2,   182,   183,   209,   210,   211,   212,   213,
     214,   132,   178,    28,    82,    36,    17,    29,    37,    38,
     184,   215,   216,   217,   280,   218,   250,   219,    53,    54,
      55,    56,   226,    57,   108,    58,    59,    60,    61,    62,
      63,    64,    65,    66,    67,    68,    69,   151,   220,    71
};

/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
   STATE-NUM.  */
#define YYPACT_NINF -257
static const yytype_int16 yypact[] =
{
    -257,    33,    13,  -257,  -257,  -257,  -257,  -257,  -257,  -257,
     143,  -257,    93,  -257,    15,  -257,  -257,     4,  -257,    99,
    -257,    24,   102,  -257,   143,  -257,    -6,   306,    63,   116,
    -257,    37,  -257,   108,    53,   120,    80,    92,  -257,  -257,
     151,  -257,  -257,   134,  -257,   131,    19,    19,  -257,  -257,
    -257,  -257,  -257,   175,  -257,  -257,   162,   335,   200,   194,
     195,   206,   198,   169,   189,   155,   163,   201,  -257,  -257,
     137,  -257,    -2,   187,   156,  -257,   132,   213,   140,   234,
    -257,    22,   223,  -257,   245,   146,  -257,   254,  -257,   253,
    -257,  -257,   306,   252,    41,   306,   162,   162,  -257,   234,
    -257,  -257,  -257,  -257,  -257,  -257,  -257,  -257,   306,   306,
     306,   306,   306,   306,   306,   306,   306,   306,   306,   306,
     306,   306,   306,   306,   306,   306,   306,  -257,   306,  -257,
     255,   187,   230,  -257,  -257,   223,   265,   143,  -257,   266,
     234,   260,   143,   253,  -257,   234,   235,    -4,  -257,   159,
    -257,    38,   306,  -257,  -257,  -257,  -257,   226,  -257,  -257,
     200,   200,   194,   194,   195,   195,   195,   195,   206,   206,
     198,   169,   189,   155,   163,  -257,  -257,  -257,    12,  -257,
     253,  -257,  -257,   783,   143,  -257,  -257,   143,  -257,  -257,
    -257,   229,   253,  -257,   268,   306,  -257,  -257,   172,  -257,
     247,   222,   276,   280,   234,   281,   152,   283,   288,  -257,
     279,  -257,  -257,  -257,  -257,  -257,  -257,  -257,  -257,  -257,
     165,   262,  -257,   783,   160,   306,  -257,  -257,  -257,  -257,
    -257,   267,   783,   306,   264,   306,  -257,   171,   306,   306,
    -257,  -257,  -257,   783,   342,   234,     1,    42,   291,   405,
     269,   261,  -257,    79,  -257,    82,    84,  -257,  -257,   263,
      10,  -257,   783,   242,   306,   300,   302,   303,   468,   308,
     282,   783,    30,   783,  -257,   306,   306,   531,   292,    30,
     318,   262,   594,    95,   321,  -257,   307,  -257,  -257,  -257,
     298,   326,   783,  -257,   783,   657,   720,  -257,  -257
};

/* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
    -257,     0,  -257,  -257,  -257,  -257,   -20,  -257,   202,  -257,
    -257,  -257,  -257,   167,   170,  -201,  -210,  -257,  -257,   -57,
    -257,  -126,  -257,   -35,  -257,  -257,  -257,   -10,  -257,   309,
     109,  -257,  -257,  -257,    67,  -257,  -256,  -257,  -257,    14,
    -257,   128,  -257,   743,  -257,   148,   141,   133,   149,   237,
     233,   240,   243,   239,  -257,  -257,   -89,   144,     8,   -14
};

/* YYTABLE[YYPACT[STATE-NUM]].  What to do in state STATE-NUM.  If
   positive, shift that token.  If negative, reduce the rule which
   number is the opposite.  If zero, do what YYDEFACT says.
   If YYTABLE_NINF, syntax error.  */
#define YYTABLE_NINF -20
static const yytype_int16 yytable[] =
{
      25,    89,    12,   150,    35,   177,    39,    26,   270,   241,
     129,    79,    26,   244,    35,    26,     4,     5,    74,   155,
     284,    72,   249,    23,    33,    41,    42,    43,   197,    44,
      24,    78,    95,     3,    33,    70,   141,    31,    23,   175,
       4,     5,   257,   241,   -19,    93,    27,   143,   241,   -16,
     194,    77,   268,    94,   261,   153,     4,     5,   -17,   133,
     198,   277,    40,   282,     6,   140,   130,   241,     7,    85,
     142,   147,   229,     8,    72,     9,   241,    10,    11,   149,
     201,   241,   295,   278,   296,   154,   195,    52,     6,   128,
     195,    26,     7,   265,   241,   241,   266,     8,   267,     9,
     180,    21,    11,    94,     6,    73,   227,    30,     7,   290,
      32,    18,   192,     8,    22,     9,    83,   133,    11,    20,
      22,    88,    79,   156,   158,   159,   186,   128,    87,    84,
     128,   189,   128,    90,     4,     5,   150,    41,    42,    43,
     135,    44,    78,   128,    45,    92,     4,     5,   138,    46,
      47,    48,    49,   136,    23,    50,    51,    75,    41,    42,
      43,   139,    44,    91,    76,    45,   196,   145,    23,   221,
      46,    47,    48,    49,    96,    97,    50,    51,   127,    99,
      23,   245,     6,    98,   133,   128,     7,   131,   228,   122,
     234,     8,   124,   236,     6,    23,   221,   134,     7,    52,
     193,   125,   131,     8,    76,     9,   242,    76,    11,   221,
     246,   260,   254,   128,   237,   279,   112,   113,   221,   128,
      52,   109,   279,   114,   115,   123,   110,   111,   137,   221,
     221,   259,   120,   121,    26,   221,   116,   117,   118,   119,
     126,   251,    23,   253,   100,   101,   255,   256,   221,   164,
     165,   166,   167,   144,   221,   162,   163,   221,   281,   221,
     160,   161,   148,   221,    72,   281,   152,   176,   221,   168,
     169,   179,   251,   181,   185,   187,   190,   224,   221,   225,
     221,   221,   221,   283,   251,    41,    42,    43,   230,    44,
     231,   232,    45,   233,   235,   240,   238,    46,    47,    48,
      49,   239,   243,    50,    51,   252,   262,   248,   269,   128,
     264,   -18,    41,    42,    43,   271,    44,   272,   273,    45,
     199,   275,   292,   276,    46,    47,    48,    49,   200,   201,
      50,    51,   286,   202,   288,   291,   203,   204,   205,   293,
     206,   294,   207,    86,   188,   208,   287,    52,    41,    42,
      43,   222,    44,   100,   101,    45,   171,   223,   258,   170,
      46,    47,    48,    49,   172,   174,    50,    51,   173,   247,
       0,     0,     0,     0,    52,     0,     0,   102,   103,   104,
     105,   106,   107,   199,     0,     0,     0,     0,     0,     0,
       0,   200,   201,     0,     0,     0,   202,     0,     0,   203,
     204,   205,     0,   206,     0,   207,     0,     0,   208,     0,
      52,    41,    42,    43,     0,    44,     0,     0,    45,     0,
       0,   263,     0,    46,    47,    48,    49,     0,     0,    50,
      51,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,   199,     0,     0,     0,
       0,     0,     0,     0,   200,   201,     0,     0,     0,   202,
       0,     0,   203,   204,   205,     0,   206,     0,   207,     0,
       0,   208,     0,    52,    41,    42,    43,     0,    44,     0,
       0,    45,     0,     0,   274,     0,    46,    47,    48,    49,
       0,     0,    50,    51,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,   199,
       0,     0,     0,     0,     0,     0,     0,   200,   201,     0,
       0,     0,   202,     0,     0,   203,   204,   205,     0,   206,
       0,   207,     0,     0,   208,     0,    52,    41,    42,    43,
       0,    44,     0,     0,    45,     0,     0,   285,     0,    46,
      47,    48,    49,     0,     0,    50,    51,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,   199,     0,     0,     0,     0,     0,     0,     0,
     200,   201,     0,     0,     0,   202,     0,     0,   203,   204,
     205,     0,   206,     0,   207,     0,     0,   208,     0,    52,
      41,    42,    43,     0,    44,     0,     0,    45,     0,     0,
     289,     0,    46,    47,    48,    49,     0,     0,    50,    51,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,   199,     0,     0,     0,     0,
       0,     0,     0,   200,   201,     0,     0,     0,   202,     0,
       0,   203,   204,   205,     0,   206,     0,   207,     0,     0,
     208,     0,    52,    41,    42,    43,     0,    44,     0,     0,
      45,     0,     0,   297,     0,    46,    47,    48,    49,     0,
       0,    50,    51,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,   199,     0,
       0,     0,     0,     0,     0,     0,   200,   201,     0,     0,
       0,   202,     0,     0,   203,   204,   205,     0,   206,     0,
     207,     0,     0,   208,     0,    52,    41,    42,    43,     0,
      44,     0,     0,    45,     0,     0,   298,     0,    46,    47,
      48,    49,     0,     0,    50,    51,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,   199,     0,     0,     0,     0,     0,     0,     0,   200,
     201,     0,     0,     0,   202,     0,     0,   203,   204,   205,
       0,   206,     0,   207,     0,     0,   208,     0,    52,    41,
      42,    43,     0,    44,     0,     0,    45,     0,     0,     0,
       0,    46,    47,    48,    49,     0,     0,    50,    51,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,   199,     0,     0,     0,     0,     0,
       0,     0,   200,   201,     0,     0,     0,   202,     0,     0,
     203,   204,   205,     0,   206,     0,   207,     0,     0,   208,
       0,    52,   157,   157,   157,   157,   157,   157,   157,   157,
     157,   157,   157,   157,   157,   157,   157,   157,   157,   157,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,   157
};

static const yytype_int16 yycheck[] =
{
      14,    36,     2,    92,    24,   131,    12,    11,   264,   210,
      12,    31,    11,   223,    34,    11,     3,     4,    28,   108,
     276,    11,   232,     8,    24,     6,     7,     8,    16,    10,
      15,    31,    13,     0,    34,    27,    14,    13,     8,   128,
       3,     4,   243,   244,    48,    45,    42,    82,   249,    48,
      12,    14,   262,    45,    12,    14,     3,     4,    48,    73,
      48,   271,    68,   273,    51,    79,    68,   268,    55,    16,
      48,    85,   198,    60,    11,    62,   277,    64,    65,    89,
      50,   282,   292,    53,   294,    99,    48,    68,    51,    48,
      48,    11,    55,    14,   295,   296,    14,    60,    14,    62,
     135,     8,    65,    95,    51,    42,   195,     8,    55,    14,
       8,     2,   147,    60,    21,    62,     8,   131,    65,    10,
      21,    41,   142,   109,   110,   111,   140,    48,     8,    21,
      48,   145,    48,    41,     3,     4,   225,     6,     7,     8,
       8,    10,   142,    48,    13,    11,     3,     4,     8,    18,
      19,    20,    21,    21,     8,    24,    25,    41,     6,     7,
       8,    21,    10,    12,    48,    13,   152,    21,     8,   183,
      18,    19,    20,    21,    46,    47,    24,    25,    41,    17,
       8,    21,    51,     8,   198,    48,    55,    15,    16,    20,
     204,    60,    37,    41,    51,     8,   210,    41,    55,    68,
      41,    38,    15,    60,    48,    62,    41,    48,    65,   223,
     224,   246,    41,    48,   206,   272,    22,    23,   232,    48,
      68,    21,   279,    28,    29,    36,    26,    27,    15,   243,
     244,   245,    34,    35,    11,   249,    30,    31,    32,    33,
      39,   233,     8,   235,    18,    19,   238,   239,   262,   116,
     117,   118,   119,     8,   268,   114,   115,   271,   272,   273,
     112,   113,     8,   277,    11,   279,    14,    12,   282,   120,
     121,    41,   264,     8,     8,    15,    41,    48,   292,    11,
     294,   295,   296,   275,   276,     6,     7,     8,    41,    10,
      68,    15,    13,    13,    13,    16,    13,    18,    19,    20,
      21,    13,    40,    24,    25,    41,    15,    40,    66,    48,
      41,    48,     6,     7,     8,    15,    10,    15,    15,    13,
      41,    13,    15,    41,    18,    19,    20,    21,    49,    50,
      24,    25,    40,    54,    16,    14,    57,    58,    59,    41,
      61,    15,    63,    34,   142,    66,   279,    68,     6,     7,
       8,   184,    10,    18,    19,    13,   123,   187,    16,   122,
      18,    19,    20,    21,   124,   126,    24,    25,   125,   225,
      -1,    -1,    -1,    -1,    68,    -1,    -1,    42,    43,    44,
      45,    46,    47,    41,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    49,    50,    -1,    -1,    -1,    54,    -1,    -1,    57,
      58,    59,    -1,    61,    -1,    63,    -1,    -1,    66,    -1,
      68,     6,     7,     8,    -1,    10,    -1,    -1,    13,    -1,
      -1,    16,    -1,    18,    19,    20,    21,    -1,    -1,    24,
      25,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    41,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    49,    50,    -1,    -1,    -1,    54,
      -1,    -1,    57,    58,    59,    -1,    61,    -1,    63,    -1,
      -1,    66,    -1,    68,     6,     7,     8,    -1,    10,    -1,
      -1,    13,    -1,    -1,    16,    -1,    18,    19,    20,    21,
      -1,    -1,    24,    25,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    41,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    49,    50,    -1,
      -1,    -1,    54,    -1,    -1,    57,    58,    59,    -1,    61,
      -1,    63,    -1,    -1,    66,    -1,    68,     6,     7,     8,
      -1,    10,    -1,    -1,    13,    -1,    -1,    16,    -1,    18,
      19,    20,    21,    -1,    -1,    24,    25,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    41,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      49,    50,    -1,    -1,    -1,    54,    -1,    -1,    57,    58,
      59,    -1,    61,    -1,    63,    -1,    -1,    66,    -1,    68,
       6,     7,     8,    -1,    10,    -1,    -1,    13,    -1,    -1,
      16,    -1,    18,    19,    20,    21,    -1,    -1,    24,    25,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    41,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    49,    50,    -1,    -1,    -1,    54,    -1,
      -1,    57,    58,    59,    -1,    61,    -1,    63,    -1,    -1,
      66,    -1,    68,     6,     7,     8,    -1,    10,    -1,    -1,
      13,    -1,    -1,    16,    -1,    18,    19,    20,    21,    -1,
      -1,    24,    25,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    41,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    49,    50,    -1,    -1,
      -1,    54,    -1,    -1,    57,    58,    59,    -1,    61,    -1,
      63,    -1,    -1,    66,    -1,    68,     6,     7,     8,    -1,
      10,    -1,    -1,    13,    -1,    -1,    16,    -1,    18,    19,
      20,    21,    -1,    -1,    24,    25,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    41,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    49,
      50,    -1,    -1,    -1,    54,    -1,    -1,    57,    58,    59,
      -1,    61,    -1,    63,    -1,    -1,    66,    -1,    68,     6,
       7,     8,    -1,    10,    -1,    -1,    13,    -1,    -1,    -1,
      -1,    18,    19,    20,    21,    -1,    -1,    24,    25,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    41,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    49,    50,    -1,    -1,    -1,    54,    -1,    -1,
      57,    58,    59,    -1,    61,    -1,    63,    -1,    -1,    66,
      -1,    68,   109,   110,   111,   112,   113,   114,   115,   116,
     117,   118,   119,   120,   121,   122,   123,   124,   125,   126,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,   152
};

/* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
   symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,    76,    81,     0,     3,     4,    51,    55,    60,    62,
      64,    65,    70,    74,    75,    79,    80,    95,    99,    70,
      99,     8,    21,     8,    15,   128,    11,    42,    92,    96,
       8,    13,     8,    70,    71,    75,    94,    97,    98,    12,
      68,     6,     7,     8,    10,    13,    18,    19,    20,    21,
      24,    25,    68,   107,   108,   109,   110,   112,   114,   115,
     116,   117,   118,   119,   120,   121,   122,   123,   124,   125,
     127,   128,    11,    42,    96,    41,    48,    14,    70,    75,
      77,    78,    93,     8,    21,    16,    98,     8,    41,    92,
      41,    12,    11,    70,   127,    13,   110,   110,     8,    17,
      18,    19,    42,    43,    44,    45,    46,    47,   113,    21,
      26,    27,    22,    23,    28,    29,    30,    31,    32,    33,
      34,    35,    20,    36,    37,    38,    39,    41,    48,    12,
      68,    15,    90,   128,    41,     8,    21,    15,     8,    21,
     128,    14,    48,    92,     8,    21,    72,   128,     8,    96,
     125,   126,    14,    14,   128,   125,   108,   112,   108,   108,
     114,   114,   115,   115,   116,   116,   116,   116,   117,   117,
     118,   119,   120,   121,   122,   125,    12,    90,    91,    41,
      92,     8,    82,    83,    99,     8,   128,    15,    77,   128,
      41,    73,    92,    41,    12,    48,   108,    16,    48,    41,
      49,    50,    54,    57,    58,    59,    61,    63,    66,    84,
      85,    86,    87,    88,    89,   100,   101,   102,   104,   106,
     127,   128,    82,    83,    48,    11,   111,   125,    16,    90,
      41,    68,    15,    13,   128,    13,    41,   127,    13,    13,
      16,    84,    41,    40,    85,    21,   128,   126,    40,    85,
     105,   127,    41,   127,    41,   127,   127,    84,    16,   128,
      92,    12,    15,    16,    41,    14,    14,    14,    85,    66,
     105,    15,    15,    15,    16,    13,    41,    85,    53,    88,
     103,   128,    85,   127,   105,    16,    40,   103,    16,    16,
      14,    14,    15,    41,    15,    85,    85,    16,    16
};

#define yyerrok		(yyerrstatus = 0)
#define yyclearin	(yychar = YYEMPTY)
#define YYEMPTY		(-2)
#define YYEOF		0

#define YYACCEPT	goto yyacceptlab
#define YYABORT		goto yyabortlab
#define YYERROR		goto yyerrorlab


/* Like YYERROR except do call yyerror.  This remains here temporarily
   to ease the transition to the new meaning of YYERROR, for GCC.
   Once GCC version 2 has supplanted version 1, this can go.  */

#define YYFAIL		goto yyerrlab

#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)					\
do								\
  if (yychar == YYEMPTY && yylen == 1)				\
    {								\
      yychar = (Token);						\
      yylval = (Value);						\
      yytoken = YYTRANSLATE (yychar);				\
      YYPOPSTACK (1);						\
      goto yybackup;						\
    }								\
  else								\
    {								\
      yyerror (YY_("syntax error: cannot back up")); \
      YYERROR;							\
    }								\
while (YYID (0))


#define YYTERROR	1
#define YYERRCODE	256


/* YYLLOC_DEFAULT -- Set CURRENT to span from RHS[1] to RHS[N].
   If N is 0, then set CURRENT to the empty location which ends
   the previous symbol: RHS[0] (always defined).  */

#define YYRHSLOC(Rhs, K) ((Rhs)[K])
#ifndef YYLLOC_DEFAULT
# define YYLLOC_DEFAULT(Current, Rhs, N)				\
    do									\
      if (YYID (N))                                                    \
	{								\
	  (Current).first_line   = YYRHSLOC (Rhs, 1).first_line;	\
	  (Current).first_column = YYRHSLOC (Rhs, 1).first_column;	\
	  (Current).last_line    = YYRHSLOC (Rhs, N).last_line;		\
	  (Current).last_column  = YYRHSLOC (Rhs, N).last_column;	\
	}								\
      else								\
	{								\
	  (Current).first_line   = (Current).last_line   =		\
	    YYRHSLOC (Rhs, 0).last_line;				\
	  (Current).first_column = (Current).last_column =		\
	    YYRHSLOC (Rhs, 0).last_column;				\
	}								\
    while (YYID (0))
#endif


/* YY_LOCATION_PRINT -- Print the location on the stream.
   This macro was not mandated originally: define only if we know
   we won't break user code: when these are the locations we know.  */

#ifndef YY_LOCATION_PRINT
# if defined YYLTYPE_IS_TRIVIAL && YYLTYPE_IS_TRIVIAL
#  define YY_LOCATION_PRINT(File, Loc)			\
     fprintf (File, "%d.%d-%d.%d",			\
	      (Loc).first_line, (Loc).first_column,	\
	      (Loc).last_line,  (Loc).last_column)
# else
#  define YY_LOCATION_PRINT(File, Loc) ((void) 0)
# endif
#endif


/* YYLEX -- calling `yylex' with the right arguments.  */

#ifdef YYLEX_PARAM
# define YYLEX yylex (YYLEX_PARAM)
#else
# define YYLEX yylex ()
#endif

/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)			\
do {						\
  if (yydebug)					\
    YYFPRINTF Args;				\
} while (YYID (0))

# define YY_SYMBOL_PRINT(Title, Type, Value, Location)			  \
do {									  \
  if (yydebug)								  \
    {									  \
      YYFPRINTF (stderr, "%s ", Title);					  \
      yy_symbol_print (stderr,						  \
		  Type, Value); \
      YYFPRINTF (stderr, "\n");						  \
    }									  \
} while (YYID (0))


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

/*ARGSUSED*/
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_symbol_value_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
#else
static void
yy_symbol_value_print (yyoutput, yytype, yyvaluep)
    FILE *yyoutput;
    int yytype;
    YYSTYPE const * const yyvaluep;
#endif
{
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
# else
  YYUSE (yyoutput);
# endif
  switch (yytype)
    {
      default:
	break;
    }
}


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_symbol_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
#else
static void
yy_symbol_print (yyoutput, yytype, yyvaluep)
    FILE *yyoutput;
    int yytype;
    YYSTYPE const * const yyvaluep;
#endif
{
  if (yytype < YYNTOKENS)
    YYFPRINTF (yyoutput, "token %s (", yytname[yytype]);
  else
    YYFPRINTF (yyoutput, "nterm %s (", yytname[yytype]);

  yy_symbol_value_print (yyoutput, yytype, yyvaluep);
  YYFPRINTF (yyoutput, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_stack_print (yytype_int16 *bottom, yytype_int16 *top)
#else
static void
yy_stack_print (bottom, top)
    yytype_int16 *bottom;
    yytype_int16 *top;
#endif
{
  YYFPRINTF (stderr, "Stack now");
  for (; bottom <= top; ++bottom)
    YYFPRINTF (stderr, " %d", *bottom);
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)				\
do {								\
  if (yydebug)							\
    yy_stack_print ((Bottom), (Top));				\
} while (YYID (0))


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_reduce_print (YYSTYPE *yyvsp, int yyrule)
#else
static void
yy_reduce_print (yyvsp, yyrule)
    YYSTYPE *yyvsp;
    int yyrule;
#endif
{
  int yynrhs = yyr2[yyrule];
  int yyi;
  unsigned long int yylno = yyrline[yyrule];
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %lu):\n",
	     yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      fprintf (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr, yyrhs[yyprhs[yyrule] + yyi],
		       &(yyvsp[(yyi + 1) - (yynrhs)])
		       		       );
      fprintf (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)		\
do {					\
  if (yydebug)				\
    yy_reduce_print (yyvsp, Rule); \
} while (YYID (0))

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef	YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif



#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen strlen
#  else
/* Return the length of YYSTR.  */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static YYSIZE_T
yystrlen (const char *yystr)
#else
static YYSIZE_T
yystrlen (yystr)
    const char *yystr;
#endif
{
  YYSIZE_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static char *
yystpcpy (char *yydest, const char *yysrc)
#else
static char *
yystpcpy (yydest, yysrc)
    char *yydest;
    const char *yysrc;
#endif
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYSIZE_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYSIZE_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
	switch (*++yyp)
	  {
	  case '\'':
	  case ',':
	    goto do_not_strip_quotes;

	  case '\\':
	    if (*++yyp != '\\')
	      goto do_not_strip_quotes;
	    /* Fall through.  */
	  default:
	    if (yyres)
	      yyres[yyn] = *yyp;
	    yyn++;
	    break;

	  case '"':
	    if (yyres)
	      yyres[yyn] = '\0';
	    return yyn;
	  }
    do_not_strip_quotes: ;
    }

  if (! yyres)
    return yystrlen (yystr);

  return yystpcpy (yyres, yystr) - yyres;
}
# endif

/* Copy into YYRESULT an error message about the unexpected token
   YYCHAR while in state YYSTATE.  Return the number of bytes copied,
   including the terminating null byte.  If YYRESULT is null, do not
   copy anything; just return the number of bytes that would be
   copied.  As a special case, return 0 if an ordinary "syntax error"
   message will do.  Return YYSIZE_MAXIMUM if overflow occurs during
   size calculation.  */
static YYSIZE_T
yysyntax_error (char *yyresult, int yystate, int yychar)
{
  int yyn = yypact[yystate];

  if (! (YYPACT_NINF < yyn && yyn <= YYLAST))
    return 0;
  else
    {
      int yytype = YYTRANSLATE (yychar);
      YYSIZE_T yysize0 = yytnamerr (0, yytname[yytype]);
      YYSIZE_T yysize = yysize0;
      YYSIZE_T yysize1;
      int yysize_overflow = 0;
      enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
      char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
      int yyx;

# if 0
      /* This is so xgettext sees the translatable formats that are
	 constructed on the fly.  */
      YY_("syntax error, unexpected %s");
      YY_("syntax error, unexpected %s, expecting %s");
      YY_("syntax error, unexpected %s, expecting %s or %s");
      YY_("syntax error, unexpected %s, expecting %s or %s or %s");
      YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s");
# endif
      char *yyfmt;
      char const *yyf;
      static char const yyunexpected[] = "syntax error, unexpected %s";
      static char const yyexpecting[] = ", expecting %s";
      static char const yyor[] = " or %s";
      char yyformat[sizeof yyunexpected
		    + sizeof yyexpecting - 1
		    + ((YYERROR_VERBOSE_ARGS_MAXIMUM - 2)
		       * (sizeof yyor - 1))];
      char const *yyprefix = yyexpecting;

      /* Start YYX at -YYN if negative to avoid negative indexes in
	 YYCHECK.  */
      int yyxbegin = yyn < 0 ? -yyn : 0;

      /* Stay within bounds of both yycheck and yytname.  */
      int yychecklim = YYLAST - yyn + 1;
      int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
      int yycount = 1;

      yyarg[0] = yytname[yytype];
      yyfmt = yystpcpy (yyformat, yyunexpected);

      for (yyx = yyxbegin; yyx < yyxend; ++yyx)
	if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR)
	  {
	    if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
	      {
		yycount = 1;
		yysize = yysize0;
		yyformat[sizeof yyunexpected - 1] = '\0';
		break;
	      }
	    yyarg[yycount++] = yytname[yyx];
	    yysize1 = yysize + yytnamerr (0, yytname[yyx]);
	    yysize_overflow |= (yysize1 < yysize);
	    yysize = yysize1;
	    yyfmt = yystpcpy (yyfmt, yyprefix);
	    yyprefix = yyor;
	  }

      yyf = YY_(yyformat);
      yysize1 = yysize + yystrlen (yyf);
      yysize_overflow |= (yysize1 < yysize);
      yysize = yysize1;

      if (yysize_overflow)
	return YYSIZE_MAXIMUM;

      if (yyresult)
	{
	  /* Avoid sprintf, as that infringes on the user's name space.
	     Don't have undefined behavior even if the translation
	     produced a string with the wrong number of "%s"s.  */
	  char *yyp = yyresult;
	  int yyi = 0;
	  while ((*yyp = *yyf) != '\0')
	    {
	      if (*yyp == '%' && yyf[1] == 's' && yyi < yycount)
		{
		  yyp += yytnamerr (yyp, yyarg[yyi++]);
		  yyf += 2;
		}
	      else
		{
		  yyp++;
		  yyf++;
		}
	    }
	}
      return yysize;
    }
}
#endif /* YYERROR_VERBOSE */


/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

/*ARGSUSED*/
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
#else
static void
yydestruct (yymsg, yytype, yyvaluep)
    const char *yymsg;
    int yytype;
    YYSTYPE *yyvaluep;
#endif
{
  YYUSE (yyvaluep);

  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  switch (yytype)
    {

      default:
	break;
    }
}


/* Prevent warnings from -Wmissing-prototypes.  */

#ifdef YYPARSE_PARAM
#if defined __STDC__ || defined __cplusplus
int yyparse (void *YYPARSE_PARAM);
#else
int yyparse ();
#endif
#else /* ! YYPARSE_PARAM */
#if defined __STDC__ || defined __cplusplus
int yyparse (void);
#else
int yyparse ();
#endif
#endif /* ! YYPARSE_PARAM */



/* The look-ahead symbol.  */
int yychar;

/* The semantic value of the look-ahead symbol.  */
YYSTYPE yylval;

/* Number of syntax errors so far.  */
int yynerrs;



/*----------.
| yyparse.  |
`----------*/

#ifdef YYPARSE_PARAM
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
int
yyparse (void *YYPARSE_PARAM)
#else
int
yyparse (YYPARSE_PARAM)
    void *YYPARSE_PARAM;
#endif
#else /* ! YYPARSE_PARAM */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
int
yyparse (void)
#else
int
yyparse ()

#endif
#endif
{
  
  int yystate;
  int yyn;
  int yyresult;
  /* Number of tokens to shift before error messages enabled.  */
  int yyerrstatus;
  /* Look-ahead token as an internal (translated) token number.  */
  int yytoken = 0;
#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYSIZE_T yymsg_alloc = sizeof yymsgbuf;
#endif

  /* Three stacks and their tools:
     `yyss': related to states,
     `yyvs': related to semantic values,
     `yyls': related to locations.

     Refer to the stacks thru separate pointers, to allow yyoverflow
     to reallocate them elsewhere.  */

  /* The state stack.  */
  yytype_int16 yyssa[YYINITDEPTH];
  yytype_int16 *yyss = yyssa;
  yytype_int16 *yyssp;

  /* The semantic value stack.  */
  YYSTYPE yyvsa[YYINITDEPTH];
  YYSTYPE *yyvs = yyvsa;
  YYSTYPE *yyvsp;



#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  YYSIZE_T yystacksize = YYINITDEPTH;

  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;


  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY;		/* Cause a token to be read.  */

  /* Initialize stack pointers.
     Waste one element of value and location stack
     so that they stay on the same level as the state stack.
     The wasted elements are never initialized.  */

  yyssp = yyss;
  yyvsp = yyvs;

  goto yysetstate;

/*------------------------------------------------------------.
| yynewstate -- Push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
 yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;

 yysetstate:
  *yyssp = yystate;

  if (yyss + yystacksize - 1 <= yyssp)
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYSIZE_T yysize = yyssp - yyss + 1;

#ifdef yyoverflow
      {
	/* Give user a chance to reallocate the stack.  Use copies of
	   these so that the &'s don't force the real ones into
	   memory.  */
	YYSTYPE *yyvs1 = yyvs;
	yytype_int16 *yyss1 = yyss;


	/* Each stack pointer address is followed by the size of the
	   data in use in that stack, in bytes.  This used to be a
	   conditional around just the two extra args, but that might
	   be undefined if yyoverflow is a macro.  */
	yyoverflow (YY_("memory exhausted"),
		    &yyss1, yysize * sizeof (*yyssp),
		    &yyvs1, yysize * sizeof (*yyvsp),

		    &yystacksize);

	yyss = yyss1;
	yyvs = yyvs1;
      }
#else /* no yyoverflow */
# ifndef YYSTACK_RELOCATE
      goto yyexhaustedlab;
# else
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
	goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
	yystacksize = YYMAXDEPTH;

      {
	yytype_int16 *yyss1 = yyss;
	union yyalloc *yyptr =
	  (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
	if (! yyptr)
	  goto yyexhaustedlab;
	YYSTACK_RELOCATE (yyss);
	YYSTACK_RELOCATE (yyvs);

#  undef YYSTACK_RELOCATE
	if (yyss1 != yyssa)
	  YYSTACK_FREE (yyss1);
      }
# endif
#endif /* no yyoverflow */

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;


      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
		  (unsigned long int) yystacksize));

      if (yyss + yystacksize - 1 <= yyssp)
	YYABORT;
    }

  YYDPRINTF ((stderr, "Entering state %d\n", yystate));

  goto yybackup;

/*-----------.
| yybackup.  |
`-----------*/
yybackup:

  /* Do appropriate processing given the current state.  Read a
     look-ahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to look-ahead token.  */
  yyn = yypact[yystate];
  if (yyn == YYPACT_NINF)
    goto yydefault;

  /* Not known => get a look-ahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid look-ahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = YYLEX;
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yyn == 0 || yyn == YYTABLE_NINF)
	goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  if (yyn == YYFINAL)
    YYACCEPT;

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the look-ahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);

  /* Discard the shifted token unless it is eof.  */
  if (yychar != YYEOF)
    yychar = YYEMPTY;

  yystate = yyn;
  *++yyvsp = yylval;

  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- Do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     `$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
      
/* Line 1267 of yacc.c.  */
#line 1866 "sintactico_sin_semantica.tab.c"
      default: break;
    }
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;


  /* Now `shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTOKENS] + *yyssp;
  if (0 <= yystate && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTOKENS];

  goto yynewstate;


/*------------------------------------.
| yyerrlab -- here on detecting error |
`------------------------------------*/
yyerrlab:
  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
      {
	YYSIZE_T yysize = yysyntax_error (0, yystate, yychar);
	if (yymsg_alloc < yysize && yymsg_alloc < YYSTACK_ALLOC_MAXIMUM)
	  {
	    YYSIZE_T yyalloc = 2 * yysize;
	    if (! (yysize <= yyalloc && yyalloc <= YYSTACK_ALLOC_MAXIMUM))
	      yyalloc = YYSTACK_ALLOC_MAXIMUM;
	    if (yymsg != yymsgbuf)
	      YYSTACK_FREE (yymsg);
	    yymsg = (char *) YYSTACK_ALLOC (yyalloc);
	    if (yymsg)
	      yymsg_alloc = yyalloc;
	    else
	      {
		yymsg = yymsgbuf;
		yymsg_alloc = sizeof yymsgbuf;
	      }
	  }

	if (0 < yysize && yysize <= yymsg_alloc)
	  {
	    (void) yysyntax_error (yymsg, yystate, yychar);
	    yyerror (yymsg);
	  }
	else
	  {
	    yyerror (YY_("syntax error"));
	    if (yysize != 0)
	      goto yyexhaustedlab;
	  }
      }
#endif
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse look-ahead token after an
	 error, discard it.  */

      if (yychar <= YYEOF)
	{
	  /* Return failure if at end of input.  */
	  if (yychar == YYEOF)
	    YYABORT;
	}
      else
	{
	  yydestruct ("Error: discarding",
		      yytoken, &yylval);
	  yychar = YYEMPTY;
	}
    }

  /* Else will try to reuse look-ahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:

  /* Pacify compilers like GCC when the user code never invokes
     YYERROR and the label yyerrorlab therefore never appears in user
     code.  */
  if (/*CONSTCOND*/ 0)
     goto yyerrorlab;

  /* Do not reclaim the symbols of the rule which action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;	/* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (yyn != YYPACT_NINF)
	{
	  yyn += YYTERROR;
	  if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
	    {
	      yyn = yytable[yyn];
	      if (0 < yyn)
		break;
	    }
	}

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
	YYABORT;


      yydestruct ("Error: popping",
		  yystos[yystate], yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  if (yyn == YYFINAL)
    YYACCEPT;

  *++yyvsp = yylval;


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;

/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;

#ifndef yyoverflow
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif

yyreturn:
  if (yychar != YYEOF && yychar != YYEMPTY)
     yydestruct ("Cleanup: discarding lookahead",
		 yytoken, &yylval);
  /* Do not reclaim the symbols of the rule which action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
		  yystos[*yyssp], yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  /* Make sure YYID is used.  */
  return YYID (yyresult);
}


#line 455 "sintactico_sin_semantica.y"


int main(int argc, char** argv) {
 
    printf(" Compilando...\n\n");
	fflush(stdout);
	
    if (argc>1) yyin=fopen(argv[1],"r");
	yyparse();


}

yyerror(s)
char *s;
{
	fflush(stdout);
	printf("\nError sintáctico en línea %i:%s\n", numlin, s);
}


