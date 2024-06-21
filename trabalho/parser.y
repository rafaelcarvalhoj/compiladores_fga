%{

#include <stdio.h>
#include <stdlib.h>

extern int yylex();
void yyerror(const char* s);

%}

%token PROGRAM
%token ID
%token NUMBER
%token ADD SUB MUL DIV ABS
%token EOL
%token DOT SEMICOLON L_PAREN R_PAREN ATTR
%%

program:
    | PROGRAM ID L_PAREN list_id R_PAREN SEMICOLON DOT { printf("program %s\n", $2); }
    ;

list_id:
    | ID (, ID)*
    ;



%%

int main(int arc, char **argv)
{
    yyparse();
    return 0;
}

void yyerror(const char* s) {
	fprintf(stderr, "Parse error: %s\n", s);
	exit(1);
}
