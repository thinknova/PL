/*=========================================================================*/
// Bater�a de pruebas para analizador sintactico                                     
/*========================================================================*/

// Declaraci�n global de tipos de variables y asignaci�n
int i2=1, i1;						//Ojo con inicializar en declaraci�n 						
double d1=1;
typedef int nuevo_entero;
// nuevo_entero j=2; Hasta que no se haga el sem�ntico, no podr� ponerse

void expresiones (int param1, int param2) {
	int vectores1[4]; 				//Comprobaci�n de inicializaci�n de vectores
	vectores1[4] = {1, 2};
	param1=10;
	param2 = param1 + 2;			//Asignaci�n simple tras suma
	param2 *= 8;					//Asignaci�n con multiplicaci�n
	param2 /= 1;					//Asignaci�n con divisi�n
	param2 %= 2;					//Asignaci�n con mod 
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
