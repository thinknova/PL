/* ======================================== */
/* -------  ANALIZADOR SINTÁCTICO  -------- */
/* -------  =====================  -------- */                      
/* ------  * Roberto Marco Sánchez  ------- */
/* ------  * Pablo E. Ojeda Vasco   ------- */
/* ======================================== */

%{
	#include <stdio.h>
	#include <stdlib.h>
	
	extern FILE *yyin; 	/* declarado en lexico */
	extern int numlin; 	/* lexico le da valores */
	int yydebug=1; 		/* modo debug si -t */

    /******* TODAVÍA NO HACE FALTA, LO USAREMOS EN EL SEMÁNTICO **********
	char numero[] = "NUMERO";
    int eb = 0;
    int ec = 0;
    int etiqueta;
	int Es_Funcion=0;
	int Es_Funcion_break=0;
	int val_switch;
	int etiq_switch;
    int reserva_dim=0;
	char tipo[100]; 

    int contador_parametros = 1;

	// Si el flagSTAT esta a 0, es que podemos poner el STAT 
	//   Si el flagCODE esta a 1 entonces se pone el CODE
	int flagSTAT = 0;
	int flagCODE = 1; 	// Si esta a 1 es que ya tiene el CODE Puesto
	int flagVector = 0; // Indica que se ha realizado un a[1] => y no se debe considerar como puntero.
	int esPrintf; 		// Indica si estamos haciendo un printf en C. =0, no es printf | =1, es printf | =2, es printf y tiene 2 parámetros
	char printf1param[50]; // Primer parámetro del printf
	int printf2param; 	// Segundo parámetro del printf
    int parte_derecha = 0;
	//int registro_almacenado = 0;

    int flagRETURN = 0;
    int flag_V = 0;*/
%}
// Como es una pila de unión, estos son los posibles valores que aceptará
/************* PARA CUANDO USEMOS EL SEMÁNTICO *******************
%union {
  	int valor_entero;
  	double valor_double;
  	char * identificador;
  	char * ristra;
  	char* ttipo;
  	char caracter;
  	struct tipoval {
  	double valor;
  	char *tipo;
}tdato;


struct valor_expresion {
     struct nodo_tabla_simbolos *puntero_variable; 
     int valor_entero;
     char *ristra;
     double valor_double;
     char * identificador;
     char* tipo;
     char caracter;
 
     int pos_parametros;
}valor_exp;

//declaracion campos
struct dc 
  {
     char *tipo;
     char *identificador;
  }declaracion_campos;
}
***********************************/

/************* ESTO ERA DEL CHINO, ESTÁ ABAJO LO QUE VAMOS A USAR, LO DEJO ASÍ PARA Q SIRVA EN EL SEMÁNTICO YA, DE TODAS FORMAS MIRAR *********************
%token VOID FLOAT CONSTANT <ristra>STRING <ristra>STRING_C <identificador>IDENTIFICATOR COMMENT <caracter>CARACTER
%token LCORCH RCORCH LPARENT RPARENT LKEY RKEY POINT INC DEC ANDOP MULTOP ADDOP MINUSOP
%token VIRGUOP NOTOP DIVOP MODOP LDESP RDESP LOWOP GREATOP LOWEQOP GREATEQOP EQUOP
%token NOTEQOP ELEVADOOP OROP AND OR TWOPOINT SEMICOLON ASIGOP PRODASIGOP DIVASIGOP
%token MODASIGOP SUMASIGOP RESASIGOP COLON
%token BREAK CASE CHAR CONST DEFAULT DO DOUBLE ELSE FOR GOTO IF INT RETURN STRUCT SWITCH
%token TYPEDEF UNION WHILE ESPACIO <valor_double>NUMERO

%type <ttipo> tipo
%type <valor_exp> identificador
%type <valor_double> corchetes


%type <valor_exp> expresion_primaria
%type <valor_exp> expresion_asignable
%type <valor_exp> expresion_unaria
%type <valor_exp> expresion_cast
%type <valor_exp> expresion_multiplicativa
%type <valor_exp> expresion_aditiva
%type <valor_exp> expresion_shift
%type <valor_exp> expresion_relacional
%type <valor_exp> expresion_igualdad
%type <valor_exp> expresion_and
%type <valor_exp> expresion_exclusiva_or
%type <valor_exp> expresion_inclusiva_or
%type <valor_exp> expresion_logica_and
%type <valor_exp> expresion_logica_or
%type <valor_exp> expresion_asignacion
%type <valor_exp> expresion
%type <valor_exp> expresion_condicional
%type <valor_exp> declaracion_variable_simple_vector
%type <valor_exp> posible_expresion
%type <valor_exp> operador_asignacion

%type <valor_entero> posible_matriz
/*%type <valor_exp> expresion_asignable
%type <valor_exp> expresion_unaria

%type <valor_exp> expresion_cast{$$.tipo = $1; $$.identificador = $2;}
%type <valor_exp> expresion_multiplicativa
%type <valor_exp> expresion_aditiva
%type <valor_exp> expresion_shift
%type <valor_exp> expresion_relacional
%type <valor_exp> expresion_igualdad
%type <valor_exp> expresion_and
%type <valor_exp> expresion_exclusiva_or
%type <valor_exp> expresion_inclusiva_or
%type <valor_exp> expresion_logica_andespecificacion_struct_o_union
%type <valor_exp> expresion_logica_or
%type <valor_exp> expresion_condicional
%type <valor_exp> expresion_asignacion*/
//%type <valor_exp> expresion_condicional
********************************************/


