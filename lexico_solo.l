/*
 *	-------------------------------------------
 *	DESARROLLADO POR:
 *		Pablo Ojeda Vasco
 *		Roberto Marco Sánchez
 *	LICENCIA: GNU General Public License
 * 	TITULO: Compilador Lex/Flex para lenguaje C
 *  -------------------------------------------
 *  Analizador Léxico (lexico.l)
 * 		Nota: De momento no admitimos procedimientos, sólo funciones	
 *
 */

%{

#define MAIN 	1
#define GLOBAL 	2
#define CONST 	3
#define IDENT 	4

#define INT 	5
#define FLOAT 	6
#define CHAR 	7
#define STRING 	8

#define TIPO_INT 9
#define TIPO_FLOAT 10
#define TIPO_CHAR 11

#define IF 		12
#define ELSE 	13
#define FOR 	14
#define SWITCH 	15
#define CASE 	16
#define BREAK 	17
#define DEFAULT 18
#define WHILE 	19
#define RETURN 	20

#define NOT 	21
#define PRINTF 	22
#define SCANF 	23

int numlin=1;
void error(char*);

%}

letra [a-zA-Z_]
digito0 [0-9]
digito [1-9]
letdig {letra}|{digito0}

comentario_2 [^\" \' \\ \n]																	
comentario [^\n]
comentario1 "/*"{comentario}*"*/"
comentario2 "//"{comentario}*

decimal {digito}{digito0}*
integer {decimal}

decimal_floating1 ({digito0}{digito0}*)?"."{digito0}{digito0}*([Ee]([+-])?{digito0}{digito0}*)?
decimal_floating2 {digito0}{digito0}*"."({digito0}{digito0}*)?([Ee]([+-])?{digito0}{digito0}*)?
decimal_floating3 {digito0}{digito0}*([Ee]([+-])?{digito0}{digito0}*)?

separadores [(){}'\[''\]';,:]
oparitmetico ['+''\-''*''/']
oprelacional [<>]
asignacion [=]

%%

main {return MAIN;}
return {return RETURN;}

if {return IF;}
else {return ELSE;}
for {return FOR;}
while {return WHILE;} 
switch {return SWITCH;}
case {return CASE;}
default {return DEFAULT;}
break {return BREAK;}

int {return TIPO_INT;}
float {return TIPO_FLOAT;}
char {return TIPO_CHAR;}
const {return CONST;}
global {return GLOBAL;}

printf {return PRINTF;}
scanf {return SCANF;}

" " {}
{comentario1}|{comentario2} {}

{letra}{letdig}* {return IDENT;}
{integer} {return INT;}
{decimal_floating1}|{decimal_floating2}|{decimal_floating3} {return FLOAT;}
'{letra}' {return CHAR;} 
\"{letra}{letdig}*\" {return STRING;}

"!=" {return NOT;}
\n {numlin++;}
\t {}
^#.* {}
. {error("Carácter no permitido");}

%%

int main(int argc, char** argv){
	int s;
	if(argc>1) yyin=fopen(argv[1],"r");
	do printf("%i \n", s=yylex()); while(s != 0);
	return 0;
}

void error(char* mens){
	printf("Error lexico en linea %i: %s\n",numlin,mens);
}
