/*
 *	-------------------------------------------
 *	DESARROLLADO POR:
 *		Pablo Eduardo Ojeda Vasco
 *		Roberto Marco Sánchez
 *	LICENCIA: GNU General Public License
 * 	TITULO: Compilador Lex/Flex para lenguaje C
 *  -------------------------------------------
 *  Analizador Sintactico (sintactico.y)
 * 		Nota: 	Falta not != y completar expresion: - exp, +exp
 *
 */

%{
	#include "stdio.h"
	#include "tabla.h	"
	#include "stdlib.h"

	extern FILE *yyin; 	/* declarado en lexico */
	extern int numlin; 	/* lexico le da valores */
	int yydebug=1; 		/* modo debug si -t */
	
	PLista p;					/* Tabla de símbolos */
	char* tipo;					/* Contiene "entero","real",...." */
	char* tipo2;
	char* tipovec;				/* Contiene el tipo del vector */
	char* tipodec;				/* Contiene el tipo de la declaracion */
	char* tipopar;
	char *tipofun;				/* Almacena el tipo de una función*/
	int ambito = 0;				/* Para el ambito */
	int label = 2;				/* Para las etiquetas */
	int eb = 0;					/* Etiqueta del break (sdb) */
	int ec = 0;					/* Etiqueta del continue (continuar) */
	int reg[8] = {0,0,0,0,0,0,0,0}; /* Vector para comprobar los registros enteros libres */
	int rreg[4] = {0,0,0,0}; 	/* Vector para comprobar los registros flotantes libres */
	int vid;					/* Almacena el valor del identificador */
	int rid;					/* Registro del identificador */
	int estat = 0x11ff4;  		/* Memoria estática */
	int tamtipo;				/* Almacena el tamaño del tipo */
	int narg = 0;				/* Nº de argumentos de una función */
	int narg2 = 0;				/* Variable que lleva la cuenta del nº de argumentos en la invocación a una función */
	char *idfun;				/* Almacena el identificador de una funcion */
	int nretornar;          	/* Cuenta los retornar*/
	
	int nprincipal=0;			/* Para controlar que sólo haya un principal */

	int par;
	int loc;
	int loc2;
	FILE *f;
	int guardado;			/* Preserva la salida estándar*/

%}

%union { char *ristra; int entero; }

%token LCORCH RCORCH LPARENT RPARENT LKEY RKEY
%token TWOPOINT SEMICOLON COLON
%token NOTEQOP

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

%right EQUOP
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
	{printf("#include \"Q.h\"\nBEGIN\nSTAT(0)\n\tSTR(0x11ffc,\"%cd\\n\");\n\tSTR(0x11ff8,\"%cf\\n\");\n\tSTR(0x11ff4,\"%cc\\n\");\n",37,37,37);}
	def_global {printf("CODE(0)\n");}
	programa {printf("L 0:\n\tR6 = R7;\n\tGT(-1);\n\tR7 = R7 - 8;\n\tP(R7+4) = R6;\n\tP(R7) = 1;\n\tGT(%d);\nL 1:\n\tR0 = 0;\n\tGT(-2);\nEND\n", direccion(p,"main",devambito(p,"main")));
	if (nprincipal!=1) yyerror("El programa debe contener una función principal");}

programa:
	{ambito++; lib_regs(); lib_rregs();}
	funcion programa
	|
	;

def_global: 
	GLOBAL tipos {tamtipo = bytes($2); tipodec = $2;} mas_variables SEMICOLON def_global
	| GLOBAL CONST TIPO_INT IDENT 
	  {if (busca(p,$4)) yyerror("Identificador ya declarado");} 
	  ASIGOP INT SEMICOLON 
	  { int dir = alin(4); ts(p, $4,"estatico", 0, "entero", 4, dir); printf("\tDAT(0x%x, I, %s);\n", dir, $7);}
	  def_global 
	| GLOBAL CONST TIPO_FLOAT IDENT 
	  {if (busca(p,$4)) yyerror("Identificador ya declarado");} 
	  ASIGOP FLOAT SEMICOLON 
	  { int dir = alin(4); ts(p, $4,"estatico", 0, "real", 4, dir); printf("\tDAT(0x%x, I, %s);\n", dir, $7);}
	  def_global
	| GLOBAL CONST TIPO_CHAR IDENT 
	  {if (busca(p,$4)) yyerror("Identificador ya declarado");} 
	  ASIGOP CHAR SEMICOLON 
	  { int dir = alin(4); ts(p, $4,"estatico", 0, "caracter", 4, dir); printf("\tDAT(0x%x, I, %s);\n", dir, $7);}
	  def_global
	|
	;

