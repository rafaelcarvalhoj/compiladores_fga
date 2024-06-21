%option noyywrap

%{
    #include <stdio.h>
    int keyword = 0, id = 0, number = 0, op = 0, comop = 0, delimiter = 0, comments = 0, unknown = 0, line = 2;
%}

_number -?[0-9]+(\.[0-9]+)?
_alphnumeric [a-zA-Z][a-zA-Z0-9_]*

%%

"and"       { keyword++; }
"array"     { keyword++; }
"begin"     { keyword++; }
"div"       { keyword++; }
"do"        { keyword++; }
"else"      { keyword++; }
"end"       { keyword++; }
"function"  { keyword++; }
"goto"      { keyword++; }
"if"        { keyword++; }
"label"     { keyword++; }
"not"       { keyword++; }
"of"        { keyword++; }
"or"        { keyword++; }
"procedure" { keyword++; }
"program"   { keyword++; }
"then"      { keyword++; }
"type"      { keyword++; }
"var"       { keyword++; }
"while"     { keyword++; }
"read"      { keyword++; }
"write"     { keyword++; }

"<>"|"<="|">="|":="	{ comop++; }

\+|-|\*|\/|<|>|=     { op++; }

[ \t]+  { /* WHITE SPACES */ }

\n		{ line++; }

[a-zA-Z][a-zA-Z0-9_]*	{ id++; }

[0-9]+(\.[0-9]+)?		{ number++; }

\(|\)|\[|\]|;|:|,|\.	{ delimiter++; }

\(\*([^*]|\*+[^)*])*\*+\)	{ comments++; } 

.  { unknown++; }

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

