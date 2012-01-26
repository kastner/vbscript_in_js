/* VBScript */

%lex
%%

\n+                 { return 'NEWLINE'; }
[ \t]+              { /* skip whitespace */ }
"Call"              { return 'CALL'; }
"call"              { return 'CALL'; } /* how do we do case insensitive? */
"Function"          { return 'FUNCTION'; }
"Sub"               { return 'SUB'; }
"If"                { return 'IF'; }
"Then"              { return 'THEN'; }
"Else"              { return 'ELSE'; }
"Is"                { return 'IS'; }
"End"               { return 'END'; }
"Set"               { return 'SET'; }
"MOD"               { return yytext; }
L?\"(\\.|[^\\"])*\" { return 'STRING'; }  /* taken from ansi C yacc file */
"()"                { return 'EMPTYBRACKETS'; }

[<>\(\)=,\.]        { return yytext; }


\w+                 { return 'IDENTIFIER'; }

<<EOF>>             { return 'EOF'; }

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
  : STRING
  | function
  | if_statement
  | if_else_statement
  | assignment
  | call_statement
  ;

function
  : function_or_sub member_access arguments NEWLINE statement_list END function_or_sub
    { $$ = { type: 'Function', name: $member_access, arguments: $arguments, body: $statement_list }; }
  ;

function_or_sub
  : FUNCTION
  | SUB
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
  : comparable compare comparable
    { $$ = { type: 'Conditional', first: $comparable1, second: $comparable2, compare: $compare}; }
  ;

comparable
  : member_access
  | call_statement
  | STRING
  ;

compare
  : '>'
  | '<'
  | '>='
  | '<='
  | '='
  | 'IS'
  ;

call_statement
  : member_access arguments
    { $$ = { type: 'Call', name: $member_access, arguments: $arguments }; }
  | CALL member_access arguments
    { $$ = { type: 'Call', name: $member_access, arguments: $arguments }; }
  ;

member_access
  : member_access '.' IDENTIFIER
  | IDENTIFIER
  ;

member_access_or_string
  : member_access
  | STRING
  ;

assignment
  : SET member_access '=' member_access_or_string
    { $$ = { type: 'Assignment', name: $member_access, value: $member_access_or_string }; }
  | member_access '=' member_access_or_string
    { $$ = { type: 'Assignment', name: $member_access, value: $member_access_or_string }; }
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
  : IDENTIFIER
    { $$ = {type: 'Argument', value: $1 }; }
  | STRING
    { $$ = {type: 'Argument', value: $1 }; }
  ;

