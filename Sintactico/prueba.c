/*=========================================================================*/
// Bateria de pruebas para analizador sintactico                                     
/*========================================================================*/

// Declaracion global de tipos de variables y asignacion
int i2=1, i1;						//Ojo con inicializar en declaracion 						
double d1=1;
typedef int nuevo_entero;
// nuevo_entero j=2; Hasta que no se haga el semantico, no podra ponerse

// void expresion (param1, param2) = función con parámetros
void expresiones (int param1, int param2) {
	//Declaracion de variables
	//	La declaración tiene que ser al inicio de la función
	char *str1, str2;
	int or1=1, or2=2, or3;			//Atentos, que int or3, or1=1, or2=2 falla
	int or2=0;
	int and1=1;
	int vectores1[4]; 				//Comprobacion de inicializacion de vectores
	
	//vectores1[4] = {1, 2};		//Problema con vectores
	str1="Prueba1";					
	param1=10;
	param2 = param1 + 2;			//Asignacion simple tras suma
	param2 *= 8;					//Asignacion con multiplicaciÛn
	param2 /= 1;					//Asignacion con divisiÛn
	param2 %= 2;					//Asignacion con mod 
	param1++;						//Incremento
	param1--;						//Decremento
		
	if (or1 || or2) { or1=2*10; }	//Expresión or
	if (and1 && or1) { and1 = or2/5; } //Expresión and
	if (param1 != param2 ) { 		//Expresión no igual
		and1 = or1 - or2 + 3 * 2;	//Conjunto de operadores
		and1++; 				
	}
	if ((param1 <= 10) || (param2 >= 20) ) {
		--param1; 
	}
	return;
}

// int main = función sin parámetros
int main()
{
	int x=1, y=2, z;
	
	// Comprobación estructura do-while
	do {
		x = 20 * y + 10;
		if (x > 20) { z=5;}
	} while (z!=5);
	
	// Comprobación estructura switch
	// Atención con switch que cada uno de los case va entre llaves
 	switch(x) {
		case 1:
			{
				z=20*10;
				if (z>20) { y=2; }
				break;
			}					
		case 2:
			{
				z=30;
				break;
			}			
		default: 
			{
				if (z == 3) { y += 10; }
			}
	}
	
	// Comprobación estructura while
	while (z <= 10) {
		// No se puede hacer llamamiento a funciones. Ejemplo: expresiones(x,y);
		z--;
	}	
	
	// Comprobación estructura for
	for (x=0; x<20; x++) {
		if (x != 18) {
			z= y << x;
		}
	}
  return 0;
}