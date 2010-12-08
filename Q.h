/********************************************************************

Q.h v3.7.2 - 3.7.3 (c) 2002..2009 Jose Fortes Galvez

Fichero de encabezamiento para c�digo Q, lenguaje intermedio en
cu�druplas compilables en C.  Declara las macros y funciones que
conforman la "m�quina Q".

Este fichero NO se debe modificar.  Por el contrario, Qlib.h y Qlib.c
est�n dise�ados para ser modificados extendiendo as� la biblioteca de
rutinas del sistema.

Descripci�n 
-----------

(V�ase primero el manual de usuario Qman.txt)

Se utiliza un modelo de m�quina que incluye (implementadas en el heap
con realloc) una zona est�tica virtual y una pila virtual para marcos
de pila gestionada por el propio c�digo.  En esta pila virtual se
pueden almacenar y gestionar todo tipo de datos y estructuras,
incluyendo direcciones virtuales de datos y de c�digo.  Igualmente
apoyado en realloc se implementa un heap virtual (con una gesti�n
inicialmente trivial en Qlib.c).  Estas implementaciones permiten que
todas las direcciones virtuales se implementen como enteros, en
realidad �ndices en las correspondientes estructuras de nombre ze_pila
y heap.

Todas las cantidades referidas a tama�o o posici�n de memoria virtual
en el c�digo generado son en bytes, esto es, una asignaci�n de b
indica b bytes. 

El c�digo C obtenido de la expansi�n de las macros correspondientes a
las instrucciones Q se encuentra dentro de un switch cuyos valores
enteros de los distintos case nos sirven de direcciones de salto.

********************************************************************/

#ifndef DEP
#define DEP 0
#endif

#ifndef STDQ
#define STDQ stdout
#endif

// necesario para C++ (GCC g++)
#ifdef USEextern
#define EXTERN extern 
#else
#define EXTERN
#endif 

#include <stdlib.h>
#include <stdio.h>
#include <stddef.h>  // NULL
#include <signal.h>
#include <string.h>
#include <setjmp.h>

#include "Qlib.h"                                                                         

// Etiquetas "del sistema" 
// externas (s�lo los n�meros forman parte de la definici�n de Q)
#define INI   0	        // inicia el codigo del programa de usuario
#define BP   -1         // breakpoint (si en modo interactivo) 
#define FIN  -2         // finaliza ejecucion: sale con exit(R0);
#define ABO  -3         // aborta ejecucion: sale con exit(1);
// internas
#define NOE COM         // etiqueta inv�lida 
#define COM  -4         // verdadero comienzo (interno) de ejecucion (si compilado) 
#define DEF  -5         // etiqueta del default 
#define LIB  -10        // primera etiqueta admisible en Qlib

#define PTR unsigned int        // que tipo corresponde a puntero
#define sPTR int                // puntero "con signo"
#define UC unsigned char        // ud. direccionamiento = byte (sin signo)

// tipos
#define Pt PTR 
#define Ut UC           
#define St short        
#define It int          
#define Jt long int     
#define Ft float        
#define Dt double       
#define Et long double  
#

// tama�os de tipos
// (nota: al parecer sizeof devuelve unsigned int, que impide -4*IS<0)
#define PS (int)sizeof(Pt) 
#define US (int)sizeof(Ut) // 1 byte ANSI C  
#define SS (int)sizeof(St) // 2 bytes gcc i386 
#define IS (int)sizeof(It) // 4 bytes gcc i386
#define JS (int)sizeof(Jt) // 4 bytes gcc i386
#define FS (int)sizeof(Ft) // 4 bytes gcc i386
#define DS (int)sizeof(Dt) // 8 bytes gcc i386
#define ES (int)sizeof(Et) // 12 bytes gcc i386
#
#define AS 4               // tama�o en bytes de alineamiento m�ximo

/************ ARQUITECTURA OBJETO ************************/
#define tR It
#define tRR Dt

#define clR I
#define clRR D

#define NR 8
EXTERN tR R[NR];               // registros enteros del procesador 
#define R(i) R[(i)]            // en caso de que sean indexables
#define R0 R[0]
#define R1 R[1]
#define R2 R[2]
#define R3 R[3]
#define R4 R[4]
#define R5 R[5]
#define R6 R[6]
#define R7 R[7]
#define NRR 4
EXTERN tRR RR[NRR];            // registros coma flotante del procesador 
#define RR(i) RR[(i)]          // en caso de que sean indexables
#define RR0 RR[0]
#define RR1 RR[1]
#define RR2 RR[2]
#define RR3 RR[3]

