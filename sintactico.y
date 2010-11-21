/*
 *	-------------------------------------------
 *	DESARROLLADO POR:
 *		Pablo Ojeda Vasco
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

%union { char *ristra; int enteroentero; }

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

%right '='
%right '<' '>' 
%left '+' 
%left '-' 
%left '/' 
%left '*'
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
	GLOBAL tipos mas_variables ';' def_global
	| GLOBAL CONST TIPO_INT IDENT '=' INT ';' def_global
	| GLOBAL CONST TIPO_FLOAT IDENT '=' FLOAT ';' def_global
	| GLOBAL CONST TIPO_CHAR IDENT '=' CHAR ';' def_global
	|
	;

mas_variables: 
	IDENT variables2
	| IDENT '=' constante variables2
	| IDENT '[' INT ']' variables2;
	;

variables2: 
	','	mas_variables
	|
	;

funcion: 
	tipos IDENT '(' argumentos ')''{' instrucciones '}'
	| TIPO_INT MAIN '('')''{' instrucciones '}'
	;
	
argumentos:
	tipos IDENT restarg
	|
	;

restarg: 
	',' argumentos
	|
	;
	
instrucciones:
	declaraciones instrucciones
	| asignacion ';' instrucciones
	| si instrucciones
	| mientras instrucciones
	| para instrucciones
	| elegir instrucciones
	| RETURN exp ';'
	| PRINTF '(' exp ')' ';' instrucciones
	|
	;
	
tipos:
	TIPO_INT
	| TIPO_FLOAT
	| TIPO_CHAR
	;
		
declaraciones: 
	tipos variables ';'
	| CONST TIPO_INT IDENT '=' INT ';'
	;

variables:
	IDENT variables3
	| IDENT '=' exp variables3
	| IDENT '[' INT ']' variables3
	;

variables3: 
	',' variables
	|
	;
	
constante:
	INT
	| FLOAT
	| CHAR
	;
	
asignacion:
	IDENT '=' exp
	| vector '=' exp
	;

vector:
	IDENT '[' int_vec ']'
	;

int_vec:
	INT
	| IDENT
	;

exp:
	constante
	| IDENT
	| vector
	| exp '+' exp
	| exp '-' exp
	| exp '*' exp
	| exp '/' exp
	| '(' exp ')'
	| exp '>' exp
	| exp '<' exp
	| exp '=' '=' exp
	| llamada_funcion
	;

si:
	IF '(' exp ')' '{' instrucciones '}' sino
	;

sino:
	ELSE '{' instrucciones '}'
	|
	;

mientras:
	WHILE '(' exp ')' '{' cuerpo_bucle '}'
	;
	
cuerpo_bucle:
	instrucciones
	| BREAK ';' instrucciones
	;

para:
	FOR '(' asignacion ';' exp ';' asignacion ')' '{' cuerpo_bucle '}'
	;

elegir:
	SWITCH '(' IDENT ')' '{' cuerpo_elegir '}'
	;

cuerpo_elegir:
	CASE INT ':' instrucciones caso cuerpo_elegir
	| DEFAULT ':' instrucciones caso
	;
	
caso:
	BREAK ';' instrucciones
	|
	;
	
llamada_funcion:
	IDENT '(' parametros ')'
	| IDENT '(' ')'
	;

parametros:
	exp mas_parametros
	;

mas_parametros: 
	',' parametros
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

	p = inicializa(p);
	
	if (argc>1) 
		yyin=fopen(argv[1],"r");

	yyparse();
//	imprimeTS(p);
	//destruye(p);
}





