/* VBScript */

%lex
%%

\n+         { return 'NEWLINE'; }
[ \t]+      { /* skip whitespace */ }
"Call"      { return 'CALL'; }
"Function"  { return 'FUNCTION'; }
"If"        { return 'IF'; }
"Then"      { return 'THEN'; }
"Else"      { return 'ELSE'; }
"End"       { return 'END'; }
"MOD"       { return yytext; }
"()"        { return 'EMPTYBRACKETS'; }

[<>\(\)=,]  { return yytext; }


\w+         { return 'IDENTIFIER'; }

<<EOF>>     { return 'EOF'; }

/lex


%%

program
  : statement_list EOF        { return ['Program', {}].concat($1); }
  ;

statement_list
  : statement NEWLINE                   { $$ = $1; }
  | statement NEWLINE statement_list    { $$ = $1; }
  ;

statement
  : IDENTIFER                           { $$ = $1; }
  | function                            { $$ = $1; }
  ;

function
  : FUNCTION IDENTIFIER arguments NEWLINE statement_list END FUNCTION { $$ = $1; console.log($0, $1, $2, $3, $4); }
  ;

arguments
  : EMPTYBRACKETS { $$ = $1; }
  | '(' argument_list ')' { $$ = $1; }
  ;

argument_list
  : argument { $$ = $1; }
  ;

argument
  : statement { $$ = $1; }
  ;