// zonas virtuales de memoria
EXTERN UC * ze_pila;              // (fondo de) zona estatica m�s pila
EXTERN UC * heap;                 // (fondo de) heap

// Definici�n de direcciones base virtuales (direcciones num�ricamete
// mayores, m�ltiplos de AS) de las zonas de memoria, todas las cuales
// crecen hacia direcciones num�ricamente decrecientes.  La pila se
// situar� autom�ticamente tras la direcci�n inferior de la zona
// est�tica.  Se ha de verificar H >> Z >> 0 

// #define Z 0x00100000         // base+1 de la zona estatica (1 MB m�x)
// #define Z 0x00112000         // base+1 de la zona estatica (1096 KB m�x)
#ifndef Z
#define Z 0x00012000            // base+1 de la zona estatica (72 KB m�x)
#endif
// #define P TE                 // de la pila (implicita)
// #define H 0x00200000         // base+1 del heap (1 MB m�x); ha de verificar H>>Z
// #define H 0x00224000         // base+1 del heap (1096 KB m�x); ha de verificar H>>Z 
#ifndef H
#define H 0x00024000            // base+1 del heap (72 KB m�x); ha de verificar H>>Z
#endif
                                
#define CP R7                   // direcc. (virtual**2) de la cima de ze_pila
EXTERN Pt CPX;                  // direcc. virt. de la �lt. pos. realmente asignada
EXTERN Pt HP;                   // direcc, virt. de la �lt. pos. realmente asignada
// !!!! en el codigo se presupone que se usa b multiplo de AS bytes !!!
// Dado que realloc crece hacia direcciones numericamente superiores,
// asi ha de hacerlo la pila, pues si no, cambiariamos el "endian"

// !!!! al ubicar datos tener en cuenta los alineamientos requeridos !!
#define MAS(x) ((x)/AS)*AS  // convierte a multiplo de AS hacia dir. num�r. inferiores
// MAS(x) (((x)-AS+1)/AS)*AS  /* id. superiores
// extiende efectivamente la zona est�tica hasta la posici�n MAS(e) (desde Z+1)
unsigned char u_wall; // evita aviso -Wall
#define ZE(e) if ((Pt)(e)<CP) {CP=(Pt)MAS(e); u_wall=U((Pt)MAS(e)); /* fuerza asignaci�n */ }

// tiene el mismo efecto que el NC antiguo (b>0 aumenta tama�o pila: _de_crementa CP
#define nvo_NC(b) CP-=(b);      // si antes NC(+n), ahora R7=R7-n y acceso ulterior

#define BSX 0x10000 // 64 KB: tama�o m�ximo de bloque a asignar de 1 vez

//PTR tmp;

#define BS  0x00100 // 256 B: unidad de asignaci�n de pila
#define DMS (d+s) // se leer� o escribir� en dir. virt. d..DMS-1

#define QF                                                                           \
                                                                                     \
void errxit(int cod) {                                                               \
char *mens[]=                                                                        \
 {/* 0 */   "" /* no es apropiado 0 como c�digo de longjmp */                        \
  /* 1 */ , "Intento de liberar en heap un tramo de tama�o superior al heap"         \
  /* 2 */ , "Acceso a memoria fuera de l�mites"                                      \
  /* 3 */ , "Bloque de memoria a asignar demasiado grande"                           \
  /* 4 */ , "Excedido el tama�o m�ximo de zona est�tica m�s pila, o de heap"         \
  /* 5 */ , "El sistema no suministra m�s memoria"                                   \
  /* 6 */ , "Asignaci�n est�tica de memoria en direcci�n no inferior a Z"            \
  /* 7 */ , "END alcanzado"                                                          \
  /* 8 */ , "ENDLIB alcanzado"                                                       \
  /* 9 */ , "Salto a etiqueta inexistente"                                           \
 };                                                                                  \
 fflush(stdout);                                                                     \
 fprintf(stderr,"\nQ.h: %s (error %i)\n",mens[cod],cod);                             \
 longjmp(env,cod); /* salta a manejador de excepci�n */                              \
 /* inalcanzalbe */ printf("\nQ.h: error interno\n"); raise(SIGABRT);                \
}                                                                                    \
                                                                                     \
/* Aumenta el tama�o del heap en b bytes (o lo decrementa si b<0)                    \
Modifica (y devuelve) el valor de HP en consecuencia */                              \
void NH(tR b) {                                                                      \
  Pt nvoHP;                                                                          \
  if ((b)>BSX) errxit(3); /* bloque a asignar demasiado grande */                    \
  else if ((nvoHP=HP-(b))>H) errxit(1); /* intento de liberar m�s heap del que hay */\
  else if (nvoHP<Z) errxit(4); /* excedido tama�o m�ximo heap */                     \
  else if (!(heap = (UC*)realloc(heap, H-nvoHP))) errxit(5); /* error de realloc */  \
  HP=nvoHP;                                                                          \
}                                                                                    \
                                                                                     \
