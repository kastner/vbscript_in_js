/* VBScript */

%lex
%%

\n+         { return 'NEWLINE'; }
[ \t]+      { /* skip whitespace */ }
"Call"      { return 'CALL'; }
"call"      { return 'CALL'; } /* how do we do case insensitive? */
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

/* does this mean a program must end with a newline? */
program
  : statement_list EOF        { return { type:'Program', body: $1 }; }
  ;

statement_list
  : statement_line
    { $$ = [$statement_line]; }
  | statement_list statement_line
    { 
      if ($statement_list['push']) {
        $statement_list.push($statement_line);
        $$ = $statement_list;
      } else {
        console.log("So... statement_list isn't cool... let's see what it is");
        console.log($statement_list);
        //console.log($statement_line);
        var tmp = [$statement_list];
        tmp.push($statement_line);
        $$ = tmp;
      }
    //$$ = $1.concat($3); 
    }
  ;

statement_line
  : statement NEWLINE
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
    { $$ = { type: 'Function', name: $IDENTIFIER, arguments: $arguments, body: $statement_list }; }
  ;

if_statement
  : IF conditional THEN NEWLINE statement_list END IF
    { $$ = { type: 'If', condition: $conditional, body: $statement_list}; }
  ;

if_else_statement
  : IF conditional THEN NEWLINE statement_list ELSE NEWLINE statement_list END IF
    { $$ = { type: 'IfElse', condition: $conditional, body: $statement_list1, else_body: $statement_list2}; }
  ;

conditional
  : IDENTIFIER compare IDENTIFIER
    { $$ = { type: 'Conditional', first: $1, second: $3, compare: $2}; }
  ;

compare
  : '>'
  | '<'
  | '>='
  | '<='
  | '='
  ;

call_statement
  : CALL IDENTIFIER arguments
    { $$ = { type: 'Call', name: $IDENTIFIER, arguments: $arguments }; }
  ;

assignment
  : IDENTIFIER '=' IDENTIFIER
    { $$ = { type: 'Assignment', name: $IDENTIFIER1, value: $IDENTIFIER2}; }
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
    { $$ = [$1]; }
  | argument_list ',' argument
    { $$ = $1.concat($3); }
  ;

/* optional args? */
argument
  : statement
    { $$ = {type: 'Argument', value: $1 }; }
  ;

