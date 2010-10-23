%{
	#include <stdio.h>
	#include <stdlib.h>
	extern FILE *yyin; /* declarado en lexico */
	extern int numlin; /* lexico le da valores */
	int yydebug=1; /* modo debug si -t */

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

	/* Si el flagSTAT esta a 0, es que podemos poner el STAT 
	   Si el flagCODE esta a 1 entonces se pone el CODE */
	int flagSTAT = 0;
	int flagCODE = 1; // Si esta a 1 es que ya tiene el CODE Puesto
	int flagVector = 0; // Indica que se ha realizado un a[1] => y no se debe considerar como puntero.
	int esPrintf; // Indica si estamos haciendo un printf en C. =0, no es printf | =1, es printf | =2, es printf y tiene 2 parámetros
	char printf1param[50]; // Primer parámetro del printf
	int printf2param; // Segundo parámetro del printf
        int parte_derecha = 0;
	//int registro_almacenado = 0;

        int flagRETURN = 0;
        int flag_V = 0;
%}

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


  struct dc //declaracion campos
  {
     char *tipo;
     char *identificador;
  }declaracion_campos;
}

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

/*
%token IDENTIFIER CONSTANT STRING_LITERAL SIZEOF
%token PTR_OP INC_OP DEC_OP LEFT_OP RIGHT_OP LE_OP GE_OP EQ_OP NE_OP
%token AND_OP OR_OP MUL_ASSIGN DIV_ASSIGN MOD_ASSIGN ADD_ASSIGN
%token SUB_ASSIGN LEFT_ASSIGN RIGHT_ASSIGN AND_ASSIGN
%token XOR_ASSIGN OR_ASSIGN TYPE_NAME

%token TYPEDEF EXTERN STATIC AUTO REGISTER
%token CHAR SHORT INT LONG SIGNED UNSIGNED FLOAT DOUBLE CONST VOLATILE VOID
%token STRUCT UNION ENUM ELLIPSIS

%token CASE DEFAULT IF ELSE SWITCH WHILE DO FOR GOTO CONTINUE BREAK RETURN
*/
%start programa
%%


tipo
	: VOID {$$ = "void";}
	| FLOAT {$$ = "float";}
	| CHAR {$$ = "char";}
	| DOUBLE {$$ = "double";}
	| INT {$$ = "int";}
	//| IDENTIFICATOR  //Mirar en el ejemplo a ver como se declaran los tipos identificadores
	;

/*tipo_lista
	: declaracion_variables //type_specifier
	| tipo_lista declaracion_variables
	;
declaracion_struct
	: tipo_lista declaracion_lista_struct
	;

declaracion_lista_struct
	: declaracion_struct
	| declaracion_lista_struct declaracion_struct
	;*/

declaraciones_variables_struct
	: declaracion_variables_struct
	| declaraciones_variables_struct declaracion_variables_struct
	;

identificadores_struct
	: identificador {push_id($1.identificador, "variable" , 1);}
	| identificador corchetes {push_id($1.identificador, "variable", (int)$2);}
	| MULTOP identificador {push_id($2.identificador, "puntero", 1);}
	| identificador mas_identificadores_struct COLON identificador {push_id($1.identificador, "variable" , 1); push_id($4.identificador, "variable", 1);}
	| identificador mas_identificadores_struct COLON identificador corchetes {push_id($1.identificador, "variable" , 1); push_id($4.identificador, "variable" , (int)$5);}
	| identificador mas_identificadores_struct COLON MULTOP identificador {push_id($1.identificador, "variable", 1); push_id($5.identificador, "puntero" , 1);}
	| 
	;

mas_identificadores_struct
	: mas_identificadores_struct COLON identificador {push_id($3.identificador, "variable", 1);}
	| mas_identificadores_struct COLON identificador corchetes {push_id($3.identificador, "variable", (int)$4);}
	| mas_identificadores_struct COLON MULTOP identificador {push_id($4.identificador, "puntero", 1);}
	|
	;

especificacion_struct_o_union
	: struct_o_union identificador {insertar_tipo($2.identificador,ambito_actual(),NULL); nuevo_identificador_struct($2.identificador);} LKEY declaraciones_variables_struct RKEY identificadores_struct SEMICOLON {insertar_variable_pila($2.identificador);} 
	| struct_o_union LKEY declaraciones_variables_struct RKEY identificadores_struct SEMICOLON
	;


struct_o_union
	: STRUCT
	| UNION
	;


programa 
	:{char linea[50];
          sprintf(linea, "#include \"Q.h\"\nBEGIN\n");
          gc(linea); sprintf(linea,"");
	}
         declaraciones
         {char linea[50];
          sprintf(linea, "\tGT(-2);\nEND\n");
          gc(linea);}
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

/*alias
	: alias COLON identificador
	| 
	; */

definicion_tipo
	: TYPEDEF declaracion_variables
	;

/*llamada_funcion //Corregir
	: identificador LPARENT expresion RPARENT SEMICOLON
	| identificador LPARENT RPARENT SEMICOLON
	;*/

declaracion_funcion
	: /*tipo identificador LPARENT RPARENT SEMICOLON*/
	tipo IDENTIFICATOR LPARENT  {  etiqueta = ne($2);
                                     /*No pueden haber variables y funciones que se llamen igual*/
				       nuevo_identificador_funcion($2);      
				       Es_Funcion_break = 1;                                                     
                                       int resultado = insertar_variable($2 , $1, etiqueta, "funcion", ambito_actual() );
                                       if(!resultado)
				       {
                                          printf("Error: La función \"%s\" ya existe en ese ambito\n" , $2);
					  exit(1);
				        }
				    } paso_parametros RPARENT LKEY {entrar_ambito();} posible_declaraciones_variables 
                                                           {
                                                               if(flagSTAT == 1)
                                                               {
                                                                  flagSTAT = 0;
								  if (flagCODE == 0)
                                                                  {
								      flagCODE = 1;
								      char linea[50];
                                                                      sprintf(linea, "CODE(%d)\n", dame_CODE());
                                                                      gc(linea);
								  }
                                                               }
                                                               char linea[50];
                                                               if((!strcmp(ultimo_identificador_funcion(), "main")))
				                                  sprintf(linea, "L %d:\n \tR7 = 0x%x;\n \tR6 = R7;\n  \tR7 = R7 - %d;\n", etiqueta,  dame_Z(), tamano_var_locales(ambito_actual())); //¿?¿?¿?¿?
                                                               else
								  sprintf(linea, "L %d:\n \tR6 = R7;\n  \tR7 = R7 - %d;\n", etiqueta, tamano_var_locales(ambito_actual())); //¿?¿?¿?¿?

                                                               gc(linea);
                                                           } lista_sentencias RKEY {
										    
       										     char linea[50];
                                                               			     if((strcmp(ultimo_identificador_funcion(), "main")))
										     {
										        int registro = dame_registro();
				                                                        sprintf(linea, "\tR7 = R6;\n \tR6 = P(R7 + 4);\n \tR%d = P(R7);\n \tGT(R%d);\n\n\n", registro, registro);
                                                                                        gc(linea);
  										     }
                                                                                        eliminar_variable_ambito(ambito_actual()) ; salir_ambito(); liberar_registros();
											liberar_registros_double();
							                            }

        | tipo IDENTIFICATOR LPARENT { etiqueta = ne($2);
                                       nuevo_identificador_funcion($2);                                                           
                                       int resultado = insertar_variable($2 , $1, etiqueta, "funcion", ambito_actual() );
                                       if(!resultado)
                                         { printf("Error: La función \"%s\" ya existe en ese ambito\n" , $2); exit(1);}} RPARENT LKEY {entrar_ambito();} posible_declaraciones_variables 
                                                           {
                                                               if(flagSTAT == 1)
                                                               {
                                                                  flagSTAT = 0;
								  if (flagCODE == 0)
                                                                  {
								      flagCODE = 1;
								      char linea[50];
                                                                      sprintf(linea, "CODE(%d)\n", dame_CODE());
                                                                      gc(linea);
								  }
                                                               }
                                                               char linea[50];
                                                               if((!strcmp(ultimo_identificador_funcion(), "main")))
				                                  sprintf(linea, "L %d:\n \tR7 = 0x%x;\n \tR6 = R7;\n  \tR7 = R7 - %d;\n",etiqueta, dame_Z(), tamano_var_locales(ambito_actual())); //¿?¿?¿?¿?
                                                               else
								  sprintf(linea, "L %d:\n \tR6 = R7;\n  \tR7 = R7 - %d;\n",etiqueta, tamano_var_locales(ambito_actual())); //¿?¿?¿?¿?

                                                               gc(linea);
                                                           } lista_sentencias RKEY {char linea[50];
                                                               			     if((strcmp(ultimo_identificador_funcion(), "main")))
										     {
										        int registro = dame_registro();
				                                                        sprintf(linea, "\tR7 = R6;\n \tR6 = P(R7 + 4);\n \tR%d = P(R7);\n \tGT(R%d);\n\n\n", registro, registro);
                                                                                        gc(linea);
  										     }eliminar_variable_ambito(ambito_actual()) ; salir_ambito(); liberar_registros();
										     liberar_registros_double();
										    }

                                    
	;

declaraciones
	: declaraciones declaracion_funcion
	| declaraciones declaracion_variables//Variables globales
	| declaraciones definicion_tipo
	| 
	;

/*declaraciones
	: declaracion_variables
	;*/
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
	//| sentencias_bloque
	| sentencias_expresiones
	//| declaracion_variables
	//| llamada_funcion
	;

/*sentencias_bloque
	: LKEY RKEY 
	| LKEY {entrar_ambito();} posible_declaraciones_variables 
                                                           {
                                                               
                                                               char linea[50];
				                               sprintf(linea, "L%d:\n \tR6 = R7;\n \tR7 = R7 - %d\n", etiqueta, tamano_var_locales(ambito_actual())); //¿?¿?¿?¿?
                                                               gc(linea);
                                                           }
          lista_sentencias RKEY {eliminar_variable_ambito(ambito_actual()) ; salir_ambito();}
	;*/

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

/*sentencias_salto
	: BREAK SEMICOLON
	| GOTO identificador SEMICOLON
	| RETURN SEMICOLON
	| RETURN expresion SEMICOLON
	;*/
sentencias_salto
	: BREAK {char linea[50]; 
			/*if(Es_Funcion_break==1){
				int registro = dame_registro();
				sprintf(linea, "\tR%d = I(R7 + 4);\n\tGT(R%d);\n" , registro,registro);
				Es_Funcion_break = 0;
			}
			else
			{*/
				sprintf(linea, "\tGT(%d);\n" , eb);
			//}
			gc(linea);}
	  SEMICOLON
	| GOTO identificador SEMICOLON
	| RETURN SEMICOLON
	| RETURN {flagRETURN = 1; parte_derecha=1;} expresion {
								int rv, rd; 
								pop_pila(&rv,&rd,"",parte_derecha); 
								char linea[50]; 
								sprintf(linea, "\t%c(R6 - %d) = %sR%d;\n" , tipo2char(tipo_identificador(ultimo_identificador_funcion()), parte_derecha), bytes(tipo_identificador(ultimo_identificador_funcion())) , tipo2Registro($3.tipo,parte_derecha),Registro2RegistroFloat(rv)); 
								gc(linea); 
								flagRETURN = 0; 
								parte_derecha=0;
					
                                                               	if((strcmp(ultimo_identificador_funcion(), "main")))
								{
								   int registro = dame_registro();
				                                   sprintf(linea, "\tR7 = R6;\n \tR6 = P(R7 + 4);\n \tR%d = P(R7);\n \tGT(R%d);\n\n\n", registro, registro);
                                                                   gc(linea);
  						                }
								//eliminar_variable_ambito(ambito_actual()) ; 
								//salir_ambito(); 
								liberar_registros();
							        liberar_registros_double();
										 
								} SEMICOLON
	;

/*sentencias_etiquetas
	: identificador TWOPOINT sentencia
	| CASE identificador TWOPOINT sentencia
	| DEFAULT TWOPOINT sentencia
	;*/