mas_variables: 
	IDENT 	{
				if (busca2(p,$1,0) == 0) {
					int dir = alin(tamtipo); 
					ts(p, $1,"estatico", 0, tipodec, tamtipo, dir); 
					printf("\tMEM(0x%x, %d);\n",dir,tamtipo);
				}
				else yyerror("Identificador ya declarado");
			}
	variables2	
	| IDENT {if (busca2(p,$1,ambito)) yyerror("Identificador ya declarado");}
	  ASIGOP constante {
				if (strcmp(tipo,tipodec)) yyerror("Tipo incorrecto en la asignación de la declaración");
				int dir = alinloc(tamtipo);
				loc = dir;
				ts(p, $1,"variable", ambito, tipodec, tamtipo, loc);
				loc2 += tamtipo;
				printf("\tR7 = R7 - %d;\n",tamtipo);			 
				if (!strcmp(tipodec,"entero"))  {printf("\tI(R6-%d) = R%d;\n", direccion(p,$1,ambito), $4);  lib_reg($4); }
				if (!strcmp(tipodec,"real"))    {printf("\tF(R6-%d) = RR%d;\n", direccion(p,$1,ambito), $4); lib_rreg($4);}
				if (!strcmp(tipodec,"caracter")){printf("\tU(R6-%d) = R%d;\n", direccion(p,$1,ambito), $4);  lib_reg($4); } 
			} 
	  variables2
	| IDENT {if (busca2(p,$1,ambito)) yyerror("Identificador vector ya declarado");} 
	  LCORCH INT RCORCH {
				int total = (atoi($4) * 4); int dir = alin(total); ts(p, $1,"vector", 0, tipodec, total, dir); 
				printf("\tFIL(0x%x, %d, 0);\n", dir, total);}
	  variables2;
	;

variables2: 
	COLON mas_variables
	|
	;

funcion: 
	tipos IDENT {if (busca(p,$2) != NULL) yyerror("Nombre de función en uso"); par = 8; loc = 0; loc2 = 4;}
	  LPARENT argumentos RPARENT LKEY {tipofun = $1; int etiq = ne(); ts(p, $2, "Funcion", ambito, $1, narg, etiq); printf("L %d:\tR6 = R7;\n", etiq);}
	  instrucciones {if (!(nretornar> 0)) yyerror("La función debe retornar un valor");}
	  RKEY
	| TIPO_INT MAIN {nprincipal++; loc = 0; loc2 = 4;}
	  LPARENT RPARENT LKEY {
				tipofun = $1; int etiq = ne(); 
	    		ts(p, "principal", "Funcion", ambito, $1, 0, etiq); printf("L %d:\tR6 = R7;\n", etiq);}
	   instrucciones {
				if (!(nretornar> 0)) yyerror("La función debe retornar un valor");} 
	   RKEY
	;
	