%token VOID FLOAT CONSTANT STRING STRING_C IDENT COMMENT CARACTER
%token LCORCH RCORCH LPARENT RPARENT LKEY RKEY POINT INC DEC ANDOP MULTOP ADDOP MINUSOP
%token VIRGUOP NOTOP DIVOP MODOP LDESP RDESP LOWOP GREATOP LOWEQOP GREATEQOP EQUOP
%token NOTEQOP ELEVADOOP OROP AND OR TWOPOINT SEMICOLON ASIGOP PROD_ASIG_OP DIV_ASIG_OP
%token MOD_ASIG_OP SUM_ASIG_OP RES_ASI_GOP COLON
%token BREAK CASE CHAR CONST DEFAULT DO DOUBLE ELSE FOR GOTO IF INT RETURN STRUCT SWITCH
%token TYPEDEF UNION WHILE ESPACIO NUMERO


%start programa
%%


tipo
	: VOID
	| FLOAT
	| CHAR
	| DOUBLE
	| INT
	//| IDENT  //Mirar en el ejemplo a ver como se declaran los tipos identificadores
	;


declaraciones_variables_struct
	: declaracion_variables_struct
	| declaraciones_variables_struct declaracion_variables_struct
	;

identificadores_struct
	: identificador
	| identificador corchetes 
	| MULTOP identificador 
	| identificador mas_identificadores_struct COLON identificador
	| identificador mas_identificadores_struct COLON identificador corchetes
	| identificador mas_identificadores_struct COLON MULTOP identificador
	| 
	;

mas_identificadores_struct
	: mas_identificadores_struct COLON identificador 
	| mas_identificadores_struct COLON identificador corchetes 
	| mas_identificadores_struct COLON MULTOP identificador
	|
	;

especificacion_struct_o_union
	: struct_o_union identificador 
	| struct_o_union LKEY declaraciones_variables_struct RKEY identificadores_struct SEMICOLON
	;


struct_o_union
	: STRUCT
	| UNION
	;


programa 
	:
         declaraciones
        
	;


parametro
	: declaracion_variable_simple_parametro	/*Declaracion variable simple es int a ó char s ó char *s*/
	| declaracion_variable_simple_parametro corchetes
	| struct_o_union identificador identificador
	;

paso_parametros
	: parametro
	| paso_parametros COLON parametro
	;


definicion_tipo
	: TYPEDEF declaracion_variables
	;

/*llamada_funcion //Corregir
	: identificador LPARENT expresion RPARENT SEMICOLON
	| identificador LPARENT RPARENT SEMICOLON
	;*/

declaracion_funcion
	: /*tipo identificador LPARENT RPARENT SEMICOLON*/
	tipo IDENTIFICATOR LPARENT  
		paso_parametros RPARENT LKEY posible_declaraciones_variables 
        	lista_sentencias RKEY

	| tipo IDENTIFICATOR LPARENT RPARENT LKEY posible_declaraciones_variables 
    	lista_sentencias RKEY                                   
	;

declaraciones
	: declaraciones declaracion_funcion
	| declaraciones declaracion_variables //Variables globales
	| declaraciones definicion_tipo
	| 
	;

declaraciones_variables
	: declaracion_variables declaraciones_variables
	| declaracion_variables 
	;

posible_declaraciones_variables
	: declaraciones_variables
	|	
	;

sentencia
	: sentencias_control
	| sentencias_salto
	| sentencias_etiquetas
	| sentencias_expresiones
	//| declaracion_variables
	//| llamada_funcion
	;


