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

%left '.'

%left '^'
%left '*' '/'
%left '\\\\'
%left MOD
%left '+' '-'
%left '&'

%left COMPARISON '<>' '<' '>' '<=' '>=' IS

%left NOT
%left AND
%left OR
%left XOR
%left EQV
%left IMP

%left '(' ')' ','

%left '='

%left TO IN STEP
%left ELSEIF ELSE
%left ':'
%left NEWLINE fake_newline


%start program

%%

program
  : statement_list EOF        { return { type:'Program', body: $1 }; }
  ;

statement_list
  : statement NEWLINE
    { $$ = [$1] }
  | statement NEWLINE statement_list
    { $1.push($3); $$ = $1; }
  ;

statement
  : IDENTIFIER
  | function
  | if_statement
  | if_else_statement
  | assignment
  | call_statement
  ;

function
  : FUNCTION IDENTIFIER arguments NEWLINE statement_list END FUNCTION 
    { 
      console.log($0, $1, $2, $3, $4);
      $$ = $5; 
    }
  ;

if_statement
  : IF IDENTIFIER '<' IDENTIFIER THEN NEWLINE statement_list END IF
  ;

if_else_statement
  : IF IDENTIFIER '<' IDENTIFIER THEN NEWLINE statement_list ELSE NEWLINE statement_list END IF
  ;

call_statement
  : CALL IDENTIFIER arguments
    { $$ = { type: 'Call', name: $2, arguments: $3 }; }
  ;

assignment
  : IDENTIFIER '=' IDENTIFIER
  ;

arguments
  : EMPTYBRACKETS
  | '(' argument_list ')' 
    { $$ = $2; }
  ;

argument_list
  : /* can be empty */
    { $$ = []; }
  | argument 
    { $$ = [$1]; console.log("in here");}
  | argument_list ',' argument
    { $$ = $1.concat($3); }
  ;

/* optional args? */
argument
  : statement
    { $$ = {type: 'Argument', value: $1 }; }
  ;