argumentos:
	tipos IDENT {
				if (busca2(p,$2,0)) yyerror("El identificador del argumento está declarado como variable global"); 
				narg++; tamtipo = bytes($1); int dir = alinpar(tamtipo);
				ts(p, $2, "parametro", ambito, $1, tamtipo, dir); par+=tamtipo;}
	restarg
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
	| RETURN {nretornar++; tipo2=tipofun;}
	  exp SEMICOLON { 
			if (strcmp(tipo,tipo2)) yyerror("Tipo de retorno incorrecto");
			if ($3!=0) { printf("\tR0 = R%d;\n", $3);lib_reg($3); }
		  	printf("\tR7 = R6;\n\tR6 = P(R7+4);\n\tR5 = P(R7);\n\tGT(R5);\n");}
	| PRINTF LPARENT exp RPARENT SEMICOLON { 
			int x = ne();
			if (strcmp("entero",tipo)==0)
				printf("\tR2 = R%d;\n\tR1 = 0x11ffc;\n\tR0 = %d;\n\tGT(putf_);\nL %d:\n",$3, x, x);
			else 
			   	if (strcmp("real",tipo)==0)
			    	printf("\tRR2 = RR%d;\n\tR1 = 0x11ff8;\n\tR0 = %d;\n\tGT(putff_);\nL %d:\n",$3, x, x);
				else
				   	printf("\tR2 = R%d;\n\tR1 = 0x11ff4;\n\tR0 = %d;\n\tGT(putf_);\nL %d:\n",$3, x, x);}
	  instrucciones
	|
	;
	
tipos:
	TIPO_INT
	| TIPO_FLOAT
	| TIPO_CHAR
	;
		
declaraciones: 
	tipos {tamtipo = bytes($1); tipodec = $1;}
	variables SEMICOLON
	| CONST TIPO_INT IDENT {if (busca(p,$3)) yyerror("Identificador ya declarado");}
	  ASIGOP INT SEMICOLON
	  {int dir = alinloc(4); loc = dir; ts(p, $3,"variable", ambito, "entero", 4, loc); loc2+=4;}
	;

variables:
	IDENT {
		if (busca2(p,$1,ambito)== 0) {
			int dir = alinloc(tamtipo);
			loc = dir; 
			ts(p, $1,"variable", ambito, tipodec, tamtipo, loc);
			loc2 += tamtipo; 
			printf("\tR7 = R7 - %d;\n",tamtipo);}
		else 
			yyerror("Identificador ya declarado");}
	  variables3
	| IDENT {if (busca2(p,$1,ambito)) yyerror("Identificador ya declarado");}
	  ASIGOP exp {
				if (strcmp(tipo,tipodec)) yyerror("Tipo incorrecto en la asignación de la declaración");
			 	int dir = alinloc(tamtipo);
			 	loc = dir;
			 	ts(p, $1,"variable", ambito, tipodec, tamtipo, loc);
			 	loc2 += tamtipo;
			 	printf("\tR7 = R7 - %d;\n",tamtipo);			 
			 	if (!strcmp(tipodec,"entero"))  {printf("\tI(R6-%d) = R%d;\n", direccion(p,$1,ambito), $4);  lib_reg($4); }
			 	if (!strcmp(tipodec,"real"))    {printf("\tF(R6-%d) = RR%d;\n", direccion(p,$1,ambito), $4); lib_rreg($4);}
			 	if (!strcmp(tipodec,"caracter")){printf("\tU(R6-%d) = R%d;\n", direccion(p,$1,ambito), $4);  lib_reg($4); }}
	  variables3
	| IDENT {if (busca2(p,$1,ambito)) yyerror("Identificador vector ya declarado");}  
	  LCORCH INT RCORCH {
				int total = (atoi($4) * tamtipo);
	   			int dir = alinloc(tamtipo);
	   			loc = dir;
	   			ts(p, $1,"vector", ambito, tipodec, total, loc);
	   			loc2 += total;
	   			printf("\tR7 = R7 - %d;\n",total);} 
	  variables3
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
	IDENT ASIGOP { int x = direccion(p,$1,ambito); if (!x) yyerror("Identificador no declarado");}  
	  exp 
		{
			if(strcmp(tipovar2(p,$1, ambito), tipo)) yyerror("Tipo incorrecto en la asignación");
			if (!strcmp("parametro",(char *) categoria(p,$1,ambito))) {
				if (!strcmp(tipo,"entero"))  {printf("\tI(R6+%d) = R%d;\n", direccion(p,$1,ambito), $4);  lib_reg($4); }
				if (!strcmp(tipo,"real"))    {printf("\tF(R6+%d) = RR%d;\n", direccion(p,$1,ambito), $4); lib_rreg($4);}
				if (!strcmp(tipo,"caracter")){printf("\tU(R6+%d) = R%d;\n", direccion(p,$1,ambito), $4);  lib_reg($4); } 
			}
			if (!strcmp("variable",(char *) categoria(p,$1,ambito))){
				if (!strcmp(tipo,"entero"))  {printf("\tI(R6-%d) = R%d;\n", direccion(p,$1,ambito), $4);  lib_reg($4); }
				if (!strcmp(tipo,"real"))    {printf("\tF(R6-%d) = RR%d;\n", direccion(p,$1,ambito), $4); lib_rreg($4);}
				if (!strcmp(tipo,"caracter")){printf("\tU(R6-%d) = R%d;\n", direccion(p,$1,ambito), $4);  lib_reg($4); } 
		 	}
			if (!strcmp("estatico",(char *) categoria(p,$1,ambito))){
				if (!strcmp(tipo,"entero"))  {printf("\tI(0x%x) = R%d;\n", direccion(p,$1,ambito), $4);  lib_reg($4); }
			 	if (!strcmp(tipo,"real"))    {printf("\tF(0x%x) = RR%d;\n", direccion(p,$1,ambito), $4); lib_rreg($4);}
			 	if (!strcmp(tipo,"caracter")){printf("\tU(0x%x) = R%d;\n", direccion(p,$1,ambito), $4);  lib_reg($4); }
			}
		}
	| vector ASIGOP {tipovec = tipo;}
	  exp 
		{ 
			if(strcmp(tipovec, tipo)) yyerror("Tipo incorrecto en la asignación");
			if (!strcmp(tipo,"entero"))  {printf("\tI(R%d) = R%d;\n", $1, $4);  lib_reg($4); }
			if (!strcmp(tipo,"real"))    {printf("\tF(R%d) = RR%d;\n", $1, $4); lib_rreg($4);}
			if (!strcmp(tipo,"caracter")){printf("\tU(R%d) = R%d;\n", $1, $4);  lib_reg($4); }
		}
	;

