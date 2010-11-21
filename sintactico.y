/*
 *	-------------------------------------------
 *	DESARROLLADO POR:
 *		Pablo Eduardo Ojeda Vasco
 *		Roberto Marco Sánchez
 *	LICENCIA: GNU General Public License
 * 	TITULO: Compilador Lex/Flex para lenguaje C
 *  -------------------------------------------
 *  Analizador Sintactico (sintactico.y)
 *
 */

/*********************************************
	Falta not !=
	Falta completar expresion: - exp, +exp
**********************************************/

%{
	#include "stdio.h"
	#include "stdlib.h"

	extern FILE *yyin; 	/* declarado en lexico */
	extern int numlin; 	/* lexico le da valores */
	int yydebug=1; 		/* modo debug si -t */

%}

%union { char *ristra; int entero; }

%token LCORCH RCORCH LPARENT RPARENT LKEY RKEY
%token TWOPOINT SEMICOLON COLON
%token ASIGOP PRODASIGOP DIVASIGOP MODASIGOP SUMASIGOP RESASIGOP INC DEC
%token ADDOP MINUSOP MULTOP DIVOP
%token ANDOP OROP ELEVADOOP VIRGUOP LDESP RDESP
%token LOWOP GREATOP LOWEQOP GREATEQOP EQUOP NOTEQOP
%token AND OR NOTOP

%token <ristra> IDENT
%token <ristra> INT 
%token <ristra> FLOAT 
%token <ristra> CHAR
%token <ristra> STRING

%token RETURN

%token <ristra> TIPO_INT 
%token <ristra> TIPO_FLOAT 
%token <ristra> TIPO_CHAR

%token CONST
%token IF ELSE FOR WHILE SWITCH CASE BREAK
%token <entero> DEFAULT
%token MAIN

%token GLOBAL

%type <ristra> constante
%type <entero> exp
%type <entero> asignacion
%type <entero> si
%type <entero> sino
%type <entero> mientras
%type <entero> para
%type <entero> elegir
%type <entero> cuerpo_elegir
%type <entero> caso
%type <ristra> variables
%type <ristra> tipos
%type <entero> funcion
%type <entero> vector
%type <entero> int_vec
%type <entero> llamada_funcion

%token PRINTF SCANF

%right ASIGOP
%right LOWOP GREATOP 
%left ADDOP 
%left MINUSOP 
%left DIVOP 
%left MULTOP
%nonassoc Unitario
%right 'e' 'E'

%%

inicio: 
	def_global programa

programa:
	funcion programa
	|
	;

def_global: 
	GLOBAL tipos mas_variables SEMICOLONLPARENT def_global
	| GLOBAL CONST TIPO_INT IDENT ASIGOP INT SEMICOLON def_global
	| GLOBAL CONST TIPO_FLOAT IDENT ASIGOP FLOAT SEMICOLON def_global
	| GLOBAL CONST TIPO_CHAR IDENT ASIGOP CHAR SEMICOLON def_global
	|
	;

mas_variables: 
	IDENT variables2
	| IDENT ASIGOP constante variables2
	| IDENT LCORCH INT RCORCH variables2;
	;

variables2: 
	COLON mas_variables
	|
	;

funcion: 
	tipos IDENT LPARENT argumentos RPARENT LKEY instrucciones RKEY
	| TIPO_INT MAIN LPARENT RPARENT LKEY instrucciones RKEY
	;
	
argumentos:
	tipos IDENT restarg
	|
	;

restarg: 
	COLON argumentos
	|
	;
	
instrucciones:
	declaraciones instrucciones
	| asignacion SEMICOLON instrucciones
	| si instrucciones
	| mientras instrucciones
	| para instrucciones
	| elegir instrucciones
	| RETURN exp SEMICOLON
	| PRINTF LPARENT exp RPARENT SEMICOLON instrucciones
	|
	;
	
tipos:
	TIPO_INT
	| TIPO_FLOAT
	| TIPO_CHAR
	;
		
declaraciones: 
	tipos variables SEMICOLON
	| CONST TIPO_INT IDENT ASIGOP INT SEMICOLON
	|
	;

variables:
	IDENT variables3
	| IDENT ASIGOP exp variables3
	| IDENT LCORCH INT RCORCH variables3
	;

variables3: 
	COLON variables
	|
	;
	
constante:
	INT
	| FLOAT
	| CHAR
	;
	
asignacion:
	IDENT ASIGOP exp
	| vector ASIGOP exp
	;

vector:
	IDENT LCORCH int_vec RCORCH
	;

int_vec:
	INT
	| IDENT
	;

exp:
	constante
	| IDENT
	| vector
	| exp ADDOP exp
	| exp MINUSOP exp
	| exp MULTOP exp
	| exp DIVOP exp
	| LPARENT exp RPARENT
	| exp GREATOP exp
	| exp LOWOP exp
	| exp EQUOP exp
	| llamada_funcion
	;

si:
	IF LPARENT exp RPARENT LKEY instrucciones RKEY sino
	;

sino:
	ELSE LKEY instrucciones RKEY
	|
	;

mientras:
	WHILE LPARENT exp RPARENT LKEY cuerpo_bucle RKEY
	;
	
cuerpo_bucle:
	instrucciones
	| BREAK SEMICOLON instrucciones
	;

para:
	FOR LPARENT asignacion SEMICOLON exp SEMICOLON asignacion RPARENT LKEY cuerpo_bucle RKEY
	;

elegir:
	SWITCH LPARENT IDENT RPARENT LKEY cuerpo_elegir RKEY
	;

cuerpo_elegir:
	CASE INT TWOPOINT instrucciones caso cuerpo_elegir
	| DEFAULT TWOPOINT instrucciones caso
	;
	
caso:
	BREAK SEMICOLON instrucciones
	|
	;
	
llamada_funcion:
	IDENT LPARENT parametros RPARENT
	| IDENT LPARENT RPARENT
	;

parametros:
	exp mas_parametros
	;

mas_parametros: 
	COLON parametros
	|
	;

%%

int yyerror(char* mens) {
	printf("Error en linea %i: %s \n",numlin,mens);
	exit(0);
	return 0;
}

int main(int argc, char** argv) {
	//printf("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
	printf("PRUEBA\n");

	
	if (argc>1) 
		yyin=fopen(argv[1],"r");

	yyparse();

}