sentencias_etiquetas
	: identificador TWOPOINT sentencia
	| CASE NUMERO {char linea[50]; $<valor_entero>$ = ec; ec = ne(""); sprintf(linea, "\tIF(R%d != %d) GT(%d);\n" , val_switch, (int)$2, ec); gc(linea);}
	  TWOPOINT LKEY lista_sentencias RKEY {char linea[50]; sprintf(linea, "L %d:\n" , ec); gc(linea); ec = $<valor_entero>3;}
	/*| DEFAULT TWOPOINT LKEY lista_sentencias RKEY*/
	;


sentencias_expresiones
	: SEMICOLON{liberar_registros(); liberar_registros_double(); parte_derecha = 0; seguridad_pila();}
	| expresion SEMICOLON {liberar_registros(); liberar_registros_double(); parte_derecha = 0; seguridad_pila();}
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

/*CUIDADO 
  
  Jose fortres dijo que simplificasemos esto
*/
/*corchetes
	: LCORCH NUMERO RCORCH {$$ = $2;}
	| corchetes LCORCH NUMERO RCORCH {$$ = $3;} //Nota falta controlar mas de una dimensión CUIDADO
	| LCORCH RCORCH {$$ = -1;}
	| corchetes LCORCH RCORCH {$$ = -1;}
	;*/

corchetes
	: LCORCH NUMERO RCORCH {$$ = $2; reserva_dim = reserva_dim + (int)$2;}
	| corchetes LCORCH NUMERO RCORCH {$$ = $1; reserva_dim = reserva_dim * (int)$3} 
	| LCORCH RCORCH {$$ = -1; }
	| corchetes LCORCH RCORCH {$$ = -1;}
	;

/*Parametros dentro de la función*/
declaracion_variable_simple_parametro
	: tipo IDENTIFICATOR {int resultado = insertar_parametro_funcion(ultimo_identificador_funcion(), $1, $2, "variable", ambito_actual(), 1);
			      
                              if(resultado == 2)
			      {
                                 printf("Error: Ya existe el nombre \"%s\" como parámetro \"%s\"\n" ,  $2, ultimo_identificador_funcion());
				 exit(1);
			      }
                              if(resultado == 1)
			      {
                                printf("Error: El tipo \"%s\" no esta declarado aún\n" , $1);
				exit(1);
			     }
                               
                             }
	| tipo MULTOP IDENTIFICATOR {
                                   int resultado = insertar_parametro_funcion(ultimo_identificador_funcion(), $1, $3, "puntero", ambito_actual(), 1);
			      
                                   if(resultado == 2)
				   {
                                     printf("Error: Ya existe el nombre \"%s\" como parámetro \"%s\"\n" ,  $3, ultimo_identificador_funcion());
				     exit(1);
				   }
                                   if(resultado == 1)
				   {
                                     printf("Error: El tipo \"%s\" no esta declarado aún\n" , $1);
				     exit(1);
				   }
                                    } //Punteros
	;

declaracion_variable_simple_struct
	: tipo IDENTIFICATOR {int resultado = insertar_campo_tipo(ultimo_identificador_struct(), $1, $2, ambito_actual(), 1);
			      
                              if(resultado == 2)
			      {
                                 printf("Error: Ya existe el nombre \"%s\" dentro del struct \"%s\"\n" ,  $2, ultimo_identificador_struct());
				 exit(1);
			      }
                              if(resultado == 1)
			      {
                                printf("Error: El tipo \"%s\" no esta declarado aún\n" , $1);
				exit(1);
			      }
                             }
	| tipo MULTOP IDENTIFICATOR {insertar_campo_tipo(ultimo_identificador_struct(), $1, $3, ambito_actual(), 1);} //falta poner la categoria
	;

declaracion_variable_simple
	: tipo IDENTIFICATOR {

                              //Si es una variable global
                              if(ambito_actual() == 0)
                              {
                                 int direccion = alinear($1);
                                 int resultado = insertar_variable($2 , $1, 1, "variable", ambito_actual(), direccion);
                                 if(!resultado)
				 {
                                    printf("Error: La variable \"%s\" ya existe en ese ambito\n" , $2);
				    exit(1);
				 }
                                 else
                                 {
                                       if(flagSTAT == 0)
                                       {
                                          flagSTAT = 1;
					  flagCODE = 0;
                                          char linea[50];
                                          sprintf(linea, "STAT(%d)\n", dame_STAT());
                                          gc(linea);
                                       }
                                       char linea[50];
                                       sprintf(linea, "\tMEM(0x%x, %d);\n", direccion,bytes($1));
                                       gc(linea);
                                 }
                              }
                              else
                              {
                                 //Las variables locales o parametros no tienen direccion, se toman a partir de R6 y R7
                                 int resultado = insertar_variable($2 , $1, 1, "variable", ambito_actual(), -1);
                                 if(!resultado)
				{
                                    printf("Error: La variable \"%s\" ya existe en ese ambito\n" , $2);
				    exit(1);
				}
                              }
			      sprintf(tipo, "%s",$1) ;
                              
                             }
	| tipo MULTOP IDENTIFICATOR {
 
                                     if(ambito_actual() == 0)
                                     {

                                        int direccion = alinear("puntero");
                                        int resultado = insertar_variable($3 , $1, 1, "puntero", ambito_actual(), direccion);
                                        if(!resultado)
					{
                                           printf("Error: La variable \"%s\" ya existe en ese ambito\n" , $3);
					   exit(1);
					}
                                        else
                                        {
					   if(flagSTAT == 0)
                                       	   {
                                              flagSTAT = 1;
					      flagCODE = 0;
                                              char linea[50];
                                              sprintf(linea, "STAT(%d)\n", dame_STAT());
                                              gc(linea);
                                           }
                                           char linea[50];
                                           sprintf(linea, "\tMEM(0x%x, %d);\n",direccion,bytes($1));
                                           gc(linea);
                                        }
                                     }
                                     else
                                     {
                                        //Las variables locales o parametros no tienen direccion, se toman a partir de R6 y R7
                                        int resultado = insertar_variable($3 , $1, 1, "puntero", ambito_actual(), -1);
                                        if(!resultado)
					{
                                           printf("Error: La variable \"%s\" ya existe en ese ambito\n" , $3);
					   exit(1);
					}
                                     }
 				     sprintf(tipo, "%s",$1) ;
					
                                    } //Punteros

	;

/*mas_identificadores
	: mas_identificadores COLON IDENTIFICATOR
	| mas_identificadores COLON IDENTIFICATOR corchetes
	| mas_identificadores COLON MULTOP IDENTIFICATOR
	|
	;*/

mas_identificadores
	: mas_identificadores COLON IDENTIFICATOR {int direccion;
                                                   if(ambito_actual() == 0)
                                                      direccion = alinear(tipo);
                              			   int resultado = insertar_variable($3 , tipo, 1, "variable", ambito_actual(), direccion);
                             			   if(!resultado)
						   {
                                 			printf("Error: La variable \"%s\" ya existe en ese ambito\n" , $3);
							exit(1);
						   }
                          			   char linea[50];
                              			   if(ambito_actual() == 0)
						   {
							sprintf(linea, "\tMEM(0x%x, %d);\n",direccion,bytes(tipo));
                              			   	gc(linea);
						   } 
                                                  }
	| mas_identificadores COLON IDENTIFICATOR {int direccion;
                                                   if(ambito_actual() == 0)
                                                      direccion = alinear(tipo);
                              			   int resultado = insertar_variable($3 , tipo, 1, "variable", ambito_actual(), direccion);
                              			   if(!resultado)
						   {
                                			printf("Error: La variable \"%s\" ya existe en ese ambito\n" , $3);
							exit(1);
						   }
                             			  }
	  corchetes {int direccion;
                     if(ambito_actual() == 0)
                        direccion = alinear_vector(tipo, reserva_dim);
		     char linea[50];
		     if(ambito_actual() == 0)
		     {
			sprintf(linea, "\tMEM(0x%x, %d);\n",direccion,bytes(tipo)*reserva_dim);
                     	gc(linea);
		     }
		     reserva_dim = 0;
		    }
	| mas_identificadores COLON MULTOP IDENTIFICATOR {int direccion;
                                                          if(ambito_actual() == 0)
                                                             direccion = alinear("puntero");
                                     			  int resultado = insertar_variable($4 , tipo, 1, "puntero", ambito_actual(), direccion);
                                     			  if(!resultado)
							  {
                                       				printf("Error: La variable \"%s\" ya existe en ese ambito\n" , $4); 
								exit(1);
							  }
                                     			  char linea[50];
                                    			  if(ambito_actual() == 0)
		     					  {
                                    			  	sprintf(linea, "\tMEM(0x%x, %d);\n",direccion,bytes("puntero"));
                                     			  	gc(linea);
							  }
                                    			 } //Punteros
	|
	;

declaracion_variable_simple_vector
	: tipo IDENTIFICATOR {int direccion;
                              if(ambito_actual() == 0)
                                 direccion = alinear($1);
                              /*int resultado = insertar_variable($2 , $1, 1, "variable", ambito_actual(), direccion);
                              if(!resultado)
                                 printf("Error: La variable \"%s\" ya existe en ese ambito\n" , $2);*/

			      if(flagCODE == 1)
                              {
                                 flagSTAT = 1;
				 flagCODE = 0;
                                 char linea[50];
                                 sprintf(linea, "STAT(%d)\n", dame_STAT());
                                 gc(linea);
                              }
			      sprintf(tipo, "%s",$1) ;
				$$.identificador=$2;
                             }
	;


declaracion_struct_struct
	: struct_o_union IDENTIFICATOR IDENTIFICATOR {int resultado = insertar_campo_tipo(ultimo_identificador_struct(), $2, $3, ambito_actual(), 1);

                                                      if(resultado == 2)
						      {
                                                         printf("Error: Ya existe el nombre \"%s\" dentro del struct \"%s\"\n" ,  $3, ultimo_identificador_struct());
							 exit(1);
						      }
                                                      if(resultado == 1)
						      {
                                                         printf("Error: El tipo \"%s\" no esta declarado aún\n" , $2);
							 exit(1);
						      } 
                                                     }
	;

declaracion_variables_struct
	: declaracion_variable_simple_struct SEMICOLON
	| declaracion_variable_simple_struct corchetes mas_identificadores SEMICOLON
	| declaracion_struct_struct SEMICOLON //dentro de un struct no se puede definir un struct, sino solo declarar una variable de un struct ya creado 
	;

/*declaracion_variables
	: declaracion_variable_simple mas_identificadores SEMICOLON
	| declaracion_variable_simple ASIGOP expresion SEMICOLON
	| declaracion_variable_simple corchetes mas_identificadores SEMICOLON
	| declaracion_variable_simple corchetes ASIGOP inicializador SEMICOLON
	| especificacion_struct_o_union
	;*/

declaracion_variables
	: declaracion_variable_simple mas_identificadores SEMICOLON
	| declaracion_variable_simple ASIGOP expresion  {char linea[50];
							 int reg = dame_registro();									
                              				 sprintf(linea, "\tR%d = 0x%x;\n", reg, $<valor_entero>1);
                              				 gc(linea);
							 sprintf(linea, "\tI(R%d) = R%d;\n", reg, $<valor_entero>3);
                              				 gc(linea);
						         liberar_registros();
							 liberar_registros_double();
							}
          SEMICOLON
	| declaracion_variable_simple_vector corchetes {int direccion;
                                                        if(ambito_actual() == 0)direccion = alinear_vector(tipo, reserva_dim);
							int resultado = insertar_variable($1.identificador , tipo, reserva_dim, "puntero", ambito_actual(), direccion);
                                                        insertar_width($1.identificador, (int)$2);
                              				if(!resultado)
							{
                                 			   printf("Error: La variable \"%s\" ya existe en ese ambito\n" , $1.identificador);
							   exit(1);
							}
							if (ambito_actual()==0)
							{
							   char linea[50];
                              				   sprintf(linea, "\tMEM(0x%x, %d);\n",direccion,bytes(tipo)*reserva_dim);
                              				   gc(linea);
							}
							reserva_dim = 0;
							}
          mas_identificadores SEMICOLON {printf("La reserva es: %d\n", reserva_dim);}
	| declaracion_variable_simple_vector corchetes ASIGOP inicializador SEMICOLON
	| especificacion_struct_o_union
	;

