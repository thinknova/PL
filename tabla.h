#ifndef LISTA_H_
#define LISTA_H_

#include "stdlib.h"
#include "stdio.h"
#include <string.h>

/*
 *	-------------------------------------------
 *	DESARROLLADO POR:
 *		Pablo Ojeda Vasco
 *		Roberto Marco Sánchez
 *	LICENCIA: GNU General Public License
 * 	TITULO: Compilador Lex/Flex para lenguaje C
 *  -------------------------------------------
 *  Tabla de símbolos (tabla.h)
 *
 */

typedef struct NodoLista TNodoLista, *PNodoLista;

struct NodoLista {
	char *nombre;
	char *categoria;
	int ambito;
	PNodoLista tipo;
	int tamano;  				// Indica el tamaño para variables
	int dir;  					// Dirección de memoria
    PNodoLista sig,ant;
};

struct Lista {
    int NumElem;
    PNodoLista primero,ultimo; 	// Punteros que señalan al primer y último nodo de la tabla de símbolos
};

typedef struct Lista *PLista, TLista;

PLista inicializa(PLista lista);					// Inicializa la tabla de símbolos
int ts(PLista lista, char* nombre, char* categoria, int ambito, char* tipo, int tamano, int dir);	// Inserta entradas en la tabla de símbolos 
PNodoLista busca(PLista lista, char *nombre); 		// Devuelve la direccion de la entrada de la tabla de simbolos en caso de que exista. Si no, devuelve nulo.
int direccion(PLista lista, char *p, int ambito); 	// Devuelve el campo dirección de la variable pasada.
int tipovar(PLista lista, char *p, int ambito);		// Devuelve el tamaño del tipo de la variable pasada.
char* tipovar2(PLista lista, char *p, int ambito);	// Devuelve el tipo de la variable pasada.
int nargfun(PLista lista, char *id);				// Devuelve el nº de argumentos de una función			
char* tipoargfun(PLista lista, char* id, int n);	// Devuelve el tipo de los argumentos de una función	
int dirargfun(PLista lista, char* id, int n);		// Devuelve el campo dir de los argumentos de una función
int tam_par(PLista lista, char * funcion);			// Devuelve el tamaño de los parametros de una funcion
int etiqueta(PLista lista, char* funcion);			// Devuelve la etiqueta de una función
int devambito(PLista lista, char* funcion);			// Devuelve el ámbito de una función
char* categoria(PLista lista, char* id, int ambito);// Devuelve la categoría
void imprimeTS(PLista lista);						// Imprime por pantalla la tabla de símbolos
void destruye(PLista lista);						// Destruye la tabla de símbolos

#endif