vector:
	IDENT {	int x = direccion(p,$1,ambito); if (!x) yyerror("Identificador no declarado");
			tipo = tipovar2(p,$1,ambito);} 
	LCORCH int_vec RCORCH
		{$$=$4; printf("\tR%d = R%d * %d;\n\tR%d = R%d + 0x%x;\n\tR%d = R6 - R%d;\n",$4,$4,tipovar(p,$1,ambito),$4,$4, direccion(p,$1,ambito),$4,$4);}; 
	;

int_vec:
	INT {$$=asig_reg(); printf("\tR%d = %s;\n",$$,$1);}
	| IDENT 
		{
			if(strcmp("entero",tipovar2(p,$1,ambito))) yyerror("Argumento del vector debe ser tipo entero");
			$$=asig_reg(); int x = direccion(p,$1,ambito); 
			if (x) printf("\tR%d = R6 - 0x%x;\n\tR%d = I(R%d);\n",$$,x,$$, $$); else yyerror("Argumento del vector no declarado");
		}
	;

exp:
	constante
		{
			recuperatipo($1); 
			if (!strcmp(tipo,"entero"))  {$$=asig_reg(); printf("\tR%d = %s;\n", $$, $1); }
			if (!strcmp(tipo,"real"))    {$$=asig_rreg(); printf("\tRR%d = %s;\n", $$, $1);}
			if (!strcmp(tipo,"caracter")){$$=asig_reg(); printf("\tR%d = %s;\n", $$, $1); }
		}
	| IDENT 	 
		{ 
			tipo = tipovar2(p,$1,ambito); if (!tipo) yyerror("Identificador no declarado"); 
			if (!strcmp("parametro",(char *) categoria(p,$1,ambito))) {
				if (!strcmp(tipo,"entero"))  {$$=asig_reg();printf("\tR%d = I(R6+%d);\n", $$, direccion(p,$1,ambito));}
				if (!strcmp(tipo,"real"))    {$$=asig_rreg();printf("\tRR%d = F(R6+%d);\n",$$, direccion(p,$1,ambito));}
				if (!strcmp(tipo,"caracter")){$$=asig_reg();printf("\tR%d = U(R6+%d);\n", $$, direccion(p,$1,ambito)); } 
			}
			if (!strcmp("variable",(char *) categoria(p,$1,ambito))){
				if (!strcmp(tipo,"entero"))  {$$=asig_reg();printf("\tR%d = I(R6-%d);\n", $$, direccion(p,$1,ambito));}
				if (!strcmp(tipo,"real"))    {$$=asig_rreg();printf("\tRR%d = F(R6-%d);\n",$$, direccion(p,$1,ambito));}
				if (!strcmp(tipo,"caracter")){$$=asig_reg();printf("\tR%d = U(R6-%d);\n", $$, direccion(p,$1,ambito)); } 
			}
			if (!strcmp("estatico",(char *) categoria(p,$1,ambito))){
				if (!strcmp(tipo,"entero"))  {$$=asig_reg();printf("\tR%d = I(0x%x);\n", $$, direccion(p,$1,ambito)); }
				if (!strcmp(tipo,"real"))    {$$=asig_rreg();printf("\tRR%d = F(0x%x);\n", $$, direccion(p,$1,ambito));}
				if (!strcmp(tipo,"caracter")){$$=asig_reg();printf("\tR%d = U(0x%x);\n", $$, direccion(p,$1,ambito)); }
			}
		}
	| vector 	{printf("\tR%d = I(R%d);\n", $1, $1);}
	| exp ADDOP {tipo2 = tipo}
	  exp 
		{
			if (strcmp(tipo2,tipo)) yyerror("Tipos incorrectos en la expresión"); $$=$1; 
			if (!strcmp(tipo,"entero"))  {printf("\tR%d = R%d + R%d;\n",$1,$1,$4); lib_reg($4); }
			if (!strcmp(tipo,"real"))    {printf("\tRR%d = RR%d + RR%d;\n",$1,$1,$4); lib_rreg($4);}
			if (!strcmp(tipo,"caracter")){printf("\tR%d = R%d + R%d;\n",$1,$1,$4); lib_reg($4); }
		}
	| exp MINUSOP{tipo2 = tipo}
	  exp 	
		{
			if (strcmp(tipo2,tipo)) yyerror("Tipos incorrectos en la expresión"); $$=$1;
			if (!strcmp(tipo,"entero"))  {printf("\tR%d = R%d - R%d;\n",$1,$1,$4); lib_reg($4); }
			if (!strcmp(tipo,"real"))    {printf("\tRR%d = RR%d - RR%d;\n",$1,$1,$4); lib_rreg($4);}
			if (!strcmp(tipo,"caracter")){printf("\tR%d = R%d - R%d;\n",$1,$1,$4); lib_reg($4);}
		}
	| exp MULTOP{tipo2 = tipo}
	  exp 
		{
			if (strcmp(tipo2,tipo)) yyerror("Tipos incorrectos en la expresión"); $$=$1;			 
			if (!strcmp(tipo,"entero"))  {printf("\tR%d = R%d * R%d;\n",$1,$1,$4); lib_reg($4); }
			if (!strcmp(tipo,"real"))    {printf("\tRR%d = RR%d * RR%d;\n",$1,$1,$4); lib_rreg($4);}
			if (!strcmp(tipo,"caracter")){printf("\tR%d = R%d * R%d;\n",$1,$1,$4); lib_reg($4); }
		}
	| exp DIVOP {tipo2 = tipo} 
	  exp 
		{
			if (strcmp(tipo2,tipo)) yyerror("Tipos incorrectos en la expresión"); $$=$1;
			if (!strcmp(tipo,"entero"))  {printf("\tR%d = R%d / R%d;\n",$1,$1,$4); lib_reg($4); }
			if (!strcmp(tipo,"real"))    {printf("\tRR%d = RR%d / RR%d;\n",$1,$1,$4); lib_rreg($4);}
			if (!strcmp(tipo,"caracter")){printf("\tR%d = R%d / R%d;\n",$1,$1,$4); lib_reg($4); }
		}
	| LPARENT exp RPARENT 	{$$=$2;}
	| exp GREATOP {tipo2 = tipo}
	  exp 
		{
			if (strcmp(tipo2,tipo)) yyerror("Tipos incorrectos en la expresión");
			if (!strcmp(tipo,"entero"))  {$$=asig_reg();printf("\tR%d = R%d > R%d;\n",$$,$1,$4); lib_reg($1); lib_reg($4); }
			if (!strcmp(tipo,"real"))    {$$=asig_rreg();printf("\tRR%d = RR%d > RR%d;\n",$$,$1,$4); lib_rreg($1);lib_rreg($4);}
			if (!strcmp(tipo,"caracter")){$$=asig_reg();printf("\tR%d = R%d > R%d;\n",$$,$1,$4); lib_reg($1); lib_reg($4); }
		}
	| exp LOWOP {tipo2 = tipo}
	  exp 
		{
			if (strcmp(tipo2,tipo)) yyerror("Tipos incorrectos en la expresión");
			if (!strcmp(tipo,"entero"))  {$$=asig_reg(); printf("\tR%d = R%d < R%d;\n",$$,$1,$4); lib_reg($1); lib_reg($4); }
			if (!strcmp(tipo,"real"))    {$$=asig_rreg(); printf("\tRR%d = RR%d < RR%d;\n",$$,$1,$4); lib_rreg($1);lib_rreg($4);}
			if (!strcmp(tipo,"caracter")){$$=asig_reg(); printf("\tR%d = R%d < R%d;\n",$$,$1,$4); lib_reg($1); lib_reg($4); }
		}
	| exp EQUOP {tipo2 = tipo}
	  exp 
		{
			if (strcmp(tipo2,tipo)) yyerror("Tipos incorrectos en la expresión");
			if (!strcmp(tipo,"entero"))  {$$=asig_reg();printf("\tR%d = R%d == R%d;\n",$$,$1,$5); lib_reg($1); lib_reg($5); }
			if (!strcmp(tipo,"real"))    {$$=asig_reg();printf("\tRR%d = RR%d == RR%d;\n",$$,$1,$5); lib_rreg($1);lib_rreg($5);}
			if (!strcmp(tipo,"caracter")){$$=asig_reg();printf("\tR%d = R%d == R%d;\n",$$,$1,$5); lib_reg($1); lib_reg($5); }
		}
	| llamada_funcion {$$=0;} 
	;