UC *DIR(PTR d, UC s) {                                                               \
  /* Covierte direccion virtual d en z.e., pila o heap en direccion                  \
   real.  Invertimos el orden de direcciones de memoria, para que pila               \
   --y por tanto heap-- crezcan (virtualmente) hacia direcciones                     \
   num�ricamente inferiores, en tanto que realloc, y las operaciones                 \
   de escritura/lectura multibyte (p.e. int de 4 bytes) lo hacen hacia               \
   direcciones num�ricamente superiores.  No podemos hacer que el heap               \
   crezca en sentido inverso, pues entonces habr�an endians distintos                \
   en pila y heap.  La m�quina virtual por tanto es big endian, y las                \
   strings se almacenan hacia direc. virt. superiores --pero realmente               \
   hacia direc. inferiores por lo que hay que reordenarlas                           \
   temporalmente para e/s con libC. */                                               \
  Pt bloq /* tama�o de la extensi�n */ , nvoCPX;                                     \
  if (d<=Z-s) /* evita DMS>=0 siendo (signed)d<0 */                                  \
    if (d>=CPX) return ze_pila+Z-DMS; /* incluso si >=CP (error del pgm usuario) */  \
    else {                                                                           \
      nvoCPX=CPX-(bloq=(CPX-CP+BS-1)/BS*BS); /* calculamos seg�n CP, �no seg�n d! */ \
      if (bloq>BSX) errxit(3); /* bloque a asignar demasiado grande */               \
      else if (nvoCPX>Z) errxit(4); /* (mejor que >=) excedido tama�o m�ximo pila */ \
      else if (d>=nvoCPX)                                                            \
	if (!(ze_pila = (UC *)realloc(ze_pila, Z-nvoCPX)))                           \
	  errxit(5); /* error de realloc */                                          \
	else {CPX=nvoCPX; return ze_pila+Z-DMS;}                                     \
      else errxit(2); /* acceso por debajo de zona asignada a la pila */             \
    }                                                                                \
  else if (d<=H-s && d>=HP) return heap+H-DMS;                                       \
  else errxit(2); /* acceso superior a la pila fuera de zona asignada al heap */     \
  return 0; /* evita aviso si -Wall */                                               \
}                                                                                    \
                                                                                     \
/* carga una string (formato C: '\0' marca final) */                                 \
void STR(Pt p, const char *r) {	                                                     \
    if (p+strlen(r)+1>Z) errxit(6); /* la zona est�tica ha de ser inferior a Z */    \
    ZE(p); 			                                                     \
    do U(p++)=*r; while (*r++);                                                      \
  }                                                                                  \

// Acceso a direccion virtual d de memoria, segun tipo de dato.  Nota:
// es necesario escribirlo asi para poder aplicar el operador &,
// p.e. &P(d), (de forma que & y * se anulen mutuamente, segun
// definicion de & en norma de C); pues si se se escribiera
// (Pt)*DIR(d,PS), a pesar de que el valor es evidentemente el mismo,
// no funcionaria &P(d).
#define P(d) *(Pt*)DIR(d,PS)
#define U(d) *(Ut*)DIR(d,US)
#define S(d) *(St*)DIR(d,SS)
#define I(d) *(It*)DIR(d,IS)
#define J(d) *(Jt*)DIR(d,JS)
#define F(d) *(Ft*)DIR(d,FS)
#define D(d) *(Dt*)DIR(d,DS)
#define E(d) *(Et*)DIR(d,ES)

// Asignaciones de memoria y constantes estaticos y strings a cargar

// simplemente asigna memoria en zona est�tica desde p (hacia y hasta
// Z) supuestamente para b bytes en p..p+b-1
#define MEM(p,b) 								 \
  do { if (DEP>=10) printf(">>MEM(%i,%i)\n",(int)p,(int)b); 			 	 \
  if ((p)+(b)>Z) errxit(6); /* la zona est�tica ha de ser inferior a Z */        \
  ZE(p); } while (0)	 							 \

// asigna y rellena con valor fijo (normalmente 0)
#define FIL(p,b,v) 							    \
  do {int i;                                                                \
    if (DEP>=10) printf(">>FIL(%i,%i,%i)\n",(int)p,(int)b,(int)v); 			    \
    if ((p)+(b)>Z) errxit(6); /* la zona est�tica ha de ser inferior a Z */ \
    ZE(p); 								    \
    for (i=0;i<(b);i+=US) U((p)+i)=(v);                                     \
  } while (0)			                                            \