lista_sentencias /* Cubre la recursivida de las sentencias*/
	: sentencia
	| lista_sentencias sentencia
	;

sentencias_control
	: sentencia_while
	| sentencia_if
	| sentencia_for
	| sentencia_switch
	| sentencia_do_while
	;

sentencias_salto
	: BREAK 
	  SEMICOLON
	| GOTO identificador SEMICOLON
	| RETURN SEMICOLON
	| RETURN expresion SEMICOLON
	;

sentencias_etiquetas
	: identificador TWOPOINT sentencia
	| CASE NUMERO
	  TWOPOINT LKEY lista_sentencias RKEY 
	;


sentencias_expresiones
	: SEMICOLON
	| expresion SEMICOLON
	;
	

inicializador
	: identificador //Expresion_asignacion
	| LKEY lista_inicializador RKEY
	| LKEY lista_inicializador COLON RKEY
	;

lista_inicializador
	: inicializador
	| lista_inicializador COLON inicializador
	;


corchetes
	: LCORCH NUMERO RCORCH 
	| corchetes LCORCH NUMERO RCORCH 
	| LCORCH RCORCH
	| corchetes LCORCH RCORCH
	;

/*Parametros dentro de la función*/
declaracion_variable_simple_parametro
	: tipo IDENTIFICATOR 
	| tipo MULTOP IDENTIFICATOR 
	;

declaracion_variable_simple_struct
	: tipo IDENTIFICATOR
	| tipo MULTOP IDENTIFICATOR
	;

declaracion_variable_simple
	: tipo IDENTIFICATOR
	| tipo MULTOP IDENTIFICATOR 
 	;

mas_identificadores
	: mas_identificadores COLON IDENTIFICATOR
	| mas_identificadores COLON IDENTIFICATOR corchetes
	| mas_identificadores COLON MULTOP IDENTIFICATOR
	|
	;


declaracion_variable_simple_vector
	: tipo IDENTIFICATOR
	;


declaracion_struct_struct
	: struct_o_union IDENTIFICATOR IDENTIFICATOR
	;

declaracion_variables_struct
	: declaracion_variable_simple_struct SEMICOLON
	| declaracion_variable_simple_struct corchetes mas_identificadores SEMICOLON
	| declaracion_struct_struct SEMICOLON //dentro de un struct no se puede definir un struct, sino solo declarar una variable de un struct ya creado 
	;

declaracion_variables
	: declaracion_variable_simple mas_identificadores SEMICOLON
	| declaracion_variable_simple ASIGOP expresion SEMICOLON
	| declaracion_variable_simple corchetes mas_identificadores SEMICOLON
	| declaracion_variable_simple corchetes ASIGOP inicializador SEMICOLON
	| especificacion_struct_o_union
	;

/****************/
/* ---  IF  --- */
/****************/
sentencia_if
	: IF LPARENT expresion RPARENT LKEY lista_sentencias RKEY
	/*| IF LPARENT expresion
	RPARENT sentencia  
	ELSE*/
	;

/*sentencia_else
	: 
	;*/

/****************/
/* - DO WHILE - */
/****************/
/*sentencia_do_while
	: DO sentencia WHILE LPARENT expresion RPARENT SEMICOLON
	;*/

sentencia_do_while
	: DO 
	  LKEY lista_sentencias RKEY WHILE LPARENT expresion RPARENT SEMICOLON
	;

/****************/
/* -- SWITCH -- */
/****************/
/*sentencia_switch
	: SWITCH LPARENT expresion RPARENT sentencia
	;*/

sentencia_switch
	: SWITCH LPARENT expresion RPARENT LKEY muchas_sentencias_etiquetas RKEY
	;

muchas_sentencias_etiquetas
	: sentencias_etiquetas muchas_sentencias_etiquetas
	| DEFAULT TWOPOINT LKEY lista_sentencias RKEY
	|
	;

/****************/
/* -- WHILE --- */
/****************/
sentencia_while
	: WHILE LPARENT expresion RPARENT LKEY lista_sentencias RKEY
	;

posible_expresion
	: expresion
	|
	;

/****************/
/* ---- FOR --- */
/****************/
/*Nuestro for es muy permisivo. Suma i++ antes de entrar a ejecutar las instrucciones....*/
sentencia_for
	: FOR LPARENT posible_expresion SEMICOLON 
          posible_expresion SEMICOLON /*Si se puede asignar cosas por tanto hay parte derecha y izquierda*/
          posible_expresion RPARENT 
          LKEY lista_sentencias RKEY 
	; 