/* IF*/

sentencia_if
	: IF LPARENT {parte_derecha = 1;} expresion {parte_derecha = 0; int rv, rd; char linea[50]; $<valor_entero>$ = eb; eb = ne(""); pop_pila(&rv, &rd,"", parte_derecha); if(rv>9) sprintf(linea, "\tIF(!RR%d) GT(%d);\n" ,rv-10 ,eb);
			    else sprintf(linea, "\tIF(!R%d) GT(%d);\n" ,rv ,eb);
                            gc(linea);}
	RPARENT LKEY lista_sentencias RKEY {char linea[50]; sprintf(linea, "L %d:\n" , eb); gc(linea); eb=$<valor_entero>5;}
	/*| IF LPARENT expresion {int rv, rd; char linea[50]; $<valor_entero>$ = eb; eb = ne(); pop_pila(&rv, &rd); sprintf(linea, "\tIF(!R%d) GT(%d)\n" ,rv ,eb); gc(linea);} 
	RPARENT sentencia  
	ELSE {char linea[50]; sprintf(linea, "L %d:\n" , eb); gc(linea); eb=$<valor_entero>4;} sentencia //CONFLICTO AVANCE/REDUCCION*/
	;

/*sentencia_else
	: 
	;*/

/*sentencia_do_while
	: DO sentencia WHILE LPARENT expresion RPARENT SEMICOLON
	;*/

sentencia_do_while
	: DO {char linea[50]; $<valor_entero>$ = ec; ec = ne(""); sprintf(linea, "L %d:\n" , ec); gc(linea);}
	  LKEY lista_sentencias RKEY
	  WHILE
	  LPARENT {parte_derecha = 1;}
	  expresion {parte_derecha = 0; int rv, rd; char linea[50]; pop_pila(&rv, &rd,"",parte_derecha); 
          if(rv>9) sprintf(linea, "\tIF(!RR%d) GT(%d);\n" ,rv-10 ,eb);
	  else sprintf(linea, "\tIF(R%d) GT(%d);\n" ,rv,ec);
          gc(linea); ec = $<valor_entero>2;}
	  RPARENT SEMICOLON
	;

/*sentencia_switch
	: SWITCH LPARENT expresion RPARENT sentencia
	;*/

sentencia_switch
	: SWITCH {$<valor_entero>$ = eb; eb = ne(""); parte_derecha = 1; /*etiq_switch = ec;*/}
	  LPARENT
	  expresion {int rv, rd; pop_pila(&rv, &rd,"",parte_derecha); val_switch = rv; parte_derecha = 0;}
	  RPARENT LKEY muchas_sentencias_etiquetas RKEY/* {char linea[50]; sprintf(linea, "L %d:\n" , etiq_switch); gc(linea);}*/ {char linea[50]; sprintf(linea, "L %d:\n" ,eb); gc(linea); eb = $<valor_entero>2;} 
	;

muchas_sentencias_etiquetas
	: sentencias_etiquetas muchas_sentencias_etiquetas
	| DEFAULT TWOPOINT LKEY lista_sentencias RKEY
	|
	;

/* WHILE*/


sentencia_while
	: WHILE {char linea[50]; $<valor_entero>$ = ec; ec = ne(""); sprintf(linea, "L %d:\n" , ec); gc(linea); parte_derecha = 1;} 
          LPARENT 
          expresion { parte_derecha = 0; int rv, rd; char linea[50]; $<valor_entero>$ = eb; eb = ne(""); pop_pila(&rv, &rd,"",parte_derecha);
          if(rv>9) sprintf(linea, "\tIF(!RR%d) GT(%d);\n" ,rv-10 ,eb);
	  else sprintf(linea, "\tIF(!R%d) GT(%d);\n" ,rv,eb);
          gc(linea);}
          RPARENT
          LKEY lista_sentencias RKEY  {char linea[50]; sprintf(linea, "\tGT(%d);\nL %d:\n" ,ec ,eb); gc(linea); ec = $<valor_entero>2; eb = $<valor_entero>5;}
	;

posible_expresion
	: expresion {$$=$1;}
	| {$$;}
	;

/*Nuestro for es muy permisivo. Suma i++ antes de entrar a ejecutar las instrucciones....*/
sentencia_for
	: FOR 
          LPARENT 
          posible_expresion {int rv, rd; char linea[50]; $<valor_entero>$ = ec; ec = ne(""); /*pop_pila(&rv, &rd,$3.tipo);*/ sprintf(linea, "L %d:\n" , ec); gc(linea);}
          SEMICOLON {liberar_registros(); liberar_registros_double(); parte_derecha = 1;} 
          posible_expresion {parte_derecha = 0;  int rv, rd; char linea[50]; $<valor_entero>$ = eb; eb = ne("");  pop_pila(&rv, &rd,"",parte_derecha);  if(rv>9) sprintf(linea, "\tIF(!RR%d) GT(%d);\n" ,rv-10 ,eb);
	  else sprintf(linea, "\tIF(!R%d) GT(%d);\n" ,rv ,eb);
          gc(linea); }	
          SEMICOLON {liberar_registros(); liberar_registros_double(); parte_derecha = 0;} /*Si se puede asignar cosas por tanto hay parte derecha y izquierda*/
          posible_expresion {parte_derecha = 0; int rv, rd; /*pop_pila(&rv, &rd,$11.tipo);*/ /*Gestion de pila*/}  
          RPARENT 
          LKEY lista_sentencias RKEY {char linea[50]; sprintf(linea, "\tGT(%d);\nL %d:\n" ,ec ,eb); gc(linea); ec = $<valor_entero>4; eb = $<valor_entero>8;} 
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
	: expresion_unaria {$$ = $1;}
	| LPARENT tipo RPARENT expresion_cast {$$;} //Falta pasar el tipo
	;

/*MIRAR ESTO*/
/*expresion_primaria
	: identificador {$$ = $1;} 
	| NUMERO { $$.identificador = "";$$.valor_double = $1; $$.tipo = numero; int registro_valor=dame_registro(); push_pila(registro_valor, -1); 
                   char linea[50];
                   sprintf(linea, "\tR%d = %d;\n",registro_valor,(int)$1);
                   gc(linea);}  //Constant
	| STRING  {$$.ristra = $1; $$.tipo = "STRING"}
	| LPARENT expresion RPARENT {$$ = $2;}  //¿Esto esta bien? 
	| CARACTER {$$.tipo = "CARACTER"; $$.caracter = $1;}
	;*/

expresion_primaria
	: identificador {$$ = $1;
			 if(esPrintf==1){
				esPrintf=3;
			 }
			}
	/*| FLOAT {$$.valor_double = $1; $$.tipo = numero; int registro_valor=dame_registro(); push_pila(registro_valor, -1); 
                   char linea[50];
                   sprintf(linea, "\tR%d = %f;\n",registro_valor,(float)$1);
                   gc(linea);}*/
	| NUMERO { $$.identificador = ""; $$.valor_double = $1; $$.tipo = numero; char linea[50];
			if(esPrintf==1){
				esPrintf=2;
				printf2param=$1;
			}
			else if($1/1.00 == (int)$1)
			{
				int registro_valor=dame_registro(); push_pila(registro_valor, registro_valor,$$.tipo,parte_derecha); 
                   		sprintf(linea, "\tR%d = %d;\n",registro_valor,(int)$1);
			}
			else
			{
				int registro_valor=dame_registro_double(); push_pila(registro_valor+10, registro_valor,$$.tipo,parte_derecha); 	  
                   		sprintf(linea, "\tRR%d = %f;\n",registro_valor,(float)$1);
			}
                   gc(linea);}  //Constant
	| STRING  {$$.ristra = $1; $$.tipo = "STRING"; if(esPrintf==1) sprintf(printf1param,"%s",$1);}
	| STRING_C {$$.ristra = $1; $$.tipo = "STRING"; if(esPrintf==1) sprintf(printf1param,"%s",$1);}
	| LPARENT expresion RPARENT {$$ = $2;} 
	| CARACTER { $$.caracter = $1; $$.tipo = "CARACTER"; int registro_valor=dame_registro(); push_pila(registro_valor, registro_valor,$$.tipo,parte_derecha); 
                   char linea[50];
                   sprintf(linea, "\tR%d = '%c';\n",registro_valor,(char)$1);
                   gc(linea);}
	;