si:
	IF LPARENT exp RPARENT 			{$$=eb; eb=ne(); printf("\tIF(!R%d) GT(%d);\n",$3,eb); lib_reg($3);}
	LKEY instrucciones RKEY sino 	{ eb = $<entero1>5;}
	;

sino:
	ELSE 					{$$=ec; ec=ne(); printf("\tGT(%d);\nL %d:\n",ec,eb);} 
	LKEY instrucciones RKEY { printf("L %d:\n",ec); ec = $<entero1>2;}
	| 						{printf("L %d:\n",eb);}
	;

mientras:
	WHILE 					{$$=ec; ec=ne(); printf("L %d:\n",ec);}
	LPARENT exp RPARENT 	{$$=eb; eb=ne(); printf("\tIF(!R%d) GT(%d);\n",$<entero1>4,eb); lib_reg($<entero1>4);}
	LKEY cuerpo_bucle RKEY 	{ printf("\tGT(%d);\nL %d:\n",ec,eb); ec=$<entero1>2; eb=$<entero1>6;}
	;

cuerpo_bucle:
	instrucciones
	| BREAK SEMICOLON instrucciones {if(eb) printf("\tGT(%d);\n",eb); else printf("err(21)\n");}
	;

para:
	FOR LPARENT asignacion SEMICOLON 	{$$=ec; ec=ne(); printf("L %d:\n",ec);}
	exp SEMICOLON 						{$$=eb; eb=ne(); printf("\tIF(!R%d) GT(%d);\n",$<entero1>6,eb); lib_reg($<entero1>6); 
											guardado = dup(1);close(1); f = fopen("volcado.txt","w+");}
	asignacion 							{close(1); dup(guardado); close(guardado); close(f);}
	RPARENT LKEY cuerpo_bucle RKEY		{volcado(); printf("\tGT(%d);\nL %d:\n",ec,eb); ec=$<entero1>5; eb=$<entero1>8;}
	;