operador_unario
	: ANDOP
	| MULTOP
	//| ADDOP  //peta y por eso se puede hacer +-+-+-+-+-+-+-+-+
	//| MINUSOP
	| VIRGUOP
	| NOTOP
	;

expresion_cast
	: expresion_unaria
	| LPARENT tipo RPARENT expresion_cast
	;


expresion_primaria
	: identificador
	/*| FLOAT {$$.valor_double = $1; $$.tipo = numero; int registro_valor=dame_registro(); push_pila(registro_valor, -1); 
                   char linea[50];
                   sprintf(linea, "\tR%d = %f;\n",registro_valor,(float)$1);
                   gc(linea);}*/
	| NUMERO
	| STRING 
	| STRING_C
	| LPARENT expresion RPARENT
	| CARACTER 
	;


//POSTFIX EXPRESION
expresion_asignable
	: expresion_primaria
	| IDENTIFICATOR LCORCH expresion_vector RCORCH posible_matriz {// ################################################# --- MAXIMO TRUÑACO EN SEMÁNTICO}
	| expresion_asignable POINT identificador 
	;

posible_matriz
	: LCORCH expresion_vector RCORCH
	|
 	;

expresion_unaria
	: expresion_asignable
	| operador_unario IDENTIFICATOR 
	| expresion_unaria INC 
	| expresion_unaria DEC
	| INC expresion_asignable {// ################################################# --- BUEN TRUÑO}
	| DEC expresion_asignable  {// ################################################# --- BUEN TRUÑO}
	;

operador_asignacion
	: ASIGOP
	| PRODASIGOP 
        | DIVASIGOP 
        | MODASIGOP 
        | SUMASIGOP 
        | RESASIGOP 
	;

expresion_multiplicativa
	: expresion_cast
	| expresion_multiplicativa MULTOP expresion_cast 
	| expresion_multiplicativa DIVOP expresion_cast
	| expresion_multiplicativa MODOP expresion_cast
	;

expresion_aditiva
	: expresion_multiplicativa
	| expresion_aditiva ADDOP expresion_multiplicativa
	| expresion_aditiva MINUSOP expresion_multiplicativa
	;

/*CUIDADO CON LAS COMPARACIONES*/
expresion_shift
	: expresion_aditiva
 	| expresion_shift LDESP expresion_aditiva
	| expresion_shift RDESP expresion_aditiva
	;

expresion_relacional
	: expresion_shift
	| expresion_relacional LOWOP expresion_shift
	| expresion_relacional GREATOP expresion_shift
	| expresion_relacional LOWEQOP expresion_shift
	| expresion_relacional GREATEQOP expresion_shift
	;

//Para comparar tipos eston deben ser iguales
expresion_igualdad
	: expresion_relacional
	| expresion_igualdad EQUOP expresion_relacional
	| expresion_igualdad NOTEQOP expresion_relacional
	;

expresion_and
	: expresion_igualdad
	| expresion_and ANDOP expresion_igualdad
	; 

expresion_exclusiva_or
	: expresion_and
	| expresion_exclusiva_or ELEVADOOP expresion_and
	;

expresion_inclusiva_or
	: expresion_exclusiva_or
	| expresion_inclusiva_or OROP expresion_exclusiva_or
	;

expresion_logica_and
	: expresion_inclusiva_or
	| expresion_logica_and AND expresion_inclusiva_or
	;

expresion_logica_or
	: expresion_logica_and
	| expresion_logica_or OR expresion_logica_and 
	
	; 
expresion_condicional
	: expresion_logica_or
	;

expresion_asignacion
	: expresion_condicional
	| expresion_unaria operador_asignacion expresion_asignacion {// ################################################# --- BUEN TRUÑO}
	;

expresion_vector
	: expresion_asignacion
	| expresion_vector COLON expresion_asignacion
	;


expresion
	: expresion_asignacion		{// ################################################# --- BUEN TRUÑO}
	| expresion COLON expresion_asignacion
	;

identificador
	: IDENTIFICATOR{// ################################################# --- BUEN TRUÑO}
	;


%%
#include <stdio.h>
#include <stdlib.h>

extern char yytext[];
extern int numlin;


int main(int argc, char** argv) {
    inicializacion();
    inicializacion_GC();
    inicializa_pila();
    entrar_ambito();


    printf("Cniu= : Compilando...\n\n");

    if (argc>1) yyin=fopen(argv[1],"r");
	yyparse();

    //ver_valores();

}

yyerror(s)
char *s;
{
	fflush(stdout);
	printf("\nError sintáctico en línea %i:%s\n", numlin, s);
}

