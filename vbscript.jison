%lex
%%


\s+                   /* skip whitespace */
Function              return 'FUNCTION'
End                   return 'END'
[0-9]+("."[0-9]+)?\b  return 'NUMBER'
'('                   return 'OPEN_PAREN'
')'                   return 'CLOSE_PAREN'
','                   return 'COMMA'
'\n'                  return 'NEW_LINE'
\w+\b                 return 'WORD'
[a-zA-Z0-9_$-]+/[=}\s\/.]    { return 'ID'; }
<<EOF>>              { return 'EOF'; }
.*                     return 'ANYTHING'

/lex



%% /* language grammar */

function_def
    : FUNCTION identifier arg_list stuff function_end
        { $$ = "FUNCTION!" }
    ;


identifier
    : /* empty string */
    | NUMBER
    | WORD
    | HEX
    | STRING
    | WHATEVER
    ;

function_end
    : FUNCTION END
    ;


arg_list
    : OPEN_PAREN identifier CLOSE_PAREN
    | OPEN_PAREN identifier COMMA identifier CLOSE_PAREN
    ;

stuff
    : WORD
    | WORD WORD
    ;