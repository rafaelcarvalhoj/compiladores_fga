%option noyywrap

%{
    #include "parser.tab.h"
    extern int yylval;
%}

/* Definition Section */

_number [0-9]+(\.[0-9]+)?
_alphnumeric [a-zA-Z][a-zA-Z0-9_]*
_comment \(\*(\*^\)|[^\*])*\*+\)

%%

program { return tk_program; }
begin { return tk_begin; }
end { return tk_end; }
and { return tk_and; }
or { return tk_or; }
not { return tk_not; }
goto { return tk_goto; }
if { return tk_if; }
then { return tk_then; }
else { return tk_else; }
while { return tk_while; }
do { return tk_do; }
var { return tk_var; }
type { return tk_type; }
label { return tk_label; }
procedure { return tk_procedure; }
function { return tk_function; }

[a-zA-Z][a-zA-Z0-9]* { return tk_id; }

\:= { return tk_attribuition; }

\( { return tk_lparen; }
\) { return tk_rparen; }
\[ { return tk_lbrack; }
\] { return tk_rbrack; }
; { return tk_semicolon; }
\: { return tk_colon; }
, { return tk_comma; }
\. { return tk_dot; }


\+ { return tk_plus; }
\- { return tk_minus; }
\* { return tk_star; }
\/ { return tk_div; }

= { return tk_equal; }
\> { return tk_gratter; }
\< { return tk_lower; }
\<\= { return tk_lowerequal; }
\>\= { return tk_gratterequal; }
\<\> { return tk_gratterlower; }


[0-9]+ { return tk_num; }


[ \t] {/*whitespace*/}

[\n\r\0\x0B]+ {/*end of line chars*/}

%%
