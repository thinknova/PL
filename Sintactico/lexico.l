/* ======================================== */
/* ---------  ANALIZADOR LEXICO  ---------- */
/* -------  =====================  -------- */                      
/* ------  * Roberto Marco Sánchez  ------- */
/* ------  * Pablo E. Ojeda Vasco   ------- */
/* ======================================== */

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
#define ANDOP 	31
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
#define PROD_ASIG_OP 53
#define DIV_ASIG_OP 54
#define MOD_ASIG_OP 55
#define SUM_ASIG_OP 56
#define RES_ASIG_OP 57
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

comentario1 "/*"{comentario}*"*/"
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

{letra}{letdig}* {//yylval.identificador=strdup(yytext);
               return IDENT;}

{integer_constant} {//yylval.valor_double=atoi(yytext);
                    return NUMERO;}

{decimal_floating1}|{decimal_floating2}|{decimal_floating3} {//yylval.valor_double=atof(yytext);
                                                             return NUMERO;}

'{letra}' {//yylval.caracter = yytext[1]; //'a' --> yytext[1] -> a
        return CARACTER;}



\"{letra}{letdig}*\" {//yylval.ristra=strdup(yytext);
                   return STRING;}

\"(.)*\" {//yylval.ristra=strdup(yytext);
                   return STRING_C;}

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
"~" {return VIRGUOP;}
"!" {return NOTOP;}

"=" {return ASIGOP;} 
"++" {return INC;} 
"--" {return DEC;} 
"*=" {return PROD_ASIG_OP;} 
"/=" {return DIV_ASIG_OP;} 
"%=" {return MOD_ASIG_OP;}
"+=" {return SUM_ASIG_OP;}
"-=" {return RES_ASIG_OP;}

"+" {return ADDOP;} 
"-" {return MINUSOP;}
"*" {return MULTOP;} 
"/" {return DIVOP;} 
"%" {return MODOP;} 
"^" {return ELEVADOOP;}
 
"<<" {return LDESP;}
">>" {return RDESP;} 
"&" {return ANDOP;} 
"|" {return OROP;}

"<" {return LOWOP;} 
">" {return GREATOP;}
"<=" {return LOWEQOP;} 
">=" {return GREATEQOP;}
"==" {return EQUOP;}
"!=" {return NOTEQOP;}

"&&" {return AND;}
"||" {return OR;} 

\n {numlin++;}
\t {}
^#.* {}
. {error("Carácter no permitido");}
<<EOF>> {return 0;}
%%

int main(int argc, char** argv){
	int s;
	if(argc>1) yyin=fopen(argv[1],"r");
	do printf("%i ", s=yylex()); while(s != 0);
	return 0;
}

void error(char* mens){
	printf("Error lexico en linea %i: %s\n",numlin,mens);
}
