%{
#include "stdio.h"
extern FILE *yyin; /* declarado en lexico */
extern int numlin; /* lexico le da valores */
int yydebug=1; /* modo debug si -t */
%}

%token principal identificador retornar


%token entero real caracter logico octal hexa constante


%token si sino para mientras hacer elegir caso defecto sdb continuar

%token no op_ge op_le op_eq op_neq op_bits op_sri op_sle

%token y o resto verdadero falso

%token leer escribir

%token comentarios separador

%token tipoentero tiporeal tipocaracter tipologico

%token asignacion especial

%right '='
%right '<' '>' op_le op_ge op_eq op_neq op_sri op_sle
%right op_bits
%nonassoc y o
%left resto
%left '+' 
%left '-' 
%left '/' 
%left '*'
%nonassoc Unitario
%left not
%right 'e' 'E'

%%

programa : function programa | ;
function : tipos identificador '(' argumentos ')' '{' cuerpo '}' ;
argumentos : tipos identificador restarg | ;
restarg : ',' argumentos | ;
tipos : tipoentero | tiporeal | tipocaracter | tipologico ;


cuerpo: declaraciones cuerpo | instrucciones cuerpo | ;

declaraciones : tipos idvar ';'
		| tipos vectores ';' 
		| constante tipos identificador '=' exp ';' 
		;


idvar : identificador variables | identificador '=' valor variables ;
variables : ',' idvar |',' vectores | ;

vectores : vector variables ;
vector :  identificador '[' intvec ']' ;
intvec : entero | identificador ;


valor: entero | caracter | verdadero | falso | real | identificador | vector ;

asign : identificador '=' exp | vector '=' exp ;
instrucciones :  asign ';'  
		| if 
		| while 
		| for 
		| switch 
		| sdb ';' 
		| continuar ';' 
		| retornar exp ';'
		| llamadafunc ';'
		;

if : si '(' exp ')' '{' cuerpo '}' ifnot ;
ifnot : | sino '{' cuerpo '}' ;

while : mientras '(' exp ')' '{' cuerpo '}' ; 

for : para '(' asign ';' exp ';' asign ')' '{' cuerpo '}' ; 

switch: elegir '(' identificador ')' '{' cuerpo_switch '}' ;
cuerpo_switch: casos | defecto ':' cuerpo | ;
casos : caso entero ':' cuerpo cuerpo_switch ;


llamadafunc : identificador '(' parametros ')' | identificador '(' ')' ;
parametros : exp otro ;
otro : ',' parametros | ;

exp :   valor
	| llamadafunc
	|'(' exp ')' 
	| no exp  %prec not
	| exp '+' exp
	| exp '-' exp
	| exp '*' exp
	| exp '/' exp
	| '+' exp %prec Unitario
	| '-' exp %prec Unitario
	| exp '>' exp
	| exp '<' exp
	| exp op_bits exp
	| exp op_le exp
	| exp op_ge exp 
	| exp op_eq exp 
	| exp op_neq exp 
	| exp op_sri exp 
	| exp op_sle exp 
	| exp resto exp
	| exp y exp 
	| exp o exp 
	;
	
%%

int yyerror(char* mens) {
	printf("Error en linea %i: %s \n",numlin,mens);
	return 0;
}

int main(int argc, char** argv) {
	if (argc>1) 
		yyin=fopen(argv[1],"r");
	yyparse();
}





