%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <math.h>

    extern int yylex();
    void yyerror(const char* s);
%}

%start program

%token tk_program
%token tk_id
%token tk_num

%token tk_lparen tk_rparen tk_lbrack tk_rbrack
%token tk_semicolon tk_colon tk_comma tk_dot

%token tk_begin tk_end

%token tk_plus tk_minus tk_star tk_div
%token tk_equal tk_gratterlower tk_lower tk_lowerequal tk_gratterequal tk_gratter
%token tk_and tk_or tk_not
%%

program: tk_program tk_id optional_param tk_semicolon declaration_block
       ;

optional_param: %empty
              | tk_lparen id_list tk_rparen
              ;

id_list: tk_id 
       | tk_id tk_comma id_list
       ;

declaration_block: %empty
                 | block tk_dot
                 ;

block: compound_statement
     ;

compound_statement: tk_begin statement_list tk_end
                  ;

statement_list: %empty
               | base_statement
               | statement_list tk_semicolon base_statement
               ;

base_statement:
         tk_num tk_colon statement
         | statement
         ;

statement:
         assign
         ;

assign:
      variable
      ;

variable:
        tk_id
        | tk_id expression_list
        ;

expression_list:
               expression
               | expression_list tk_comma expression
               ;

expression:
          simple_expression
          | relation simple_expression
          ;

simple_expression:
                 sinal term tk_plus term
                 | sinal term tk_minus term
                 | sinal term tk_or term
                 ;
relation:
        tk_equal
        | tk_gratterlower
        | tk_lower
        | tk_lowerequal
        | tk_gratterequal
        | tk_gratter
        ;
term:
    factor tk_star factor
    | factor tk_div factor
    | factor tk_and factor
    ;

factor:
      variable
      | tk_num
      | tk_lparen expression tk_rparen
      | tk_not factor
      ;

sinal: %empty
     | tk_plus
     | tk_minus
     ;



%%

int main(int argc, char **argv) {
    yyparse();
    return 0;
}

void yyerror(const char* s) {
	fprintf(stderr, "Parse error: %s\n", s);
	exit(1);
}
