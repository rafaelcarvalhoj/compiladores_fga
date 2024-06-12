%{

#include<stdio.h>
#include<stdlib.h>

extern int yylex();
void yyerror(const char* s);

%}

%token NUMBER
%token ADD SUB MUL DIV ABS
%token EOL

%%

calclist: 
    | calclist exp EOL { printf("= %d\n", $1); }
    ;

exp: factor
    | exp ADD factor { $$ = $1 + $3; }
    | exp SUB factor { $$ = $1 + $3; }
    ;

factor: term
      | factor MUL term { $$ = $1 * $3; }
      | factor DIV term { $$ = $1 / $3; }
      ;

term: NUMBER
    | ABS term { $$ = $2 >= 0? $2 : - $2; }
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
