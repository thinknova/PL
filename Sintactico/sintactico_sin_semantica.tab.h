/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

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




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

