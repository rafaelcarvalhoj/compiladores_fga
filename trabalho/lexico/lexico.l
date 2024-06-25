%option noyywrap

%{
    #include <stdio.h>
    int keyword = 0, id = 0, number = 0, op = 0, comop = 0, delimiter = 0, comments = 0, unknown = 0, line = 1;
%}

/* Definition Section */

_keyword "and"|"array"|"begin"|"div"|"do"|"else"|"end"|"function"|"goto"|"if"|"label"|"not"|"of"|"or"|"procedure"|"program"|"then"|"type"|"var"|"while"|"read"|"write"
_number [0-9]+(\.[0-9]+)?
_alphnumeric [a-zA-Z][a-zA-Z0-9]*
/* _comment \(\*((.[^\*][^\)]*\*?[^\)])|[\n\t ])\*+\) */
_comment \(\*(\*^\)|[^\*])*\*+\)
_operator "+"|"-"|"*"|"/"|"<"|">"|"="
_compound_operator "<>"|"<="|">="|":="
_delimeter "("|")"|"["|"]"|";"|":"|","|"."

%%

{_keyword} {
	//printf("%d.KEYWORD: %s\n", line, yytext);
	keyword++;
}

{_compound_operator} {
	//printf("COMPOUND OPERATOR: %s\n", yytext);
	comop++;
}

{_operator} {
	//printf("%d.OPERATOR: %s\n",line, yytext);
	op++;
}

[ \t]+  { /* WHITE SPACES */ }

\n {
	line++;
}

{_alphnumeric} {
	//printf("IDENTIFIER: %s\n", yytext);
	id++;
}

{_number} {
	//printf("NUMBER: %s\n", yytext);
	number++;
}

{_comment} {
	//printf("COMMENTS: %s\n", yytext);
	comments++;
}

{_delimeter} {
	//printf("DELIMITER: %s\n", yytext);
	delimiter++;
}

. { 
	//printf("UNKNOWN: %s\n", yytext);
	unknown++;
}

%%
int main(int argc, char** argv){
		if(argc > 1) {
        if(!(yyin = fopen(argv[1], "r"))) {
					perror(argv[1]);
					return (1);
        }
    }
		yylex();
    printf("KEYWORD: %d\n", keyword);
    printf("IDENTIFIER: %d\n", id);
    printf("NUMBER: %d\n", number);
    printf("OPERATOR: %d\n", op);
    printf("COMPOUND OPERATOR: %d\n", comop);
    printf("DELIMITER: %d\n", delimiter);
    printf("COMMENTS: %d\n", comments);
    printf("UNKNOWN: %d\n", unknown);
    return 0;
}