// carga una constante num�rica
#define DAT(p,c,v)   								 \
	do {if (DEP>=10) printf(">>DAT(%i,%s,%i)\n",(int)p,# c,(int)v); 			 \
  	if ((p)+c##S>Z) errxit(6); /* la zona est�tica ha de ser inferior a Z */ \
	ZE(p); 									 \
	c(p)=v; /* carga a v */ } while (0)					 \

// etiquetas y saltos
EXTERN int etiq;                    // etiqueta adonde se va a saltar
    
#define L case                      // confunde menos */    
#define T(e) (e)                    // facilita al montador localizar patron "T(" 
#define OLDGT(e) if ((e)!=BP) {     /* "go to" */               \
                etiq = (e);                                     \
                break;                                          \
              }                                                 

#define GT(e) do if ((e)!=BP) {                                 \
                etiq = (e);         /* "go to" */               \
                goto GT_switch;                                 \
               }                                                \
               while(0) /* al usar do-while consigo que GT() sea una
                           instrucci�n y necesite ";" 
                        */

#define IF(e) if(e)                 // si queremos usar mayusculas

EXTERN jmp_buf env;

#define BEGIN                                                                            \
QF                                                                                       \
main() {                                                                                 \
/*  register int tmp;  */                                                                \
  int i, cod;  /* aux */                                                                 \
  enum {carg, ejec} est=carg;		                                                 \
  if (cod=setjmp(env)) {                                                                 \
    if (cod==ABO) printf("\nEjecuci�n abortada por salto a %i\n",ABO);                   \
    raise(SIGABRT);  /*exit(cod);*/                                                      \
  }                                                                                      \
  ze_pila=NULL;                                                                          \
  heap=NULL;                                                                             \
  CPX=Z;				                                                 \
  HP=H;                                                                                  \
  etiq=COM;                                                                              \
  do {                                                                                   \
    if (DEP) printf("etiq==%i\n",etiq);                                                  \
GT_switch:                                                                               \
    switch (etiq)                                                                        \
      {                                                                                  \
/* una etiqueta aqui evita aviso de codigo inaccesible si a BEGIN sigue STAT(0) */       \
L COM:   CP = Z;                          /* arranca con pila vac�a */                   \
         GT(LLL-1);                       /* "carga" zona est�tica */                    \

#ifndef LLL
#define LLL -999  // Valor por defecto de la ultima etiqueta utilizable en Qlib
#endif

// parejas de declaraciones e instrucciones 
#define STAT(i)                                                           \
         GT(LLL-2*(i)-2);  /* salta a la primera instruccion de CODE(i) */\
L LLL-2*(i)-1:             /* primera declaracion de STAT(i) */           \

#define CODE(i)                                                               \
         GT(LLL-2*(i+1)-1);  /* salta a la primera declaracion de STAT(i+1) */\
L LLL-2*(i)-2:               /* primera instruccion de CODE(i) */             \

#define END                               /* el ultimo trozo de codigo "caeria" aqui */  \
	 if (est==carg) GT(DEF);  		                                         \
	 errxit(7); 								         \
L ABO:   longjmp(env,-3);                                                                \
L FIN:   exit(R0);                        /* lo normal es GT(FIN); */                    \
/* comienzo de ejecuci�n: inicializaciones e invocacion c�digo de usuario */             \
L DEF:                                                                                   \
default:                    							         \
	 if (est==carg) {							         \
	   est=ejec;   			  /* pasamos a ejecutar */		         \
           GT(INI);                       /* inicia ejecucion del compilado */           \
	 } else if (etiq >= 0 || etiq < LLL)  errxit(9);                                 \
         else {                                                                          \
	   Qlib(etiq);                                                                   \
	   GT(etiq);                                                                     \
	 }                                                                               \
      }                                                                                  \
  } while (1); /* puesto que los saltos son todos con GT(), que va a GT_switch,          \
                ya el while es in�til */                                                 \
}                                                                                        \

#define BEGINLIB                                      \
extern void NH(tR b); /* evita aviso GCC (C++) */     \
extern UC *DIR(PTR d, UC s); /* idem */               \
extern void errxit(int cod); /* idem */               \
int constZ=Z, constH=H, constLLL=LLL;                 \
void Qlib(int etilib) {                               \
  switch (etilib)                                     \
    {                                                 \
       default: errxit(9); /* etiq. <0 inexistente */ \

#define ENDLIB                                                  \
    }                                                           \
    errxit(8); /* ENDLIB alcanzado; ejecuci�n terminada */      \
GT_switch:  return;                                             \
}                                                               \

// final de Q.h