//POSTFIX EXPRESION
expresion_asignable
	: expresion_primaria { $$ = $1;}
	| /*expresion_asignable*/IDENTIFICATOR LCORCH {flag_V = 1;} expresion_vector 
	  RCORCH posible_matriz {
                                                flag_V = 0;
						//int direccion = direccion_variable($1.identificador, ambito_actual())
                                                int caso;
						struct nodo_tabla_simbolos* puntero_variable;

						char *tipo;
			  			tipo = (char *) malloc (50*sizeof(char));
                           			sprintf(tipo, "%s" , tipo_identificador($1));

                                                if(!existe_variable($1/*.identificador*/, &puntero_variable, &caso, "puntero"))
                                                {
                                                   printf("Error: variable \"%s\" no declarada\n", $1/*.identificador*/);
						   exit(1);
                                                }
                                                else
                                                {
                                                   if(caso == 1)   //Global
                                                   {
						      if(!(strcmp(categoria_identificador($1/*.identificador*/), "puntero")))
					 	      {

							 if ($6 == 1) // Se trata de una matriz hay que hacer dos pop_pila y calcular la direccion
							 {
							     int rv, rd, rv2, rd2;
                                                             pop_pila(&rv,&rd,"",parte_derecha);
							     pop_pila(&rv2,&rd2,"",parte_derecha);
							     int tamano_tipo = identificador2size($1/*.identificador*/);
							     int direccion = direccion_variable($1, ambito_actual());

                              			             char linea[50];
							    

						            // Primero conseguimos la base del vector RX=R6-(Numero Magico)
						            // A partir de la base del vector sumamos hasta la posicion que diga "expresion" multiplicada 
						            // por el numero de bytes de cada elemento. (RX = RX + "expresion"*bytes(tipo))
							    if(!parte_derecha && !estamos_funcion_llamada() && !flagRETURN)
                                                            {
			                                       int registro_base = dame_registro();
					                       int registro_elemento = dame_registro();

                              			               sprintf(linea, "\tR%d = 0x%x;\n \tR%d = R%d*%d;\n \tR%d = R%d + R%d;\n \tR%d = R%d * %d;\n \tR%d = R%d + R%d;\n",registro_base,direccion,registro_elemento, rv2, width($1), registro_elemento, registro_elemento, rv, registro_elemento, registro_elemento,tamano_tipo, registro_base, registro_base, registro_elemento);
						               push_pila(-1, registro_base,tipo,parte_derecha);

                                                               liberar_registro(registro_elemento);
                                                            }
                                                            else
                                                            {
							       int registro_valor;
			                                       int registro_base = dame_registro();
					                       int registro_elemento = dame_registro();

							       if(!(strcmp(tipo, "float")))
								  registro_valor = dame_registro_double();
							       else
								  registro_valor = registro_elemento;
							
                              			               sprintf(linea, "\tR%d = 0x%x;\n \tR%d = R%d*%d;\n \tR%d = R%d + R%d;\n \tR%d = R%d * %d;\n \tR%d = R%d + R%d;\n \t%sR%d = %c(R%d);\n", registro_base, direccion, registro_elemento, rv2, width($1), registro_elemento, registro_elemento, rv, registro_elemento, registro_elemento,tamano_tipo, registro_base, registro_base, registro_elemento,tipo2Registro(tipo,parte_derecha), registro_valor,tipo2char(tipo,parte_derecha), registro_base);

						               push_pila(generaRegistro(registro_valor,tipo), -1,tipo,parte_derecha);

                                                               //liberar_registro(registro_elemento);
							       liberar_registro(registro_base);
							    }
 							    liberar_registro(rv);
							    liberar_registro(rv2);
							    gc(linea);
							 }
							 else
							 {
							    int rv, rd;
                                                            pop_pila(&rv,&rd,"",parte_derecha);
						            int direccion = direccion_variable($1/*.identificador*/, ambito_actual());
						            int tamano_tipo = identificador2size($1/*.identificador*/);

						            int direccion_base = direccion - num_elem_identificador($1/*.identificador*/)*tamano_tipo;
 
                              			            char linea[50];
                                                         
							    if(!parte_derecha && !estamos_funcion_llamada() && !flagRETURN)
                                                            {
			                                       int registro_valor = dame_registro();
						               int registro_elemento = dame_registro();

                              			               sprintf(linea, "\tR%d = 0x%x;\n \tR%d = R%d*%d;\n \tR%d = R%d + R%d;\n  ",registro_valor,direccion_base, registro_elemento, rv,tamano_tipo, registro_elemento, registro_valor, registro_elemento);
						               push_pila(-1, registro_elemento,tipo,parte_derecha);

                                                               liberar_registro(registro_valor);
                                                            }
                                                            else
                                                            {
							       int registro_valor;
			                                       int registro_base = dame_registro();
					                       int registro_elemento = dame_registro();

							       if(!(strcmp(tipo, "float")))
								  registro_valor = dame_registro_double();
							       else
								  registro_valor = registro_elemento;

                              			               // Primero conseguimos la base del vector RX=R6-(Numero Magico)
						               // A partir de la base del vector sumamos hasta la posicion que diga "expresion" multiplicada 
						               // por el numero de bytes de cada elemento. (RX = RX + "expresion"*bytes(tipo))
                              			               sprintf(linea, "\tR%d = 0x%x;\n \tR%d = R%d*%d;\n \tR%d = R%d + R%d;\n  \t%sR%d = %c(R%d);\n",registro_valor, direccion_base, registro_elemento, rv, tamano_tipo, registro_elemento, registro_valor, registro_elemento, tipo2Registro(tipo, parte_derecha), registro_valor,tipo2char(tipo,parte_derecha), registro_elemento);
							       push_pila(generaRegistro(registro_valor,tipo), -1,tipo,parte_derecha);

                                                               //liberar_registro(registro_elemento);
							       liberar_registro(registro_base);
                                                            }
                                                         
                        			            gc(linea);
							   }
						      }
						      else
						      {
  						 	printf("Error: La variable \"%s\" no es un vector\n",$1/*.identificador*/);
							exit(1);
						      }
                                                   }

						   if(caso == 2)   //Parametros
                            			   {

						      if(!(strcmp(categoria_identificador($1/*.identificador*/), "puntero")))
					 	      {

                                                         
							 if ($6 == 1) // Se trata de una matriz hay que hacer dos pop_pila y calcular la direccion
							 {
                                                             int rv, rd, rv2, rd2;
                                                             pop_pila(&rv,&rd,"",parte_derecha);
							     pop_pila(&rv2,&rd2,"",parte_derecha);
						             int numero_magico = tamano_parametros(ultimo_identificador_funcion())-tamano_parametro_hasta_posicion_id(ultimo_identificador_funcion(), $1);
                              			             char linea[50];
							     int tamano_tipo = identificador2size($1/*.identificador*/);

						             // Primero conseguimos la base del vector RX=R6-(Numero Magico)
						            // A partir de la base del vector sumamos hasta la posicion que diga "expresion" multiplicada 
						            // por el numero de bytes de cada elemento. (RX = RX + "expresion"*bytes(tipo))
							    if(!parte_derecha && !estamos_funcion_llamada() && !flagRETURN)
                                                            {
			                                       int registro_base = dame_registro();
					                       int registro_elemento = dame_registro();

                              			               sprintf(linea, "\tR%d = R6 + %d;\n \tR%d = R%d*%d;\n \tR%d = R%d + R%d;\n \tR%d = R%d * %d;\n \tR%d = R%d + R%d;\n",registro_base,numero_magico,registro_elemento, rv2, width_funcion($1), registro_elemento, registro_elemento, rv, registro_elemento, registro_elemento,tamano_tipo, registro_base, registro_base, registro_elemento);
						               push_pila(-1, registro_base,tipo,parte_derecha);

                                                               liberar_registro(registro_elemento);
                                                            }
                                                            else
                                                            {
							       int registro_valor = dame_registro();
			                                       int registro_base = dame_registro();
					                       int registro_elemento = dame_registro();

                              			               sprintf(linea, "\tR%d = R6 + %d;\n \tR%d = R%d*%d;\n \tR%d = R%d + R%d;\n \tR%d = R%d * %d;\n \tR%d = R%d + R%d;\n \tR%d = I(R%d);\n", registro_base, numero_magico, registro_elemento, rv2, width_funcion($1), registro_elemento, registro_elemento, rv, registro_elemento, registro_elemento,tamano_tipo, registro_base, registro_base, registro_elemento, registro_valor, registro_base);
						               push_pila(registro_valor, -1,tipo,parte_derecha);

                                                               liberar_registro(registro_elemento);
							       liberar_registro(registro_base);
							    }
 							    liberar_registro(rv);
							    liberar_registro(rv2);
							    gc(linea);
                                                         }
                                                         else
                                                         {
						            int rv, rd;
                                                            pop_pila(&rv,&rd,"",parte_derecha);

						      
						            int numero_magico = tamano_parametros(ultimo_identificador_funcion())-tamano_parametro_hasta_posicion_id(ultimo_identificador_funcion(), $1);
                              			            char linea[50];
                                                            int tamano_tipo = identificador2size_parametro($1/*.identificador*/);
						            // Primero conseguimos la base del vector RX=R6-(Numero Magico)
						            // A partir de la base del vector sumamos hasta la posicion que diga "expresion" multiplicada 
						            // por el numero de bytes de cada elemento. (RX = RX + "expresion"*bytes(tipo))
							    if(!parte_derecha && !estamos_funcion_llamada() && !flagRETURN)
                                                            {
			                                       int registro_base = dame_registro();
					                       int registro_elemento = dame_registro();

                              			               sprintf(linea, "\tR%d = I(R6 + %d);\n \tR%d = R%d*%d;\n \tR%d = R%d + R%d;\n  ",registro_base,numero_magico,registro_elemento, rv, tamano_tipo, registro_base, registro_base, registro_elemento);
						               push_pila(-1, registro_base,tipo,parte_derecha);

                                                               liberar_registro(registro_elemento);
                                                            }
                                                            else
                                                            {
							       int registro_valor;
			                                       int registro_base = dame_registro();
					                       int registro_elemento = dame_registro();

							       if(!(strcmp(tipo, "float")))
								  registro_valor = dame_registro_double();
							       else
								  registro_valor = registro_elemento;


                              			               sprintf(linea, "\tR%d = I(R6 + %d);\n \tR%d = R%d*%d;\n \tR%d = R%d + R%d;\n  \t%sR%d = %c(R%d);\n",registro_base,numero_magico,registro_elemento, rv, tamano_tipo, registro_base, registro_base, registro_elemento, tipo2Registro(tipo,parte_derecha), registro_valor, tipo2char(tipo,parte_derecha), registro_base);

						               push_pila(generaRegistro(registro_valor,tipo), -1,tipo,parte_derecha);


                                                               //liberar_registro(registro_elemento);
							       liberar_registro(registro_base);
                                                            }
            		                                    gc(linea);
                                                            liberar_registro(rv);
                                                          }

						       }
                                                       else
						       {
  						 	 printf("Error: La variable \"%s\" no es un vector\n",$1/*.identificador*/);
							 exit(1);
						       }
						      /*int direccion = direccion_variable($1.identificador, ambito_actual());
						      int tamano_tipo = identificador2size($1.identificador);

						      int direccion_base = direccion - num_elem_identificador($1.identificador)*tamano_tipo;

                        			      char linea[50];
                                                      int registro_valor = dame_registro();
						      int registro_elemento = dame_registro();

						      // Primero conseguimos la base del vector RX=R6-(Numero Magico)
						      // A partir de la base del vector sumamos hasta la posicion que diga "expresion" multiplicada 
						      // por el numero de bytes de cada elemento. RX = RX + "expresion"*bytes(tipo))
                              			      sprintf(linea, "\tR%d = 0x%x\n; \tR%d = R%d*%d;\n \tR%d = R%d + R%d;\n  \tR%d = I(R%d);\n",registro_valor, direccion_base, registro_elemento, rv, tamano_tipo, registro_elemento, registro_valor, registro_elemento, registro_valor, registro_elemento);

						      push_pila(registro_valor, registro_elemento);
                        			      gc(linea);*/
						   }

                                                   if(caso == 3)  //Locales
                                                   {

						      if(!(strcmp(categoria_identificador($1/*.identificador*/), "puntero")))
					 	      {

							 if ($6 == 1) // Se trata de una matriz hay que hacer dos pop_pila y calcular la direccion
							 {
							     int rv, rd, rv2, rd2;
                                                             pop_pila(&rv,&rd,"",parte_derecha);
							     pop_pila(&rv2,&rd2,"",parte_derecha);
						             int numero_magico_local = tamano_variable_local_hasta_posicion($1/*.identificador*/, ambito_actual());
                              			             char linea[50];
							     int tamano_tipo = identificador2size($1/*.identificador*/);

						             // Primero conseguimos la base del vector RX=R6-(Numero Magico)
						            // A partir de la base del vector sumamos hasta la posicion que diga "expresion" multiplicada 
						            // por el numero de bytes de cada elemento. (RX = RX + "expresion"*bytes(tipo))
							    if(!parte_derecha && !estamos_funcion_llamada() && !flagRETURN)
                                                            {
			                                       int registro_base = dame_registro();
					                       int registro_elemento = dame_registro();

                              			               sprintf(linea, "\tR%d = R6 - %d;\n \tR%d = R%d*%d;\n \tR%d = R%d + R%d;\n \tR%d = R%d * %d;\n \tR%d = R%d + R%d;\n",registro_base,numero_magico_local,registro_elemento, rv2, width($1), registro_elemento, registro_elemento, rv, registro_elemento, registro_elemento,tamano_tipo, registro_base, registro_base, registro_elemento);
						               push_pila(-1, registro_base,tipo,parte_derecha);

                                                               liberar_registro(registro_elemento);
                                                            }
                                                            else
                                                            {
							       int registro_valor;
			                                       int registro_base = dame_registro();
					                       int registro_elemento = dame_registro();

							       if(!(strcmp(tipo, "float")))
								  registro_valor = dame_registro_double();
							       else
								  registro_valor = registro_elemento;

                              			               sprintf(linea, "\tR%d = R6 - %d;\n \tR%d = R%d*%d;\n \tR%d = R%d + R%d;\n \tR%d = R%d * %d;\n \tR%d = R%d + R%d;\n \t%sR%d = %c(R%d);\n", registro_base, numero_magico_local, registro_elemento, rv2, width($1), registro_elemento, registro_elemento, rv, registro_elemento, registro_elemento,tamano_tipo, registro_base, registro_base, registro_elemento, tipo2Registro(tipo,parte_derecha), registro_valor,tipo2char(tipo,parte_derecha), registro_base);
						               push_pila(generaRegistro(registro_valor,tipo), -1,tipo,parte_derecha);

                                                               //liberar_registro(registro_elemento);
							       liberar_registro(registro_base);
							    }
 							    liberar_registro(rv);
							    liberar_registro(rv2);
							    gc(linea);
							 }
							 else
							 {
							    int rv, rd;
                                                            pop_pila(&rv,&rd,"",parte_derecha); 
						            int numero_magico_local = tamano_variable_local_hasta_posicion($1/*.identificador*/, ambito_actual());
                              			            char linea[50];

                                                            int tamano_tipo = identificador2size($1/*.identificador*/);

						             // Primero conseguimos la base del vector RX=R6-(Numero Magico)
						             // A partir de la base del vector sumamos hasta la posicion que diga "expresion" multiplicada 
						             // por el numero de bytes de cada elemento. (RX = RX + "expresion"*bytes(tipo))
							    if(!parte_derecha && !estamos_funcion_llamada() && !flagRETURN)
                                                            {
			                                       int registro_base = dame_registro();
					                       int registro_elemento = dame_registro();

                              			               sprintf(linea, "\tR%d = R6 - %d;\n \tR%d = R%d*%d;\n \tR%d = R%d + R%d;\n  ",registro_base,numero_magico_local,registro_elemento, rv, tamano_tipo, registro_base, registro_base, registro_elemento);
						               push_pila(-1, registro_base,tipo,parte_derecha);

                                                               liberar_registro(registro_elemento);
                                                            }
                                                            else
                                                            {

							       int registro_valor;
			                                       int registro_base = dame_registro();
					                       int registro_elemento = dame_registro();

							       if(!(strcmp(tipo, "float")))
								  registro_valor = dame_registro_double();
							       else
								  registro_valor = registro_elemento;

                              			               sprintf(linea, "\tR%d = R6 - %d;\n \tR%d = R%d*%d;\n \tR%d = R%d + R%d;\n  \t%sR%d = %c(R%d);\n",registro_base,numero_magico_local,registro_elemento, rv, tamano_tipo, registro_base, registro_base, registro_elemento, tipo2Registro(tipo, parte_derecha), registro_valor, tipo2char(tipo, parte_derecha), registro_base);

						               push_pila(generaRegistro(registro_valor,tipo), -1,tipo,parte_derecha);

                                                               //liberar_registro(registro_elemento);
							       liberar_registro(registro_base);

                                                            }
							    liberar_registro(rv);
            		                                    gc(linea);
							 }
						      }
						      else
						      {
  						 	printf("Error: La variable \"%s\" no es un vector\n",$1/*.identificador*/);
							exit(1);
						      }
                                                    }
                                                 }  
					       


                            /*Falta comprobar que el tipo de la expresion sea entero*/
			    char *tipo_; 
			    tipo_variable($1, ambito_actual(), &tipo_);
                            $$.identificador = $1;
                            $$.tipo = tipo_;	
                            if(estamos_funcion_llamada())
			       flagVector = 1;
		 } //pasamos el tipo de la variable $$.identificador = $1; $$.tipo = ;}
	//| expresion_asignable LPARENT {nuevo_identificador_funcion_llamada($1.identificador);} RPARENT {$$ = $1; liberar_funcion_llamada();}
	| IDENTIFICATOR LPARENT {
				 struct nodo_tabla_simbolos* puntero_variable;
                             	 int caso;

				 if(existe_variable($1, &puntero_variable, &caso, categoria_identificador($1)))
			 	 {
				    salvado_registros();
				    nuevo_identificador_funcion_llamada($1);
                                    char linea[50];
                                    sprintf(linea, "\tR7 = R7 - %d;\n",tamano_parametros($1)); //Tamaño total parametros
                                    gc(linea);
                                    contador_parametros = num_elem_funcion($1);

				    //$$.numero_parametros = 2; //Numero de parametros
				 }
				 else if((strcmp($1, "printf"))) // Si no es una función ya declarada, y tampoco es un printf
				 {
				    printf("Error: La funcion \"%s\" no existe\n",$1);
				    exit(1);
				 }
                                 else {esPrintf=1;} // Si el identificador es un printf lo indicamos en este flag

                                } posible_expresion RPARENT { 
						       if (ultimo_numelem_funcion() == num_elem_funcion($1))
						       {
							  $$.identificador = $1; char *tipo; tipo_variable($1, ambito_actual(), &tipo);
                                                          $$.tipo = tipo;
							
                                                          liberar_funcion_llamada();
						          int etiqueta_llamada = etiqueta_funcion($1);
                                                          int registro;

							 if(!strcmp(tipo_identificador($1) , "float"))
                                                             registro=dame_registro_double();
                                                          else
                                                             registro=dame_registro();

                                                          int nueva_etiq = ne("");
                                                          char linea[50];
                                                          sprintf(linea, "\tP(R7 + 4) = R6;\n \tP(R7) = %d;\n \tGT(%d);\nL %d:\n \t%sR%d = %c(R7 - %d);\n \tR7 = R7 + %d;\n", nueva_etiq ,etiqueta_llamada ,nueva_etiq , tipo2Registro(tipo_identificador($1),parte_derecha), Registro2RegistroFloat(registro), tipo2char(tipo_identificador($1),parte_derecha), bytes(tipo_identificador($1)), tamano_parametros($1)); //Tamaño total parametros
                                                          gc(linea);

							  recuperar_registros();

                                                          if(!strcmp(tipo_identificador($1) , "float"))
                                                             push_pila(registro+10, -1, tipo_identificador($1),parte_derecha);
                                                          else
                                                             push_pila(registro, -1, tipo_identificador($1),parte_derecha);


  						       }
						       else if((strcmp($1, "printf")))
						       {
							  printf("Error: La funcion \"%s\" no coincide con el numero de parametros\n",$1);
							  exit(1);
						       }
						        else
							{
								int tam_string=0;
								while(printf1param[tam_string]!='\0') tam_string++;
								tam_string--; // tam_string incluye 2 dobles comillas pero le falta el fin de ristra -> -2+1=-1

								int direccion = alinear_bytes(tam_string);
								//printf1param=(char *)malloc(sizeof(char)*50);
								// Creamos una sección STAT para almacenar la ristra
								if(flagCODE == 1)
                                       				{
                                        				flagSTAT = 1;
									flagCODE = 0;
									
									char linea[50];
									sprintf(linea, "STAT(%d)\n\tSTR(0x%x,%s);\n", dame_STAT(),direccion,printf1param);
									gc(linea);
																	}
								// Creamos la sección CODE para continuar con el código del programa
								flagSTAT = 0;
								  if (flagCODE == 0)
                                                                  {
								      flagCODE = 1;
								      char linea[50];
                                                                      sprintf(linea, "CODE(%d)\n", dame_CODE());
                                                                      gc(linea);
									if(esPrintf==3)
									{
										int etiqueta=ne();
										int operador1_valor;
			    							int operador1_direccion;
			     							pop_pila(&operador1_valor, &operador1_direccion,"",parte_derecha);
										if(operador1_valor < 10)
											sprintf(linea, "\tR1=0x%x;\n\tR2=I(R%d);\n\tR0=%d;\n\tGT(-12);\nL %d:\n",direccion,operador1_direccion,etiqueta,etiqueta);
										else
											sprintf(linea, "\tR1=0x%x;\n\tR2=RR%d;\n\tR0=%d;\n\tGT(-12);\nL %d:\n",direccion,operador1_direccion-10,etiqueta,etiqueta);
										gc(linea);
									}
									else if(esPrintf==2)
									{
										int etiqueta=ne();
										sprintf(linea, "\tR1=0x%x;\n\tR2=%d;\n\tR0=%d;\n\tGT(-12);\nL %d:\n",direccion,printf2param,etiqueta,etiqueta);
										gc(linea);
									}
									else
									{
										int etiqueta=ne();
										sprintf(linea, "\tR1=0x%x;\n\tR0=%d;\n\tGT(-12);\nL %d:\n",direccion,etiqueta,etiqueta);
										gc(linea);
									}
								  }
								//printfo
								esPrintf=0;
							}
                                                     }  //Esto son llamadas a funciones f();
	| expresion_asignable POINT identificador {
                                                     int resultado = existe_campo(&$1.puntero_variable,&$1.tipo, $3.identificador);
                                                     if(!resultado)
						     {
                                                        printf("Error: El campo \"%s\" de la variable \"%s\" no existe\n", $3.identificador, $1.identificador);
							exit(1);
						     }
                      				     else
						     {
                                                        $$.identificador = $3.identificador;
                                                        $$.puntero_variable = $1.puntero_variable;
                                                     }
                                                  }
	;

