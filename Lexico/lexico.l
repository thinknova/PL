/****************************************************************/
/*	SOFTWARE NAME: Analizador léxico							*/
/*	SOFTWARE RELEASE: 1.0										*/
/*	SOFTWARE LICENSE: GNU General Public License				*/
/* 	DEVELOPERS: Roberto Marco Sánchez y Pablo E. Ojeda Vasco	*/
/*	CONTENT:													*/
/*		Estructura de fichero para analizador léxico 			*/
/****************************************************************/

%{

#define BREAK 	1
#define CASE 	2
#define CHAR 	3
#define CONST 	4
#define DEFAULT 5
#define DO 		6
#define DOUBLE 	7
#define ELSE 	8
#define FLOAT 	9
#define FOR 	10
#define GOTO 	11
#define IF 		12
#define INT 	13
#define RETURN 	14
#define STRUCT 	15
#define SWITCH 	16
#define TYPEDEF 17
#define UNION 	18
#define VOID 	19
#define WHILE 	20

#define LCORCH 	21
#define RCORCH 	22
#define LPARENT 23
#define RPARENT 24
#define LKEY 	25
#define RKEY 	26
#define POINT	27
#define INC 	28
#define DEC 	29
#define ANDOP 	30
#define MULTOP 	31
#define ADDOP 	32
#define MINUSOP 33
#define VIRGUOP 34
#define NOTOP 	35
#define DIVOP 	36
#define MODOP 	37
#define LDESP 	38
#define RDESP 	39
#define LOWOP 	40
#define GREATOP 41
#define LOWEQOP 42
#define GREATEQOP 43
#define EQUOP 	44
#define NOTEQOP 45
#define ELEVADOOP 46
#define OROP 	47
#define AND 	48
#define OR 		49
#define TWOPOINT 50
#define SEMICOLON 51
#define ASIGOP 	52
#define PRODASIGOP 53
#define DIVASIGOP 54
#define MODASIGOP 55
#define SUMASIGOP 56
#define RESASIGOP 57
#define COLON 	58

#define SCANF	59
#define PRINTF	60

#define IDENT		70
#define NUMERO 		71
#define CARACTER 	72
#define STRING 		73
#define STRING_C 	74

int numlin=1;
void error(char*);

%}

letra [a-zA-Z_]
digito0 [0-9]
digito [1-9]
letdig {letra}|{digito0}
hexa [a-fA-F0-9]
oct [0-7]

comentario [^\" \' \\ \n] 																		
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
printf {return PRINTF;}
scanf {return SCANF;}

" " {}
{comentario1}|{comentario2} {}

{letra}{letdig}* {return IDENT;}
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
. {error("Carácter no permitido");}
<<EOF>> {return 0;}

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

