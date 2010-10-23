/****************************************************************/
/*	SOFTWARE NAME: Analizador léxico							*/
/*	SOFTWARE RELEASE: 1.0										*/
/*	SOFTWARE LICENSE: GNU General Public License				*/
/* 	DEVELOPERS: Roberto Marco Sánchez y Pablo E. Ojeda Vasco	*/
/*	CONTENT:													*/
/*		Estructura de fichero para analizador léxico 			*/
/****************************************************************/

%{
#include "sintactico_sin_semantica.tab.h"
#include <string.h>

int numlin=1;

%}

letra [a-zA-Z_]
digito0 [0-9]
digito [1-9]
letdig {letra}|{digito0}
hexa [a-fA-F0-9]
oct [0-7]

comentario [^\" \' \\ \n] 	
comentario_1 []																	
comentario_2 [^\n]

decimal {digito}{digito0}*
octal 0{oct}*
hexadecimal [0X|0x]{hexa}{hexa}*
integer_constant {decimal}|{octal}|{hexadecimal}

decimal_floating1 ({digito0}{digito0}*)?"."{digito0}{digito0}*([Ee]([+-])?{digito0}{digito0}*)?
decimal_floating2 {digito0}{digito0}*"."({digito0}{digito0}*)?([Ee]([+-])?{digito0}{digito0}*)?
decimal_floating3 {digito0}{digito0}*([Ee]([+-])?{digito0}{digito0}*)?

comentario1 "/*"{comentario_2}*"*/"
comentario2 "//"{comentario_2}*

character_constant \'({comentario}|{esq})\'

simple_escape_sequence \' | \" | \? | \\ | \a | \b | \f | \n | \r | \t | \v
octal_escape_sequence \{oct}({oct}{oct}?)?
hexadecimal_escape_sequence \x{hexa}{hexa}?
esq {simple_escape_sequence}|{octal_escape_sequence}|{hexadecimal_escape_sequence}|.

%%

break {return BREAK;}
case {return CASE;}
char {return CHAR;}
const {return CONST;}
default {return DEFAULT;}
do {return DO;}
double {return DOUBLE;}
else {return ELSE;}
float {return FLOAT;}
for {return FOR;}
goto {return GOTO;}
if {return IF;}
int {return INT;}
return {return RETURN;}
struct {return STRUCT;}
switch {return SWITCH;}
typedef {return TYPEDEF;}
union {return UNION;}
void {return VOID;}
while {return WHILE;} 

" " {}
{comentario1}|{comentario2} {}

{letra}{letdig}* {return IDENTIFICATOR;}
{integer_constant} {return NUMERO;}
{decimal_floating1}|{decimal_floating2}|{decimal_floating3} {return NUMERO;}

'{letra}' {return CARACTER;} 
\"{letra}{letdig}*\" {return STRING;}
\"(.)*\" {return STRING_C;}

"[" {return LCORCH;} 
"]" {return RCORCH;} 
"(" {return LPARENT;} 
")" {return RPARENT;} 
"{" {return LKEY;} 
"}" {return RKEY;} 

"." {return POINT;}
":" {return TWOPOINT;} 
";" {return SEMICOLON;}
"," {return COLON;}

"=" {return ASIGOP;} 
"*=" {return PRODASIGOP;} 
"/=" {return DIVASIGOP;} 
"%=" {return MODASIGOP;}
"+=" {return SUMASIGOP;}
"-=" {return RESASIGOP;}
"++" {return INC;} 
"--" {return DEC;}

"+" {return ADDOP;} 
"-" {return MINUSOP;}
"*" {return MULTOP;} 
"/" {return DIVOP;} 
"%" {return MODOP;} 
 
"&" {return ANDOP;} 
"|" {return OROP;}
"^" {return ELEVADOOP;}
"~" {return VIRGUOP;}
"<<" {return LDESP;}
">>" {return RDESP;}

"<" {return LOWOP;} 
">" {return GREATOP;}
"<=" {return LOWEQOP;} 
">=" {return GREATEQOP;}
"==" {return EQUOP;}
"!=" {return NOTEQOP;}

"&&" {return AND;}
"||" {return OR;}
"!" {return NOTOP;} 

\n {numlin++;}
\t {}
^#.* {}
. {yyerror("Carácter no permitido");}
<<EOF>> {return 0;}

%%
/**********************************************************
*  Innecesario, puesto que ya no es un programa independiente
int main(int argc, char** argv){
	int s;
	if(argc>1) yyin=fopen(argv[1],"r");
	do printf("%i \n", s=yylex()); while(s != 0);
	return 0;
}

void error(char* mens){
	printf("Error lexico en linea %i: %s\n",numlin,mens);
}

**********************************************************/