posible_matriz
	: LCORCH expresion_vector RCORCH {$$ = 1;}
	| {$$ = 0;}
 	;

expresion_unaria
	: expresion_asignable {$$ = $1;} 
	| operador_unario IDENTIFICATOR {$$.identificador = $2; 
                                         char *tipo;
			                 tipo = (char *) malloc (50*sizeof(char));
                                         sprintf(tipo, "%s" , tipo_identificador($2));
                                         $$.tipo = tipo;

                                         char *cm;
                                         cm = (char *)malloc (50*sizeof(char));
                                         construccion_magica($2,cm);
  
                                         char linea[50];
                                         int registro_direccion = dame_registro();
                                         sprintf(linea, "\tR%d = P(%s);\n", registro_direccion, cm); //Tamaño total parametros
                                         gc(linea);
                                          
                                         if(parte_derecha == 1)
                                         {
                                            
                                           sprintf(linea, "\tR%d = I(R%d);\n", registro_direccion, registro_direccion); //Tamaño total parametros
                                           gc(linea);
                                           push_pila(registro_direccion, -1, tipo,parte_derecha);
                                         }
                                         else
                                            push_pila(-1, registro_direccion, tipo,parte_derecha);

                                        } 
	| expresion_unaria INC {$$ = $1;}
	| expresion_unaria DEC {$$ = $1;}
	| INC expresion_asignable  {$$ = $2;struct nodo_tabla_simbolos* puntero_variable;
                             int caso;
                             if(!existe_variable($2.identificador, &puntero_variable, &caso, categoria_identificador($2.identificador)))
			     {
                                printf("Error: variable \"%s\" no declarada\n", $2.identificador);
				exit(1);
			     }


                             char linea[50];
                             int operador1_valor;
			     int operador1_direccion;
			     pop_pila(&operador1_valor, &operador1_direccion,"",parte_derecha);
			     	
                             if(operador1_valor == -1)
                             {
				if(!strcmp(tipo_identificador($2.identificador),"int"))operador1_valor = dame_registro();
				else operador1_valor = dame_registro_double();
			        sprintf(linea, "\t%sR%d = %c(R%d);\n",tipo2Registro(tipo_identificador($2.identificador),parte_derecha),operador1_valor,tipo2char(tipo_identificador($2.identificador), parte_derecha),operador1_direccion);
                             gc(linea); 

                             }
			     if(operador1_direccion == -1)
                             {
				if(!strcmp(tipo_identificador($2.identificador),"int"))operador1_direccion = dame_registro();
				else operador1_direccion = dame_registro_double();
				
				if(caso == 3)
				{
					//Variable local
					int numero_magico_local = tamano_variable_local_hasta_posicion($2.identificador, ambito_actual());

					sprintf(linea, "\tR%d = R6 - %d;\n",operador1_direccion,numero_magico_local);

					gc(linea);
				}
				else if(caso == 1)
				{
					//Variable global
					int direccion = direccion_variable($2.identificador, ambito_actual());

					sprintf(linea, "\tR%d = 0x%x;\n",operador1_direccion,direccion);

					gc(linea);
				}
				else if(caso == 2)
				{
					//Parametros
					int numero_magico_local = tamano_parametros(ultimo_identificador_funcion())-tamano_parametro_hasta_posicion_id(ultimo_identificador_funcion(), $2.identificador);

					sprintf(linea, "\tR%d = R6 + %d;\n",operador1_direccion,numero_magico_local);

					gc(linea);
				}
			     }
                             sprintf(linea, "\t%sR%d = %sR%d + 1;\n \t%c(R%d) = %sR%d;\n",tipo2Registro(tipo_identificador($2.identificador),parte_derecha),Registro2RegistroFloat(operador1_valor),tipo2Registro(tipo_identificador($2.identificador),parte_derecha),Registro2RegistroFloat(operador1_valor),tipo2char(tipo_identificador($2.identificador), parte_derecha), operador1_direccion,tipo2Registro(tipo_identificador($2.identificador),parte_derecha),Registro2RegistroFloat(operador1_valor));
                             gc(linea);
                             //SE LIBERAN TRAS EL ; 
			     //liberar_registro(operador1_direccion);
                             //liberar_registro(operador1_valor);
                             //liberar_registros();
			     //liberar_registros_double();
                             push_pila(operador1_valor, operador1_direccion, $2.tipo,parte_derecha);
                               
                            }
	| DEC expresion_asignable  {$$ = $2;struct nodo_tabla_simbolos* puntero_variable;
                             int caso;
                             if(!existe_variable($2.identificador, &puntero_variable, &caso, categoria_identificador($2.identificador)))
			     {
                                printf("Error: variable \"$s\" no declarada\n", $2.identificador);
			   	exit(1);
			     }

                             char linea[50];
                             int operador1_valor;
			     int operador1_direccion;
			     pop_pila(&operador1_valor, &operador1_direccion,"",parte_derecha);
                             
			     if(operador1_valor == -1)
                             {
				if(!strcmp(tipo_identificador($2.identificador),"int"))operador1_valor = dame_registro();
				else operador1_valor = dame_registro_double();
			        sprintf(linea, "\t%sR%d = %c(R%d);\n",tipo2Registro(tipo_identificador($2.identificador),parte_derecha),operador1_valor,tipo2char(tipo_identificador($2.identificador), parte_derecha),operador1_direccion);
                             gc(linea); 

                             }
			
			     if(operador1_direccion == -1)
                             {
				if(!strcmp(tipo_identificador($2.identificador),"int"))operador1_direccion = dame_registro();
				else operador1_direccion = dame_registro_double();
				
				if(caso == 3)
				{
					//Variable local
					int numero_magico_local = tamano_variable_local_hasta_posicion($2.identificador, ambito_actual());

					sprintf(linea, "\tR%d = R6 - %d;\n",operador1_direccion,numero_magico_local);

					gc(linea);
				}
				else if(caso == 1)
				{
					//Variable global
					int direccion = direccion_variable($2.identificador, ambito_actual());

					sprintf(linea, "\tR%d = 0x%x;\n",operador1_direccion,direccion);

					gc(linea);
				}
				else if(caso == 2)
				{
					//Parametros
					int numero_magico_local = tamano_parametros(ultimo_identificador_funcion())-tamano_parametro_hasta_posicion_id(ultimo_identificador_funcion(), $2.identificador);

					sprintf(linea, "\tR%d = R6 + %d;\n",operador1_direccion,numero_magico_local);

					gc(linea);
				}
			     }

                             sprintf(linea, "\t%sR%d = %sR%d - 1;\n \t%c(R%d) = %sR%d;\n",tipo2Registro(tipo_identificador($2.identificador),parte_derecha),Registro2RegistroFloat(operador1_valor),tipo2Registro(tipo_identificador($2.identificador),parte_derecha),Registro2RegistroFloat(operador1_valor),tipo2char(tipo_identificador($2.identificador), parte_derecha), operador1_direccion,tipo2Registro(tipo_identificador($2.identificador),parte_derecha),Registro2RegistroFloat(operador1_valor));
                             gc(linea);
                              //SE LIBERAN TRAS EL ; 
                             //liberar_registros();
			     //liberar_registros_double();
                             push_pila(operador1_valor, operador1_direccion, $2.tipo,parte_derecha);
                            }
	;

