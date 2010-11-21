#include "tabla.h"


// Inicializa la tabla de símbolos
PLista inicializa(PLista lista){
	lista =(PLista)malloc(sizeof(TLista));
        lista->NumElem=0;
        lista->primero=NULL;
        lista->ultimo=NULL;

	ts(lista,"entero", "tipo", 0, "", 4, 0);
	ts(lista,"caracter", "tipo", 0, "", 1, 0);
	ts(lista,"real", "tipo", 0, "", 4, 0);
	ts(lista,"logico", "tipo", 0, "", 4, 0);
	
	return lista;
}

// Inserta entradas en la tabla de símbolos
int ts(PLista lista,char* nombre, char* categoria, int ambito, char* tipo, int tamano, int dir){
       
 	TNodoLista *nuevo = (TNodoLista *)malloc(sizeof(TNodoLista));
        
        if(nuevo!=NULL){
                if (lista->NumElem!=0){
                        
			nuevo->nombre = nombre;
			nuevo->categoria = categoria;
			nuevo->ambito = ambito;
			nuevo->tipo = busca(lista,tipo);

			nuevo->dir = dir;
			
                        nuevo->sig=NULL;
                        nuevo->ant=lista->ultimo;
                        lista->ultimo->sig=nuevo;
                        lista->ultimo=nuevo;
                }
                else {
			nuevo->nombre = nombre;
			nuevo->categoria = categoria;
			nuevo->ambito = ambito;
			nuevo->tipo = busca(lista,tipo);
		
			nuevo->dir = dir;

		        nuevo->sig=NULL;
		        nuevo->ant=NULL;
		        lista->primero=nuevo;
		        lista->ultimo=nuevo;

		}
		lista->ultimo->tamano = tamano;
		lista->NumElem=lista->NumElem+1;
	    	return 1;
        }
        return 0;
}

// Devuelve la direccion de la entrada de la tabla de simbolos en caso de que exista. Si no, devuelve nulo.
PNodoLista busca(PLista lista, char *p){
        if ((lista->NumElem!=0) && (p!="")){
                PNodoLista aux=lista->primero;
                while (aux!=NULL){
                        if(strcmp (aux->nombre,p)==0) return aux;
                        else aux=aux->sig;
                }
	}
        return NULL;
}


PNodoLista busca2(PLista lista, char *p, int ambito){
        if ((lista->NumElem!=0) && (p!="")){
                PNodoLista aux=lista->primero;
                while (aux!=NULL){
			if (aux->ambito == ambito){
                        	if(strcmp (aux->nombre,p)==0)
					return aux;
			}
			else
				if ((aux-> ambito == 0) && (strcmp (aux->nombre,p)==0))
					return aux;
					
                        aux=aux->sig;
                }
	}
        return NULL;
}

// Devuelve el campo dirección de la variable pasada.
int direccion(PLista lista, char *p, int ambito){
	PNodoLista local = busca2 (lista,p,ambito);
	if (local != NULL) return local-> dir;
	else return 0;	
}

// Devuelve el tamaño del tipo de la variable pasada.
int tipovar(PLista lista, char *p, int ambito){
	PNodoLista local = busca2(lista,p,ambito);
	if (local != NULL) {
		PNodoLista aux = local -> tipo;
		return aux -> tamano;
	}
	else return 0;
} 

// Devuelve el tipo de la variable pasada.
char* tipovar2(PLista lista, char *p, int ambito){
	PNodoLista local;
	if (ambito == -1)
		local = busca(lista,p);
	else 
		local = busca2(lista,p,ambito);
	if (local != NULL) {
		PNodoLista aux = local -> tipo;
		if (aux) return aux -> nombre;
		else return local->nombre;
		
	}
	else return NULL;
} 


// Devuelve el tamaño de los parametros de una funcion
int tam_par(PLista lista, char * funcion) {
	PNodoLista aux = busca(lista,funcion);
	if (aux!=NULL)
		return (aux->tamano * 4) + 8; // +8 para el enlace estatico y la etiq.retorno
	else return 0;
}

// Devuelve el nº de argumentos de una función
int nargfun(PLista lista, char *id){
	PNodoLista aux = busca(lista,id);
	if (aux!= NULL)
		return aux -> tamano;
	else return -1;
}


// Devuelve el tipo de los argumentos de una función
char* tipoargfun(PLista lista, char* id, int n){
	int local = nargfun(lista,id);
	PNodoLista aux = busca(lista,id);
	int i, max;
	if (local != -1){
		if (local == 0)
			return NULL;
		max = local - n;
		for (i=0;i < max;i++){
			aux= aux -> ant;
		}
		return aux -> tipo -> nombre;
	}
	else
		return NULL;
}

// Devuelve el campo dir de los argumentos de una función
int dirargfun(PLista lista, char* id, int n){
	int local = nargfun(lista,id);
	PNodoLista aux = busca(lista,id);
	int i, max;
	if (local != -1){
		max = local - n;
		for (i=0;i < max;i++){
			aux= aux -> ant;
		}
		return aux -> dir;
	}
	else
		return -1;
}

// Devuelve la etiqueta de una función
int etiqueta(PLista lista, char* funcion){
	PNodoLista aux = busca(lista,funcion);
	if (aux != NULL)
		return aux-> dir;
	else
		return 0;
}

// Devuelve el ámbito de una función
int devambito(PLista lista, char* funcion){
	PNodoLista aux = busca(lista,funcion);
	if (aux != NULL)
		return aux-> ambito;
	else
		return 0;
}

char* categoria(PLista lista, char* id, int ambito){
	PNodoLista local = busca2 (lista,id,ambito);
	if (local != NULL) return local-> categoria;
	else return NULL;	
}


void destruye(PLista lista){
        if (lista->NumElem!=0){
                PNodoLista aux=lista->primero;
                while (aux->sig!=NULL){
                        aux=aux->sig;
                        free(lista->primero);
                        lista->primero=aux;
                        lista->NumElem=lista->NumElem-1;
                }
                free(lista->ultimo);
                lista->NumElem=lista->NumElem-1;
        }
}

void imprimeTS(PLista lista){
	 printf("\n\n---Tabla de símbolos---\n");
	 if (lista->NumElem!=0){
                PNodoLista aux=lista->primero;
		char *name;
		int contador = 0;
                while (aux->sig!=NULL){
			name = tipovar2(lista,aux->nombre,aux->ambito);
			
                        printf("Entrada %d: nombre = %s, categoria = %s, ambito = %d, tipo = %s, tamano = %d, dir = 0x%x\n", 
					contador, aux->nombre, aux->categoria, aux->ambito, name, aux->tamano, aux->dir);
			aux=aux->sig;
			contador+=1;
                }
		printf("Entrada %d: nombre = %s, categoria = %s, ambito = %d, tipo = %s, tamano = %d, dir = 0x%x\n\n\n\n", 
					contador, aux->nombre, aux->categoria, aux->ambito, name, aux->tamano, aux->dir);
        }
}

