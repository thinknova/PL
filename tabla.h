
#ifndef LISTA_H_
#define LISTA_H_

#include "stdlib.h"
#include "stdio.h"
#include <string.h>


typedef struct NodoLista TNodoLista, *PNodoLista;

struct NodoLista {
	char *nombre;
	char *categoria;
	int ambito;
	PNodoLista tipo;
	int tamano;  		// indica el tamaño para variables
	int dir;  		// direccion de memoria
    	PNodoLista sig,ant;
};

struct Lista {
    int NumElem;
    PNodoLista primero,ultimo; 	// Punteros que señalan al primer y ultimo nodo de la tabla de simbolos
};

typedef struct Lista *PLista, TLista;

PLista inicializa(PLista lista);

int ts(PLista lista, char* nombre, char* categoria, int ambito, char* tipo, int tamano, int dir);

PNodoLista busca(PLista lista, char *nombre);

int direccion(PLista lista, char *p, int ambito);

int tipovar(PLista lista, char *p, int ambito);

char* tipovar2(PLista lista, char *p, int ambito);

int nargfun(PLista lista, char *id);

char* tipoargfun(PLista lista, char* id, int n);

int dirargfun(PLista lista, char* id, int n);

int tam_par(PLista lista, char * funcion);

int etiqueta(PLista lista, char* funcion);

int devambito(PLista lista, char* funcion);

char* categoria(PLista lista, char* id, int ambito);

void imprimeTS(PLista lista);

void destruye(PLista lista);


#endif /*LISTA_H_*/





