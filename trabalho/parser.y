%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <math.h>
    
    extern FILE* yyin;
    extern int yylex();
    void yyerror(const char* s);
%}

%start program

%token tk_program
%token tk_id
%token tk_num

%token tk_attribuition

%token tk_if tk_then tk_else tk_while tk_do tk_goto
%token tk_var
%token tk_type
%token tk_label

%token tk_lparen tk_rparen tk_lbrack tk_rbrack
%token tk_semicolon tk_colon tk_comma tk_dot

%token tk_begin tk_end

%token tk_procedure tk_function

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

block:
     label_section
     var_section
     subroutine_section
     compound_statement
     ;

subroutine_section:
                  %empty
                  | procedure_declaration tk_semicolon
                  | subroutine_section procedure_declaration tk_semicolon
                  | function_declaration tk_semicolon
                  | subroutine_section function_declaration tk_semicolon
                  ;

procedure_declaration:
                     tk_procedure tk_id formal_params tk_semicolon block
                     | tk_procedure tk_id tk_semicolon block
                     ;

function_declaration:
                    tk_function tk_id formal_params tk_colon tk_id tk_semicolon block
                    | tk_function tk_id tk_colon tk_id tk_semicolon block
                    ;

formal_params:
             formal_params_section
             | formal_params_section tk_semicolon formal_params_section
             ;

formal_params_section:
                     tk_lbrack tk_var tk_rbrack id_list tk_colon tk_id
                     ;

label_section:
             %empty
             | label_declaration tk_semicolon
             ;

label_declaration:
                 tk_label tk_num
                 | label_declaration tk_comma tk_num
                 ;

var_section:
           %empty
           | tk_var var_declaration tk_semicolon
           | var_section tk_var var_declaration tk_semicolon 
           ;

var_declaration:
               id_list tk_colon tk_id 
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
         | call_procedure
         | derivation
         | compound_statement
         | conditional_statement
         | while_statement
         ;

assign:
      variable tk_attribuition expression
      ;

call_procedure:
              tk_id
              | tk_id  expression_list
              ;

derivation:
          tk_goto tk_num
          ;

conditional_statement:
                     tk_if expression tk_then statement
                     | tk_if expression tk_then statement tk_else statement
                     ;

while_statement:
               tk_while expression tk_do statement
               ;

variable:
        tk_id
        ;

expression_list:
               expression
               | expression_list tk_comma expression
               ;

expression:
          simple_expression
          | simple_expression relation simple_expression
          ;

simple_expression:
                 sinal term tk_plus term
                 | sinal term tk_minus term
                 | sinal term tk_or term
                 | sinal term
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
    | factor
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
	if(argc > 1) {
        if(!(yyin = fopen(argv[1], "r"))) {
			perror(argv[1]);
			return 1;
        }
    }
    yyparse();
    printf("Aceito\n");
    return 0;
}

void yyerror(const char* s) {
    printf("Rejeito\n");
	//fprintf(stderr, "Parse error: %s\n", s);
	//exit(1);
    exit(0);
}