operador_asignacion
	: ASIGOP {$<ristra>$ = "=";}
	| PRODASIGOP  {$<ristra>$ = "*"}
        | DIVASIGOP  {$<ristra>$ = "/";}
        | MODASIGOP  {$<ristra>$ = "%";}
        | SUMASIGOP  {$<ristra>$ = "+";}
        | RESASIGOP  {$<ristra>$ = "-";}
	;

expresion_multiplicativa
	: expresion_cast {$$ = $1;}
	| expresion_multiplicativa MULTOP expresion_cast {$$ = $1; //Se pasa el registro $$.registro del primero
                                                          if(!tipos_asig2($1.tipo) || !tipos_asig2($3.tipo))
							  {
								printf("Error: Las variables tienen tipos incompatibles \"%s\", \"%s\"\n" , $1.tipo, $3.tipo);
								exit(1);
							   }
							       char *tipo;
			   				       tipo = (char *) malloc (50*sizeof(char));
                           				       sprintf(tipo, "%s" , generar_operaciones("*", $1.tipo, $3.tipo));

							       $$.tipo = tipo;
                                                          /*liberar_registro(operador2_valor);   //¿?¿?¿?
							  liberar_registro(operador2_direccion); //¿?¿?¿?*/

                                                         }

	| expresion_multiplicativa DIVOP expresion_cast{$$ = $1; //Se pasa el registro $$.registro del primero
                                                        if(!tipos_asig2($1.tipo) || !tipos_asig2($3.tipo))
							  {
								printf("Error: Las variables tienen tipos incompatibles \"%s\", \"%s\"\n" , $1.tipo, $3.tipo);
								exit(1);
							   }

							       char *tipo;
			   				       tipo = (char *) malloc (50*sizeof(char));
                           				       sprintf(tipo, "%s" , generar_operaciones("/", $1.tipo, $3.tipo));

							       $$.tipo = tipo;
                                                          /*liberar_registro(operador1_valor);   //¿?¿?¿?
							  liberar_registro(operador1_direccion); //¿?¿?¿?*/

							  
                                                       }
	| expresion_multiplicativa MODOP expresion_cast{$$ = $1;
                                                         if(!tipos_asig2($1.tipo) || !tipos_asig2($3.tipo))
							  {
								printf("Error: Las variables tienen tipos incompatibles \"%s\", \"%s\"\n" , $1.tipo, $3.tipo);
								exit(1);
							   }

							  char *tipo;
			   				  tipo = (char *) malloc (50*sizeof(char));
                           				  sprintf(tipo, "%s" , generar_operaciones("%", $1.tipo, $3.tipo));

							  $$.tipo = tipo;

                                                       }
	;

expresion_aditiva
	: expresion_multiplicativa {$$ = $1;}
	| expresion_aditiva ADDOP expresion_multiplicativa  {  $$ = $1;
                                                               //Si son variables
			
                                                               if(!tipos_asig2($1.tipo) || !tipos_asig2($3.tipo))
							       {
								  printf("Error: Las variables tienen tipos incompatibles \"%s\", \"%s\"\n" ,  $1.tipo, $3.tipo);
								exit(1);
							        }
							       char *tipo;
			   				       tipo = (char *) malloc (50*sizeof(char));
                           				       sprintf(tipo, "%s" , generar_operaciones("+", $1.tipo, $3.tipo));

							       $$.tipo = tipo;
                                                              /* liberar_registro(operador2_valor);   //¿?¿?¿?
							       liberar_registro(operador2_direccion); //¿?¿?¿?*/
							       
                                                            }
                                                            
	| expresion_aditiva MINUSOP expresion_multiplicativa { $$ = $1;
                                                           if(!tipos_asig2($1.tipo) || !tipos_asig2($3.tipo))
							   {
								printf("Error: Las variables tienen tipos incompatibles \"%s\", \"%s\"\n" ,  $1.tipo, $3.tipo);
								exit(1);
							   }
                                                               char *tipo;
			   				       tipo = (char *) malloc (50*sizeof(char));
                           				       sprintf(tipo, "%s" , generar_operaciones("-", $1.tipo, $3.tipo));

							       $$.tipo = tipo;
                                                               /*liberar_registro(operador1_valor);   //¿?¿?¿?
							       liberar_registro(operador1_direccion); //¿?¿?¿?*/
							       
                                                              }
	;

/*CUIDADO CON LAS COMPARACIONES*/
expresion_shift
	: expresion_aditiva {$$ = $1;}
 	| expresion_shift LDESP expresion_aditiva { $$ = $1;
                                                   if(!tipos_asig2($1.tipo) || !tipos_asig2($3.tipo))
							  {
								printf("Error: Las variables tienen tipos incompatibles \"%s\", \"%s\"\n" ,  $1.tipo, $3.tipo);
								exit(1);
							   }}
	| expresion_shift RDESP expresion_aditiva {$$ = $1;
                                                   if(!tipos_asig2($1.tipo) || !tipos_asig2($3.tipo))
							  {
								printf("Error: Las variables tienen tipos incompatibles \"%s\", \"%s\"\n" ,  $1.tipo, $3.tipo);
								exit(1);
							   }}
	;

expresion_relacional
	: expresion_shift {$$ = $1;}
	| expresion_relacional LOWOP expresion_shift { $$ = $1;
                                                       if(!tipos_asig2($1.tipo) || !tipos_asig2($3.tipo))
							  {
								printf("Error: Las variables tienen tipos incompatibles \"%s\", \"%s\"\n" ,  $1.tipo, $3.tipo);
								exit(1);
							   }

                                                              char *tipo;
			   				       tipo = (char *) malloc (50*sizeof(char));
                           				       sprintf(tipo, "%s" , generar_operaciones("<", $1.tipo, $3.tipo));

							       $$.tipo = tipo;
                                                               
                                                      } 
	| expresion_relacional GREATOP expresion_shift { $$ = $1;
                                                       if(!tipos_asig2($1.tipo) || !tipos_asig2($3.tipo))
							  {
								printf("Error: Las variables tienen tipos incompatibles \"%s\", \"%s\"\n" ,  $1.tipo, $3.tipo);
								exit(1);
							   }

                                                               char *tipo;
			   				       tipo = (char *) malloc (50*sizeof(char));
                           				       sprintf(tipo, "%s" , generar_operaciones(">", $1.tipo, $3.tipo));

							       $$.tipo = tipo;
                                                       } 
	| expresion_relacional LOWEQOP expresion_shift { $$ = $1;
                                                       if(!tipos_asig2($1.tipo) || !tipos_asig2($3.tipo))
							  {
								printf("Error: Las variables tienen tipos incompatibles \"%s\", \"%s\"\n" ,  $1.tipo, $3.tipo);
								exit(1);
							   }
                                                         
                                                               char *tipo;
			   				       tipo = (char *) malloc (50*sizeof(char));
                           				       sprintf(tipo, "%s" , generar_operaciones("<=", $1.tipo, $3.tipo));

							       $$.tipo = tipo;
                                                       } 
	| expresion_relacional GREATEQOP expresion_shift{ $$ = $1;
                                                       if(!tipos_asig2($1.tipo) || !tipos_asig2($3.tipo))
							  {
								printf("Error: Las variables tienen tipos incompatibles \"%s\", \"%s\"\n" ,  $1.tipo, $3.tipo);
								exit(1);
							   }
                                                       
                                                               char *tipo;
			   				       tipo = (char *) malloc (50*sizeof(char));
                           				       sprintf(tipo, "%s" , generar_operaciones(">=", $1.tipo, $3.tipo));

							       $$.tipo = tipo;
                                                      } 
	;

//Para comparar tipos eston deben ser iguales
expresion_igualdad
	: expresion_relacional {$$ = $1;}
	| expresion_igualdad EQUOP expresion_relacional { $$ = $1;
                                                           if(!tipos_asig2($1.tipo) || !tipos_asig2($3.tipo))
							  {
								printf("Error: Las variables tienen tipos incompatibles \"%s\", \"%s\"\n" , $1.tipo, $3.tipo);
								exit(1);
							   }
                                                            
                                                               char *tipo;
			   				       tipo = (char *) malloc (50*sizeof(char));
                           				       sprintf(tipo, "%s" , generar_operaciones("==", $1.tipo, $3.tipo));

							       $$.tipo = tipo;
                                                        } 
	| expresion_igualdad NOTEQOP expresion_relacional { $$ = $1;
                                                          if(!tipos_asig2($1.tipo) || !tipos_asig2($3.tipo))
							  {
								printf("Error: Las variables tienen tipos incompatibles \"%s\", \"%s\"\n" ,  $1.tipo, $3.tipo);
								exit(1);
							   }
                                                            
                                                               char *tipo;
			   				       tipo = (char *) malloc (50*sizeof(char));
                           				       sprintf(tipo, "%s" , generar_operaciones("!=", $1.tipo, $3.tipo));

							       $$.tipo = tipo;
                                                          }
	;

expresion_and
	: expresion_igualdad {$$ = $1;}
	| expresion_and ANDOP expresion_igualdad { $$ = $1;
                                                   if(!tipos_asig2($1.tipo) || !tipos_asig2($3.tipo))
							  {
								printf("Error: Las variables tienen tipos incompatibles \"%s\", \"%s\"\n" ,  $1.tipo, $3.tipo);
								exit(1);
							   }
                                                               char *tipo;
			   				       tipo = (char *) malloc (50*sizeof(char));
                           				       sprintf(tipo, "%s" , generar_operaciones("&", $1.tipo, $3.tipo));

							       $$.tipo = tipo;
                                                 }
	; 