elegir:
	SWITCH LPARENT IDENT RPARENT
			{
				eb=ne(); rid= asig_reg();  int x = direccion(p,$3,ambito); 
				if (!x) yyerror("Identificador no declarado");
				if (strcmp("entero",tipovar2(p,$3,ambito))) yyerror("El identificador debe ser tipo entero");
				if (!strcmp("parametro",(char *) categoria(p,$3,ambito))) printf("\tR%d = I(R6+%d);\n",rid,x);
				if (!strcmp("variable",(char *) categoria(p,$3,ambito)))  printf("\tR%d = I(R6-%d);\n",rid,x);
				if (!strcmp("estatico",(char *) categoria(p,$3,ambito)))  printf("\tR%d = I(0x%x);\n",rid,x);}
	LKEY cuerpo_elegir RKEY
	;

cuerpo_elegir:
	CASE INT TWOPOINT  {ec=ne(); int r = asig_reg(); printf("\tR%d = R%d == %s;\n\tIF(!R%d) GT(%d);\n",r,rid,$2,r,ec);}
	instrucciones caso {printf("L %d:\n",ec);}
	cuerpo_elegir
	| DEFAULT TWOPOINT instrucciones caso
	;

caso:
	BREAK SEMICOLON {if(eb) printf("\tGT(%d);\n",eb); else printf("err(21)\n");} 
	instrucciones
	|
	;

