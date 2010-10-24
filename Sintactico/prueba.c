/*=========================================================================*/
// Batería de pruebas para analizador sintactico                                     
/*========================================================================*/

// Declaración global de tipos de variables y asignación
int i2=1, i1;						//Ojo con inicializar en declaración 						
double d1=1;
typedef int nuevo_entero;
// nuevo_entero j=2; Hasta que no se haga el semántico, no podrá ponerse

void expresiones (int param1, int param2) {
	int vectores1[4]; 				//Comprobación de inicialización de vectores
	vectores1[4] = {1, 2};
	param1=10;
	param2 = param1 + 2;			//Asignación simple tras suma
	param2 *= 8;					//Asignación con multiplicación
	param2 /= 1;					//Asignación con división
	param2 %= 2;					//Asignación con mod 
	param1++;						//Incremento
	param1--;						//Decremento
	
	int or1=1, or2=0;
	
	if (or1||or2)
	return;
}

/* programa principal */
int main()
{
  
  return 0;
}