expresion_exclusiva_or
	: expresion_and {$$ = $1;}
	| expresion_exclusiva_or ELEVADOOP expresion_and { $$ = $1;
						           if(!tipos_asig2($1.tipo) || !tipos_asig2($3.tipo))
							  {
								printf("Error: Las variables tienen tipos incompatibles \"%s\", \"%s\"\n" ,  $1.tipo, $3.tipo);
								exit(1);
							   }
                                                               char *tipo;
			   				       tipo = (char *) malloc (50*sizeof(char));
                           				       sprintf(tipo, "%s" , generar_operaciones("^", $1.tipo, $3.tipo));

							       $$.tipo = tipo;
							 } 
	;

expresion_inclusiva_or
	: expresion_exclusiva_or {$$ = $1;}
	| expresion_inclusiva_or OROP expresion_exclusiva_or { $$ = $1;
						               if(!tipos_asig2($1.tipo) || !tipos_asig2($3.tipo))
							  {
								printf("Error: Las variables tienen tipos incompatibles \"%s\", \"%s\"\n" ,  $1.tipo, $3.tipo);
								exit(1);
							   }

                                                               char *tipo;
			   				       tipo = (char *) malloc (50*sizeof(char));
                           				       sprintf(tipo, "%s" , generar_operaciones("|", $1.tipo, $3.tipo));

							       $$.tipo = tipo;
							 } 
	;

expresion_logica_and
	: expresion_inclusiva_or {$$ = $1;}
	| expresion_logica_and AND expresion_inclusiva_or { $$ = $1;
						           if(!tipos_asig2($1.tipo) || !tipos_asig2($3.tipo))
							  {
								printf("Error: Las variables tienen tipos incompatibles \"%s\", \"%s\"\n" ,  $1.tipo, $3.tipo);
								exit(1);
							   }
                                                           char *tipo;
			   				   tipo = (char *) malloc (50*sizeof(char));
                           				   sprintf(tipo, "%s" , generar_operaciones("&&", $1.tipo, $3.tipo));

							   $$.tipo = tipo;
							 } 
	;

expresion_logica_or
	: expresion_logica_and {$$ = $1;}
	| expresion_logica_or OR expresion_logica_and { $$ = $1;
						           if(!tipos_asig2($1.tipo) || !tipos_asig2($3.tipo))
							  {
								printf("Error: Las variables tienen tipos incompatibles \"%s\", \"%s\"\n" ,  $1.tipo, $3.tipo);
								exit(1);
							   }

                                                           char *tipo;
			   				   tipo = (char *) malloc (50*sizeof(char));
                           				   sprintf(tipo, "%s" , generar_operaciones("||", $1.tipo, $3.tipo));

							   $$.tipo = tipo;
							 } //OR y AND son || y && esta bien?
	; 
expresion_condicional
	: expresion_logica_or {$$ = $1;}
	;

expresion_asignacion
	: expresion_condicional {$$ = $1;}
	| expresion_unaria operador_asignacion {parte_derecha = 1;} expresion_asignacion {$$ = $1;
							   //Traducimos el tipo de las variables para poder compararlos correctamente
							  //char tipo_traducido[50];
							  //sprintf(tipo_traducido, "%s",traducir_tipo($1.tipo)); 
							  //Cogemos asig2 para tomar numero

							 /* if((!tipos_asig($1.tipo)||(!strcmp($1.tipo,"NUMERO")))  || !tipos_asig2($4.tipo) || !compatibilidades($1.tipo, $4.tipo ,categoria_identificador($1.identificador) , categoria_identificador($4.identificador)))*/
                                                          if(!tipos_asig($1.tipo)|| !tipos_asig2($4.tipo))					
							  {
								printf("Error: Las variables tienen tipos incompatibles \"%s\", \"%s\"\n" , $1.tipo, $4.tipo);
								exit(1);
							   }
                                                           //Almacenamos el valor en la direccion $1.registro
                                                           char linea[50];
							   int operador1_valor;
							   int operador1_direccion;
							   int operador2_valor;
							   int operador2_direccion;
//printf("asdf\n");
							   if(Es_Funcion == 1)
							   {
								pop_pila(&operador2_valor, &operador2_direccion, "",parte_derecha);
							   	pop_pila(&operador1_valor, &operador1_direccion, "",parte_derecha);
								Es_Funcion = 0;
							   }
							   else
							   {
							   	pop_pila(&operador1_valor, &operador1_direccion, "",parte_derecha);
							   	pop_pila(&operador2_valor, &operador2_direccion, "",parte_derecha);
							   }
							   if (strcmp($<ristra>2, "=")) // Si NO es la asignación normal
							   {
								int registro_aux;
								if(!strcmp($1.tipo, "float")) registro_aux = dame_registro_double();
								else registro_aux = dame_registro();

								char Rcontrol[1];
								Rcontrol[0] = ' ';
								if(!strcmp($4.tipo, "float")) Rcontrol[0] = 'R';
								else Rcontrol[0] = ' ';

								sprintf(linea, "\t%sR%d = %c(R%d);\n",	
								tipo2Registro(tipo_identificador($1.identificador),parte_derecha),	
								Registro2RegistroFloat(registro_aux),	
								tipo2char(tipo_identificador($1.identificador), parte_derecha),
								Registro2RegistroFloat(operador2_direccion));	
								gc(linea);			 
								 sprintf(linea, "\t%sR%d = %sR%d %s %cR%d;\n",tipo2Registro(tipo_identificador($1.identificador),parte_derecha),Registro2RegistroFloat(registro_aux),tipo2Registro(tipo_identificador($1.identificador),parte_derecha),Registro2RegistroFloat(registro_aux),$<ristra>2,Rcontrol[0],Registro2RegistroFloat(operador1_valor));
								gc(linea);

								sprintf(linea, "\t%c(R%d) = %sR%d;\n",tipo2char(tipo_identificador($1.identificador), parte_derecha),operador2_direccion,tipo2Registro(tipo_identificador($1.identificador),parte_derecha),Registro2RegistroFloat(registro_aux));
	                                                        gc(linea); 
								
							   }
							   else
							   {
								   //Segun el tipo ponemos una I o U etc.. para indicar el tipo de lo que almacenamos
								   if(!strcmp($1.tipo, "char"))
									sprintf(linea, "\tU(R%d) = R%d;\n",operador2_direccion,operador1_valor); 
								   else if(!strcmp($1.tipo, "int"))
								   {
								        if(operador1_valor<10)	
	                                                           	   sprintf(linea, "\tI(R%d) = R%d;\n",operador2_direccion,operador1_valor);
									else
									   sprintf(linea, "\tI(R%d) = RR%d;\n",operador2_direccion,operador1_valor-10);
								   }
								   else if(!strcmp($1.tipo, "float"))
								   {
									if(operador1_valor<10)
	                                                           		sprintf(linea, "\tF(R%d) = R%d;\n",operador2_direccion,operador1_valor);
									else
										sprintf(linea, "\tF(R%d) = RR%d;\n",operador2_direccion,operador1_valor-10);
								   }
	                                                           gc(linea); 
							   }
                                                           liberar_registros();
							   liberar_registros_double();
							
							 }
	/*| identificador INC {struct nodo_tabla_simbolos* puntero_variable;
                             int caso;
                             if(!existe_variable($1.identificador, &puntero_variable, &caso))
                               printf("Error: variable \"%s\" no declarada\n", $1.identificador);


                             char linea[50];
                             int operador1_valor;
			     int operador1_direccion;
			     pop_pila(&operador1_valor, &operador1_direccion);
                             sprintf(linea, "\tR%d = R%d + 1;\n \tI(R%d) = R%d;\n",operador1_valor,operador1_valor, operador1_direccion, operador1_valor);
                             gc(linea); 
                             liberar_registros();
                            }

	| identificador DEC {struct nodo_tabla_simbolos* puntero_variable;
                             int caso;
                             if(!existe_variable($1.identificador, &puntero_variable, &caso))
                                printf("Error: variable \"$s\" no declarada\n", $1.identificador);

                             char linea[50];
                             int operador1_valor;
			     int operador1_direccion;
			     pop_pila(&operador1_valor, &operador1_direccion);
                             sprintf(linea, "\tR%d = R%d - 1;\n \tI(R%d) = R%d;\n",operador1_valor,operador1_valor, operador1_direccion, operador1_valor);
                             gc(linea); 
                             liberar_registros();
                            }*/
	;

expresion_vector
	: expresion_asignacion
	| expresion_vector COLON expresion_asignacion
	;


expresion
	: expresion_asignacion {$$ = $1; 
			if (esPrintf==0){ 
                                if(estamos_funcion_llamada())
                                {

				    suma_ultimo_numelem_funcion();
                                    int numero_magico = tamano_parametros(ultimo_identificador_funcion_llamada())-tamano_parametro_hasta_posicion(ultimo_identificador_funcion_llamada(), contador_parametros--);

                                    int numero_magico_local = tamano_variable_local_hasta_posicion($1.identificador, ambito_actual());

                                    char categoria[50];
				    //Categoria del identifiador

				    if(flagVector)
				    {
					sprintf(categoria, "variable");
					flagVector=0;
				    }
				    else
					sprintf(categoria, "%s",categoria_identificador($1.identificador));


                                    int rv;
                                    int rd;
			            
                                    char linea[50];

                                   if(!strcmp(categoria, "puntero"))
                                    {
                                       /*int base = numero_magico;
                                       int i;
                                       int n = num_elem_identificador($1.identificador);

                                       //Cuando encontramos una llamada a una funcion reservamos mas espacio del vector porque en la declaracion
                                       //De la funcion se reserva para int *a
                                       sprintf(linea, "\tR7 = R7 - %d;\n" , bytes($1.tipo)*n - 4);
                                       gc(linea); 

                                       for(i=0; i<n ;i++)
                                       {
                                          sprintf(linea, "\tI(R7 + %d) = I(R6 - %d);\n",numero_magico + i*bytes($1.tipo) , numero_magico_local - i*bytes($1.tipo));
				          gc(linea);
                                       }*/
                                       sprintf(linea, "\tR5 = R6 - %d;\n\tI(R7 + %d) = R5;\n",numero_magico_local,numero_magico);
				       gc(linea);
				       
                                       //
				       //push_pila(rv, rd,$1.tipo);

                                    }
                                    else
                                    {
				       pop_pila(&rv, &rd,"",parte_derecha);
                                       if(rv < 10)
                                          sprintf(linea, "\tI(R7 + %d) = R%d;\n",numero_magico ,rv);
				       else
				          sprintf(linea, "\tI(R7 + %d) = RR%d;\n",numero_magico ,rv-10);
				       gc(linea);
                                    }
                                    //liberar_registros();
				    //liberar_registros_double();
                                    /*Primer elemento*/
                                    int posicion = ultimo_numelem_funcion();

				    
				    int ancho = width($1.identificador);
                                    if(!tipo_parametro_funcion(ultimo_identificador_funcion_llamada(), $1.tipo,categoria, posicion, ancho))
				    {
					printf("Error: Paso de parametro \"%s\" en la función \"%s\" erronea\n" , $1.identificador,ultimo_identificador_funcion_llamada());
					exit(1);
				    }
				    //suma_ultimo_numelem_funcion();
				    if(rv < 10)
                                        liberar_registro(rv);
				    else
					liberar_registro_double(rv-10);
                                }
                             }
                          }
	| expresion COLON expresion_asignacion {if(esPrintf==0){                                    

                                                int numero_magico = tamano_parametros(ultimo_identificador_funcion_llamada())-tamano_parametro_hasta_posicion(ultimo_identificador_funcion_llamada(), contador_parametros--);
                                                int rv;
                                                int rd;
			                        pop_pila(&rv, &rd,"",parte_derecha);
                                                char linea[50];
						
						if(rv < 10)
                                                	sprintf(linea, "\tI(R7 + %d) = R%d;\n",numero_magico ,rv);
						else
							sprintf(linea, "\tI(R7 + %d) = RR%d;\n",numero_magico ,rv-10);
    
				                gc(linea);

                                                /*Siguientes elementos*/
						//Cuando hay comas se aumenta el numero de parametros
						suma_ultimo_numelem_funcion();
                                                int posicion = ultimo_numelem_funcion();

						char categoria[50]; 

						if(flagVector)
						{
						   sprintf(categoria, "variable");
						   flagVector=0;
				    		}
				    		else
						   sprintf(categoria, "%s",categoria_identificador($3.identificador));

                                                int ancho = width($1.identificador);
                                                if(!tipo_parametro_funcion(ultimo_identificador_funcion_llamada(), $3.tipo,categoria, posicion, ancho))
					        {
						   printf("Error: Paso de parametro \"%s\" en la función \"%s\" erronea\n" , $3.identificador,ultimo_identificador_funcion_llamada());
						   exit(1);
						}
						  if(rv < 10)
                                                	liberar_registro(rv);
						  else
							liberar_registro_double(rv-10);
    
                                                  $$ = $3;
                                               }
					}
	;

