%option noyywrap

%{
    #include <stdio.h>
    #include "calc.tab.h"
%}

%%
"+"     { return ADD; }
"-"     { return SUB; }
"*"     { return MUL; }
"/"     { return DIV; }
"|"     { return ABS; }
[0-9]+  { yylval = atoi(yytext); return NUMBER; }
\n      { return EOL; }
[ \t]
.       { printf("Unexpected character %s\n", yytext); }
%%
