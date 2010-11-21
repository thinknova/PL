/*
 *	-------------------------------------------
 *	DESARROLLADO POR:
 *		Pablo Ojeda Vasco
 *		Roberto Marco Sánchez
 *	LICENCIA: GNU General Public License
 * 	TITULO: Compilador Lex/Flex para lenguaje C
 *  -------------------------------------------
 *  Analizador Léxico (lexico.l)
 *
 */
/****************************************************************
	De momento no admitimos procedimientos, sólo funciones	
*****************************************************************/
%{
#include "sintactico.tab.h"
#include <string.h>

int numlin=1;

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

"main" {return MAIN;}
return {return RETURN;}

if {return IF;}
else {return ELSE;}
for {return FOR;}
while {return WHILE;} 
switch {return SWITCH;}
case {return CASE;}
default {return DEFAULT;}
break {return BREAK;}

"int" {yylval.ristra=strdup(yytext); return TIPO_INT;}
float {yylval.ristra=strdup(yytext); return TIPO_FLOAT;}
char {yylval.ristra=strdup(yytext); return TIPO_CHAR;}
const {return CONST;}
"global" {return GLOBAL;}

printf {return PRINTF;}
scanf {return SCANF;}

" " {}
{comentario1}|{comentario2} {}

{letra}{letdig}* {yylval.ristra=strdup(yytext); return IDENT;}
{integer} {yylval.ristra=strdup(yytext); return INT;}
{decimal_floating1}|{decimal_floating2}|{decimal_floating3} {yylval.ristra=strdup(yytext); return FLOAT;}
'{letra}' {yylval.ristra=yytext[1]; return CHAR;} 
\"{letra}{letdig}*\" {yylval.ristra=strdup(yytext); return STRING;}

"[" {return LCORCH;} 
"]" {return RCORCH;} 
"(" {return LPARENT;} 
")" {return RPARENT;} 
"{" {return LKEY;} 
"}" {return RKEY;} 

":" {return TWOPOINT;} 
";" {return SEMICOLON;}
"," {return COLON;}

"=" {return ASIGOP;} 

"+" {return ADDOP;} 
"-" {return MINUSOP;}
"*" {return MULTOP;} 
"/" {return DIVOP;} 

"<" {return LOWOP;} 
">" {return GREATOP;}
"==" {return EQUOP;}
"!=" {return NOTEQOP;}

\n {numlin++;}
\t {}
^#.* {}
. {yyerror("Carácter no permitido");}

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