llamada_funcion:
	IDENT LPARENT 
		{ 
			if (busca(p,$1)==NULL) yyerror("Funcion no declarada");
			idfun = $1; narg2 = 0;
			printf("\tR7 = R7 - %d;\n",tam_par(p, $1));
		}
	parametros RPARENT 		
		{
			tipo = tipovar2(p,$1,-1); 
			if (narg2 != nargfun(p,idfun)) yyerror("Nº de parametros incorrectos en la invocación de la función");
			$$=ne(); printf("\tP(R7+4) = R6;\n\tP(R7) = %d;\n\tGT(%d);\nL %d:\n\tR7 = R7 + %d;\n",$$,etiqueta(p,$1),$$,tam_par(p,$1));
		}
	| IDENT LPARENT RPARENT	
		{ 
			idfun = $1; 
		    if (busca(p,$1)==NULL) yyerror("Funcion no declarada");
		    if (0 != nargfun(p,idfun)) yyerror("Nº de parametros incorrectos en la invocación de la función");
		    $$=ne(); printf("\tP(R7+4) = R6;\n\tP(R7) = %d;\n\tGT(%d);\nL %d:\n\tR7 = R7 + %d;\n",$$,etiqueta(p,$1),$$,tam_par(p,$1));
	 	}
	;

parametros: {tipopar = tipoargfun(p,idfun,narg2); if (tipopar == NULL) yyerror("Nº de parametros incorrectos en la invocación de la función");} 
	exp 
		{ 	
			if (strcmp(tipo,tipopar))    yyerror("Tipo incorrecto en el parámetro");
       		if (!strcmp(tipo,"entero"))  printf("\tI(R7 + %d) = R%d;\n", dirargfun(p,idfun,narg2), $2 ); lib_reg($2);
			if (!strcmp(tipo,"real"))    printf("\tF(R7 + %d) = RR%d;\n", dirargfun(p,idfun,narg2), $2 ); lib_rreg($2);
			if (!strcmp(tipo,"caracter"))printf("\tU(R7 + %d) = R%d;\n", dirargfun(p,idfun,narg2), $2 ); lib_reg($2);
			narg2++;
     	}
 	mas_parametros
	;