identificador
	: IDENTIFICATOR {  struct nodo_tabla_simbolos* puntero_variable;
                           //char tipo[50];
			   char *tipo;
			   tipo = (char *) malloc (50*sizeof(char));
                           sprintf(tipo, "%s" , tipo_identificador($1));

                           int caso;
                           if(!existe_variable($1, &puntero_variable, &caso, categoria_identificador($1)))
                           {
                             	printf("Error: variable \"%s\" no declarada\n", $1);
				exit(1);
                           }
                           else
                           {


                            //Variables globales
                            /*if(caso == 1)
                            {
                               if(strcmp(categoria_identificador($1), "puntero"))
			       {
                                  $$.identificador = $1;
                                  int direccion = direccion_variable($1, ambito_actual());
                                  //Si direccion es -1 es una funcion
                                  if(direccion != -1)
                                  {
                           
                                    char linea[50];
                                    int registro_direccion=dame_registro();
                                    int registro_valor=dame_registro();
			            push_pila(registro_valor, registro_direccion);
                                    sprintf(linea, "\tR%d = 0x%x;\n \tR%d = I(R%d);\n",registro_direccion,direccion, registro_valor, registro_direccion);
                                    gc(linea); 
                                  }
                              }*/
			    //Variables globales
                            if(caso == 1)
                            {
                               if(strcmp(categoria_identificador($1), "puntero"))
			       {
                                  $$.identificador = $1;
                                  int direccion = direccion_variable($1, ambito_actual());
                                  //Si direccion es -1 es una funcion
                                  if(direccion != -1)
                                  {
					char linea[50];
                                 	int registro_valor;/*  = dame_registro_double();*/
		                	int registro_direccion;/* = dame_registro();*/
					if(tipo != NULL)
			         	{
			      			if(!strcmp(tipo, "float"))
			      			{

 							if((parte_derecha == 0)&& !(estamos_funcion_llamada()) && !flag_V)
                                                        {
                                                            
                                                           registro_direccion = dame_registro();
                                                           push_pila(-1, registro_direccion,tipo,parte_derecha);
							   sprintf(linea, "\tR%d = 0x%x;\n",registro_direccion,direccion);
                                                        }
                                                        else
                                                        {
                                                           registro_valor = dame_registro_double();
                                                           push_pila(registro_valor+10, -1,tipo,parte_derecha); // (registro_valor+10, -1,tipo)
							   sprintf(linea, "\tRR%d = F(0x%x);\n",registro_valor,direccion);
                                                        }
			      			}
			     	 		else
			      			{
                              			        if((parte_derecha == 0) && !(estamos_funcion_llamada()) && !flag_V)
                                                        {
                                                            
                                                           registro_direccion = dame_registro();
                                                           push_pila(-1, registro_direccion,tipo,parte_derecha);   
							   sprintf(linea, "\tR%d = 0x%x;\n",registro_direccion,direccion);
                                                        }
                                                        else
                                                        {
                                                           registro_valor = dame_registro();   
                                                           push_pila(registro_valor, -1,tipo,parte_derecha);
							   sprintf(linea, "\tR%d = I(0x%x);\n",registro_valor,direccion);
                                                        }
			      			}
			         	}
			        	else
			         	{
						registro_valor = dame_registro();
			      			registro_direccion = dame_registro();	
						push_pila(registro_valor, registro_direccion,tipo,parte_derecha);
						sprintf(linea, "\t^^R%d = 0x%x;\n \tR%d = I(R%d);\n",registro_direccion,direccion,registro_valor,registro_direccion);
			         	}
					//sprintf(linea, "\tR%d = 0x%x;\n \tR%d = I(R%d);\n",registro_direccion,direccion, registro_valor, registro_direccion);
                                  	gc(linea);                             
                                  }
                              }
			      else
 			      {
				if(!estamos_funcion_llamada(NULL))
				{
 				   printf("Error: variable \"%s\" es un vector\n", $1);
				   exit(1);
				}
			      }
                              /* else 
			       {
                                   if(estamos_funcion_llamada(NULL)) //Parametro vector
                                   {
				      $$.identificador = $1;
				      int direccion = direccion_variable($1, ambito_actual());
				      int tamano_tipo = identificador2size($1);
				      int direccion_base = direccion - num_elem_identificador($1)*tamano_tipo;

                                      char linea[50];
                                      int registro_direccion=dame_registro();
			              push_pila(registro_direccion, -1);
                                      sprintf(linea, "\tR%d = 0x%x;\n",registro_direccion,direccion_base);
                                      gc(linea); 
                                   }
                               }*/
                           }

                            //Variables local
                            if(caso == 3)
                            {		
			       if(strcmp(categoria_identificador($1), "puntero"))
			       {
                                 int numero_magico_local = tamano_variable_local_hasta_posicion($1, ambito_actual());
                                 char linea[50];
                                 int registro_valor;/*  = dame_registro_double();*/
		                 int registro_direccion;/* = dame_registro();*/

				//printf("- %s , numero mágico local: %d\n",$1,numero_magico_local);

			         if(tipo != NULL)
			         {

			      		if(!strcmp(tipo, "float"))
			      		{
						if((parte_derecha == 0) && !(estamos_funcion_llamada()) && !flagRETURN && !flag_V)
                                                {
                                                         
                                                   registro_direccion = dame_registro();
                                                   push_pila(-1, registro_direccion,tipo,parte_derecha);   
						   sprintf(linea, "\tR%d = R6 - %d;\n",registro_direccion,numero_magico_local);
                                                }
                                                else
                                                {
                                                   registro_valor = dame_registro_double();  
                                                   push_pila(registro_valor+10, -1,tipo,parte_derecha);
						   sprintf(linea, "\tRR%d = F(R6 - %d);\n",registro_valor,numero_magico_local);
                                                }

			      		}
			     	 	else
			      		{
						if((parte_derecha == 0) && !(estamos_funcion_llamada()) && !flagRETURN  && !flag_V)
                                                {
                                                            
                                                   registro_direccion = dame_registro();
                                                   push_pila(-1, registro_direccion,tipo,parte_derecha);   
						   sprintf(linea, "\tR%d = R6 - %d;\n",registro_direccion,numero_magico_local);
                                                }
                                                else
                                                {
                                                   registro_valor = dame_registro();
                                                   push_pila(registro_valor, -1,tipo,parte_derecha);
						   sprintf(linea, "\tR%d = I(R6 - %d);\n",registro_valor,numero_magico_local);
                                                }
                              			
			      		}
			         }
			         else
			         {
					registro_valor = dame_registro();
			      		registro_direccion = dame_registro();	
					push_pila(registro_valor, registro_direccion,tipo,parte_derecha);
					sprintf(linea, "\tR%d = R6 - %d;\n \tR%d = I(R%d);\n",registro_direccion,numero_magico_local,registro_valor,registro_direccion);
			         }
                                 /*sprintf(linea, "\tR%d = R6 - %d;\n \tR%d = I(R%d);\n",registro_direccion,numero_magico_local,registro_valor,registro_direccion);
                                 push_pila(registro_valor, registro_direccion);*/
                                  gc(linea);  
			      }
			      else
 			      {
			        if(!estamos_funcion_llamada(NULL))
				{
				   printf("Error: variable \"%s\" es un vector\n", $1);
				   exit(1);
				}
			      }
       
                            }

                            //Parametro
                            /*if(caso == 2)
                            {
			       if(strcmp(categoria_identificador($1), "puntero"))
			       {
                                 int numero_magico = tamano_parametros(ultimo_identificador_funcion())-tamano_parametro_hasta_posicion_id(ultimo_identificador_funcion(), $1);
                                 char linea[50];
                                 int registro_valor = dame_registro();
			         int registro_direccion = dame_registro();
                                 sprintf(linea, "\tR%d = R6 + %d;\n \tR%d = I(R%d);\n",registro_direccion,numero_magico,registro_valor,registro_direccion);
                                 push_pila(registro_valor, registro_direccion);
                                 gc(linea);
			      }*/
			    //Parametro
                            if(caso == 2)
                            {
			       if(strcmp(categoria_identificador($1), "puntero"))
			       {
                                 int numero_magico_local = tamano_parametros(ultimo_identificador_funcion())-tamano_parametro_hasta_posicion_id(ultimo_identificador_funcion(), $1);
                                 char linea[50];
                                 int registro_valor;
			         int registro_direccion;
				 if(tipo != NULL)
			         {
			      		if(!strcmp(tipo, "float"))
			      		{
						if((parte_derecha == 0) && !(estamos_funcion_llamada()) && !flag_V)
                                                {
                                                            
                                                   registro_direccion = dame_registro();
                                                   push_pila(-1, registro_direccion,tipo,parte_derecha);   
						   sprintf(linea, "\tR%d = R6 + %d;\n",registro_direccion,numero_magico_local);
                                                }
                                                else
                                                {
                                                   registro_valor = dame_registro_double();   
                                                   push_pila(registro_valor+10, -1,tipo,parte_derecha);
						   sprintf(linea, "\tRR%d = F(R6 + %d);\n",registro_valor,numero_magico_local);
                                                }
			      		}
			     	 	else
			      		{
						if((parte_derecha == 0) && !(estamos_funcion_llamada()) && !flag_V)
                                                {
                                                            
                                                   registro_direccion = dame_registro();
                                                   push_pila(-1, registro_direccion,tipo,parte_derecha);   
						   sprintf(linea, "\tR%d = R6 + %d;\n",registro_direccion,numero_magico_local);
                                                }
                                                else
                                                {
                                                   registro_valor = dame_registro();   
                                                   push_pila(registro_valor, -1,tipo,parte_derecha);
						   sprintf(linea, "\tR%d = I(R6 + %d);\n",registro_valor,numero_magico_local);
                                                }
			      		}
			         }
			         else
			         {
					registro_valor = dame_registro();
			      		registro_direccion = dame_registro();	
					push_pila(registro_valor, registro_direccion,tipo,parte_derecha);
					sprintf(linea, "\tR%d = R6 + %d;\n \tR%d = I(R%d);\n",registro_direccion,numero_magico_local,registro_valor,registro_direccion);
			         }
                                 /*sprintf(linea, "\tR%d = R6 + %d;\n \tR%d = I(R%d);\n",registro_direccion,numero_magico_local,registro_valor,registro_direccion);*/
                                 gc(linea);
			      }
			      else
 			      {
				if(!estamos_funcion_llamada(NULL))
				{
				   printf("Error: variable \"%s\" es un vector\n", $1);
				   exit(1);
				}
			      }
                            }
//printf("EEE\n\n"); printf("%s\n", tipo); printf("OOO\n");
                            tipo_variable($1, ambito_actual(), &tipo);

                            $$.identificador = $1;
                            $$.puntero_variable = puntero_variable;
                            $$.tipo = tipo; //pasamos el tipo de la variable
//printf("UUU\n"); printf("%s\n", tipo); printf("AAA\n\n");
                           }


                        }
	;



/*expresion_condicional
	: IDENTIFICATOR
	;*/

/*instrucciones
	: instrucciones IDENTIFICATOR
	| 
	;*/





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

