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
	{ambito++; lib_regs();lib_rregs();}
	funcion programa
	|
	;

def_global: 
	GLOBAL tipos mas_variables SEMICOLON def_global
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
	COLON	mas_variables
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