mas_parametros: 
	COLON parametros
	|
	;

%%
// Sirve para alinear las posiciones de memoria
int alin(int b){
	int x = estat % 4;
	if (x && (b == 4)){
		estat = estat - x;
	}

	estat = estat - b;
	return estat;
}

// Sirve para alinear las variables locales de una función
int alinloc(int tam){
	int x = loc2 % tam;
	if (x){
		x = 4 - x;
		loc2 = loc2 + x;
	}
	return loc2;
}

// Sirve para alinear los parámetros de una función
int alinpar(int tam){
	int x = par % tam;
	if (x){
		x = 4 - x;
		par = par + x;
	}
	return par;
}

// Devuelve el tamaño del tipo
int bytes(char *s){
	switch(s[0]){
		case 'e': return 4;
		case 'r': return 4;
		case 'c': return 1;
	}
}

// Funcion para asignar un nuevo registro (libre)
int asig_reg() {
	int i;
	for (i=0; i<6; i++)
		if (reg[i] == 0) {
			reg[i] = 1;
			return i;
		}
	return -1;
}

// Funcion para asignar un nuevo registro flotante (libre)
int asig_rreg(){
	int i;
	for (i=0; i<4; i++)
		if (rreg[i] == 0) {
			rreg[i] = 1;
			return i;
		}
	return -1;
}

// Funcion para liberar los registros
int lib_regs() {
	int i;
	for (i=0; i<8; i++)
		reg[i] = 0;
	return 0;
}

// Funcion para liberar los registros
int lib_rregs() {
	int i;
	for (i=0; i<4; i++)
		rreg[i] = 0;
	return 0;
}

// Funcion para liberar el registro especificado
int lib_reg(int i) {
	reg[i] = 0;
	return 0;
}

// Funcion para liberar el registro especificado
int lib_rreg(int i) {
	rreg[i] = 0;
	return 0;
}

// Funcion para asignar una nueva etiqueta
int ne() {
	return label++;
}

// Chequeo semántico para los reales
int esreal(char *f){
	int npuntos = 0 , nexp = 0, nop = 0, i;
	for (i=0; i < strlen(f); i++) {
		if (f[i]<48 || f[i]>57){
			if(f[i] == '.') npuntos++;
			else if(f[i] == 'e' || f[i]== 'E') nexp++;
			     else if(f[i] == '+' || f[i]== '-') nop++;
				  else return 0;
		}
	}
	
	if (npuntos!=1 || nexp>1 || nop>1)
		return 0;

	return 1;	
}

// Chequeo semántico para los enteros
int esentero(char *f){
	int i;
	for (i=0; i < strlen(f); i++) {
		if (f[i]<48 || f[i]>57){
			return 0;
		}
	}

	return 1;	
}


// Chequeo semántico para los caracteres
int escaracter(char *f){
	if (strlen(f)>3)
		return 0;
	if(f[0]!= 39 && f[2]!= 39)
		return 0;

	if (f[1]>64 || f[1]>91) // A-Z
		return 1;
	
	if (f[1]>96 || f[1]<123) // a-z
		return 1;

	return 0;	
}

// Comprueba que el tipo es correcto en las declaraciones
int compruebatipo(char *p, char *s){
	switch(p[0]){
		case 'e': return esentero(s);
		case 'r': return esreal(s);
		case 'c': return escaracter(s);
	}
	return 0;
}

int recuperatipo(char *s){
	if (esentero(s))
		tipo = "entero";
	if (esreal(s))
		tipo = "real";
	if (escaracter(s))
		tipo = "caracter";
	return 1;
}

int volcado(){
	f = fopen("volcado.txt","r");
	if (f!= NULL){
		char cadena[100]; 
		while (fgets(cadena, 100, f) != NULL){
			printf("%s",cadena);
		}
		fclose(f);
		return 1;
	}
	else yyerror("Error al abrir el fichero");
}

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