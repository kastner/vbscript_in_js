/* VBScript */

%start Program
%lex
%%

\n+         { return 'tNL'; }
[ \t]+      {/* skip whitespace */}
"Function"  { return 'tFUNCTION'; }
"If"        { return 'tIF'; }
"Then"      { return 'tTHEN'; }
"Else"      { return 'tELSE'; }
"End"       { return 'tEND'; }

[<>\(\)=,]   { return yytext; }


\w\w+       { return 'tIdentifier'; }
<<EOF>>     return 'tEOF';

/lex

%%


%token tEOF tNL tREM tEMPTYBRACKETS
%token tTRUE tFALSE
%token tNOT tAND tOR tXOR tEQV tIMP tNEQ
%token tIS tLTEQ tGTEQ tMOD
%token tCALL tDIM tSUB tFUNCTION tPROPERTY tGET tLET tCONST
%token tIF tELSE tELSEIF tEND tTHEN tEXIT
%token tWHILE tWEND tDO tLOOP tUNTIL tFOR tTO tSTEP tEACH tIN
%token tBYREF tBYVAL
%token tOPTION tEXPLICIT
%token tSTOP
%token tNOTHING tEMPTY tnull
%token tCLASS tSET tNEW tPUBLIC tPRIVATE tDEFAULT tME
%token tERROR tNEXT tON tRESUME tGOTO
%token <string> tIdentifier tString
%token <lng> tLong tShort
%token <dbl> tDouble

%type <statement> Statement SimpleStatement StatementNl StatementsNl StatementsNl_opt IfStatement Else_opt
%type <expression> Expression LiteralExpression PrimaryExpression EqualityExpression CallExpression
%type <expression> ConcatExpression AdditiveExpression ModExpression IntdivExpression MultiplicativeExpression ExpExpression
%type <expression> NotExpression UnaryExpression AndExpression OrExpression XorExpression EqvExpression
%type <member> MemberExpression
%type <expression> Arguments_opt ArgumentList_opt ArgumentList Step_opt
%type <bool> OptionExplicit_opt DoType
%type <arg_decl> ArgumentsDecl_opt ArgumentDeclList ArgumentDecl
%type <func_decl> FunctionDecl PropertyDecl
%type <elseif> ElseIfs_opt ElseIfs ElseIf
%type <class_decl> ClassDeclaration ClassBody
%type <uint> Storage Storage_opt
%type <dim_decl> DimDeclList
%type <const_decl> ConstDecl ConstDeclList


Program
    : OptionExplicit_opt SourceElements tEOF    { parse_complete($1); }
    ;

OptionExplicit_opt
    : /* empty */                { $$ = false; }
    | tOPTION tEXPLICIT tNL      { $$ = true; }
    ;

SourceElements
    : /* empty */
    | SourceElements StatementNl            { source_add_statement($2); }
    | SourceElements ClassDeclaration       { source_add_class($2); }
    ;

StatementsNl_opt
    : /* empty */                           { $$ = null; }
    | StatementsNl                          { $$ = $1; }
    ;

StatementsNl
    : StatementNl                           { $$ = $1; }
    | StatementNl StatementsNl              { $$ = link_statements($1, $2); }
    ;

StatementNl
    : Statement tNL                 { $$ = $1; }
    ;

Statement
    : ':'                                   { $$ = null; }
    | ':' Statement                         { $$ = $2; }
    | SimpleStatement                       { $$ = $1; }
    | SimpleStatement ':' Statement         { $$ = $1; } /* $1->next=$3 */
    | SimpleStatement ':'                   { $$ = $1; }
    ;

SimpleStatement
    : MemberExpression ArgumentList_opt     { $$ = new_call_statement($1); ; } /* $1->args=$2 */
    | tCALL MemberExpression Arguments_opt  { $$ = new_call_statement($2); ; } /* $2->args=$3*/
    | tIdentifier '=' tIdentifier           { console.log("Assignment"); } /* Humm, hope this doesn't screw everything up */
    | MemberExpression Arguments_opt '=' Expression
                                            { $$ = new_assign_statement($1, $4); ; }
    | tDIM DimDeclList                      { $$ = new_dim_statement($2); ; }
    | IfStatement                           { $$ = $1; }
    | tWHILE Expression tNL StatementsNl_opt tWEND
                                            { $$ = new_while_statement(STAT_WHILE, $2, $4); ; }
    | tDO DoType Expression tNL StatementsNl_opt tLOOP
                                            { $$ = new_while_statement($2 ? STAT_WHILELOOP : STAT_UNTIL, $3, $5);
                                              ; }
    | tDO tNL StatementsNl_opt tLOOP DoType Expression
                                            { $$ = new_while_statement($5 ? STAT_DOWHILE : STAT_DOUNTIL, $6, $3);
                                              ; }
    | FunctionDecl                          { $$ = new_function_statement($1); ; }
    | tEXIT tDO                             { $$ = new_statement(STAT_EXITDO, 0); ; }
    | tEXIT tFOR                            { $$ = new_statement(STAT_EXITFOR, 0); ; }
    | tEXIT tFUNCTION                       { $$ = new_statement(STAT_EXITFUNC, 0); ; }
    | tEXIT tPROPERTY                       { $$ = new_statement(STAT_EXITPROP, 0); ; }
    | tEXIT tSUB                            { $$ = new_statement(STAT_EXITSUB, 0); ; }
    | tSET MemberExpression Arguments_opt '=' Expression
                                            { $$ = new_set_statement($2, $5); ; }
    | tSTOP                                 { $$ = new_statement(STAT_STOP, 0); ; }
    | tON tERROR tRESUME tNEXT              { $$ = new_onerror_statement(TRUE); ; }
    | tON tERROR tGOTO '0'                  { $$ = new_onerror_statement(FALSE); ; }
    | tCONST ConstDeclList                  { $$ = new_const_statement($2); ; }
    | tFOR tIdentifier '=' Expression tTO Expression Step_opt tNL StatementsNl_opt tNEXT
                                            { $$ = new_forto_statement($2, $4, $6, $7, $9); ; }
    | tFOR tEACH tIdentifier tIN Expression tNL StatementsNl_opt tNEXT
                                            { $$ = new_foreach_statement($3, $5, $7); }
    ;

MemberExpression
    : tIdentifier                           { $$ = new_member_expression(null, $1); }
    | CallExpression '.' tIdentifier        { $$ = new_member_expression($1, $3); }
    ;

DimDeclList /* FIXME: Support arrays */
    : tIdentifier                           { $$ = new_dim_decl($1, null); ; }
    | tIdentifier ',' DimDeclList           { $$ = new_dim_decl($1, $3); ; }
    ;

ConstDeclList
    : ConstDecl                             { $$ = $1; }
    | ConstDecl ',' ConstDeclList           { $$ = $1; }
    ;

ConstDecl
    : tIdentifier '=' LiteralExpression     { $$ = new_const_decl($1, $3); ; }
    ;

DoType
    : tWHILE        { $$ = TRUE; }
    | tUNTIL        { $$ = FALSE; }
    ;

Step_opt
    : /* empty */                           { $$ = null;}
    | tSTEP Expression                      { $$ = $2; }
    ;

IfStatement
    : tIF Expression tTHEN tNL StatementsNl ElseIfs_opt Else_opt tEND tIF
                                            { $$ = new_if_statement($2, $5, $6, $7); ; }
    | tIF Expression tTHEN Statement        { $$ = new_if_statement($2, $4, null, null); ; }
    | tIF Expression tTHEN Statement tELSE Statement
                                            { $$ = new_if_statement($2, $4, null, $6); ; }
    ;

ElseIfs_opt
    : /* empty */                           { $$ = null; }
    | ElseIfs                               { $$ = $1; }
    ;

ElseIfs
    : ElseIf                                { $$ = $1; }
    | ElseIf ElseIfs                        {  $$ = $1; }
    ;

ElseIf
    : tELSEIF Expression tTHEN tNL StatementsNl
                                            { $$ = new_elseif_decl($2, $5); }
    ;

Else_opt
    : /* empty */                           { $$ = null; }
    | tELSE tNL StatementsNl                { $$ = $3; }
    ;

Arguments_opt
    : EmptyBrackets_opt             { $$ = null; }
    | '(' ArgumentList ')'          { $$ = $2; }
    ;

ArgumentList_opt
    : EmptyBrackets_opt             { $$ = null; }
    | ArgumentList                  { $$ = $1; }
    ;

ArgumentList
    : Expression                    { $$ = $1; }
    | Expression ',' ArgumentList   {  $$ = $1; }
    ;

EmptyBrackets_opt
    : /* empty */
    | tEMPTYBRACKETS
    ;

Expression
    : EqvExpression                             { $$ = $1; }
    | Expression tIMP EqvExpression             { $$ = new_binary_expression(EXPR_IMP, $1, $3); ; }
    ;

EqvExpression
    : XorExpression                             { $$ = $1; }
    | EqvExpression tEQV XorExpression          { $$ = new_binary_expression(EXPR_EQV, $1, $3); ; }
    ;

XorExpression
    : OrExpression                              { $$ = $1; }
    | XorExpression tXOR OrExpression           { $$ = new_binary_expression(EXPR_XOR, $1, $3); ; }
    ;

OrExpression
    : AndExpression                             { $$ = $1; }
    | OrExpression tOR AndExpression            { $$ = new_binary_expression(EXPR_OR, $1, $3); ; }
    ;

AndExpression
    : NotExpression                             { $$ = $1; }
    | AndExpression tAND NotExpression          { $$ = new_binary_expression(EXPR_AND, $1, $3); ; }
    ;

NotExpression
    : EqualityExpression            { $$ = $1; }
    | tNOT NotExpression            { $$ = new_unary_expression(EXPR_NOT, $2); ; }
    ;

EqualityExpression
    : ConcatExpression                          { $$ = $1; }
    | EqualityExpression '=' ConcatExpression   { $$ = new_binary_expression(EXPR_EQUAL, $1, $3); ; }
    | EqualityExpression tNEQ ConcatExpression  { $$ = new_binary_expression(EXPR_NEQUAL, $1, $3); ; }
    | EqualityExpression ">" ConcatExpression   { $$ = new_binary_expression(EXPR_GT, $1, $3); ; }
    | EqualityExpression "<" ConcatExpression   { $$ = new_binary_expression($2, $1, $3); ; }
    | EqualityExpression tGTEQ ConcatExpression { $$ = new_binary_expression(EXPR_GTEQ, $1, $3); ; }
    | EqualityExpression tLTEQ ConcatExpression { $$ = new_binary_expression($2, $1, $3); ; }
    | EqualityExpression tIS ConcatExpression   { $$ = new_binary_expression(EXPR_IS, $1, $3); ; }
    ;

ConcatExpression
    : AdditiveExpression                        { $$ = $1; }
    | ConcatExpression '&' AdditiveExpression   { $$ = new_binary_expression(EXPR_CONCAT, $1, $3); check_error(); }
    ;

AdditiveExpression
    : ModExpression                             { $$ = $1; }
    | AdditiveExpression '+' ModExpression      { $$ = new_binary_expression(EXPR_ADD, $1, $3); check_error(); }
    | AdditiveExpression '-' ModExpression      { $$ = new_binary_expression(EXPR_SUB, $1, $3); check_error(); }
    ;

ModExpression
    : IntdivExpression                          { $$ = $1; }
    | ModExpression tMOD IntdivExpression       { $$ = new_binary_expression(EXPR_MOD, $1, $3); check_error(); }
    ;

IntdivExpression
    : MultiplicativeExpression                  { $$ = $1; }
    | IntdivExpression '\\' MultiplicativeExpression
                                                { $$ = new_binary_expression(EXPR_IDIV, $1, $3); check_error(); }
    ;

MultiplicativeExpression
    : ExpExpression                             { $$ = $1; }
    | MultiplicativeExpression '*' ExpExpression
                                                { $$ = new_binary_expression(EXPR_MUL, $1, $3); check_error(); }
    | MultiplicativeExpression '/' ExpExpression
                                                { $$ = new_binary_expression(EXPR_DIV, $1, $3); check_error(); }
    ;

ExpExpression
    : UnaryExpression                           { $$ = $1; }
    | ExpExpression '^' UnaryExpression         { $$ = new_binary_expression(EXPR_EXP, $1, $3); check_error(); }
    ;

UnaryExpression
    : LiteralExpression             { $$ = $1; }
    | CallExpression                { $$ = $1; }
    | tNEW tIdentifier              { $$ = new_new_expression($2); check_error(); }
    | '-' UnaryExpression           { $$ = new_unary_expression(EXPR_NEG, $2); check_error(); }
    ;

CallExpression
    : PrimaryExpression                 { $$ = $1; }
    | MemberExpression Arguments_opt    {  $$ = $1; }
    ;

LiteralExpression
    : tTRUE                         { $$ = new_bool_expression(VARIANT_TRUE); check_error(); }
    | tFALSE                        { $$ = new_bool_expression(VARIANT_FALSE); check_error(); }
    | tString                       { $$ = new_string_expression($1); check_error(); }
    | tShort                        { $$ = new_long_expression(EXPR_USHORT, $1); check_error(); }
    | '0'                           { $$ = new_long_expression(EXPR_USHORT, 0); check_error(); }
    | tLong                         { $$ = new_long_expression(EXPR_ULONG, $1); check_error(); }
    | tDouble                       { $$ = new_double_expression($1); check_error(); }
    | tEMPTY                        { $$ = new_expression(EXPR_EMPTY, 0); check_error(); }
    | tnull                         { $$ = new_expression(EXPR_null, 0); check_error(); }
    | tNOTHING                      { $$ = new_expression(EXPR_NOTHING, 0); check_error(); }
    ;

PrimaryExpression
    : '(' Expression ')'            { $$ = $2; }
    | tME                           { $$ = new_expression(EXPR_ME, 0); check_error(); }
    ;

ClassDeclaration
    : tCLASS tIdentifier tNL ClassBody tEND tCLASS tNL      {  $$ = $4; }
    ;

ClassBody
    : /* empty */                               { $$ = new_class_decl(ctx); }
    | FunctionDecl tNL ClassBody                { $$ = add_class_function($3, $1); check_error(); }
    | Storage tIdentifier tNL ClassBody         { $$ = add_variant_prop($4, $2, $1); check_error(); }
    | PropertyDecl tNL ClassBody                { $$ = add_class_function($3, $1); check_error(); }
    ;

PropertyDecl
    : Storage_opt tPROPERTY tGET tIdentifier EmptyBrackets_opt tNL StatementsNl_opt tEND tPROPERTY
                                    { $$ = new_function_decl($4, FUNC_PROPGET, $1, null, $7); check_error(); }
    | Storage_opt tPROPERTY tLET tIdentifier '(' ArgumentDecl ')' tNL StatementsNl_opt tEND tPROPERTY
                                    { $$ = new_function_decl($4, FUNC_PROPLET, $1, $6, $9); check_error(); }
    | Storage_opt tPROPERTY tSET tIdentifier '(' ArgumentDecl ')' tNL StatementsNl_opt tEND tPROPERTY
                                    { $$ = new_function_decl($4, FUNC_PROPSET, $1, $6, $9); check_error(); }
    ;

FunctionDecl
    : Storage_opt tSUB tIdentifier ArgumentsDecl_opt tNL StatementsNl_opt tEND tSUB
                                    { $$ = new_function_decl($3, 'sub', $1, $4, $6); check_error(); }
    | Storage_opt tFUNCTION tIdentifier ArgumentsDecl_opt tNL StatementsNl_opt tEND tFUNCTION
                                    { $$ = new_function_decl($3, 'function', $1, $4, $6); check_error(); }
    ;

Storage_opt
    : /* empty*/                    { $$ = 0; }
    | Storage                       { $$ = $1; }
    ;

Storage
    : tPUBLIC tDEFAULT              { $$ = STORAGE_IS_DEFAULT; }
    | tPUBLIC                       { $$ = 0; }
    | tPRIVATE                      { $$ = STORAGE_IS_PRIVATE; }
    ;

ArgumentsDecl_opt
    : EmptyBrackets_opt                         { $$ = null; }
    | '(' ArgumentDeclList ')'   { $$ = $2; }
    ;

ArgumentDeclList
    : ArgumentDecl                              { $$ = $1; }
    | ArgumentDecl ',' ArgumentDeclList         { $$ = $1; }
    ;

ArgumentDecl
    : tIdentifier                               { $$ = new_argument_decl($1, true); }
    | tBYREF tIdentifier                        { $$ = new_argument_decl($2, true); }
    | tBYVAL tIdentifier                        { $$ = new_argument_decl($2, false); }
    ;

%%

function parser_error(str) {
  console.log("Parse Error, yo: " + str);
  console.log(arguments);
}

function parse_complete(prg) {
  console.log("program complete: " + prg);
  console.log(arguments);
  console.log(this);
}

function check_error() {
  console.log("check for errors");
  console.log(arguments);
}

function new_function_decl() {
  console.log("new function decl");
  console.log(arguments);
}

function new_function_statement() {
  console.log("new function statements");
  console.log(arguments);
}

function new_argument_decl(name, by_ref) {
  console.log("function parameter: " + name);
  console.log(arguments);
}


function new_member_expression(obj_expr, identifier) {
  console.log("new member expression.. object: " + obj_expr + " ident: " + identifier);
  console.log(arguments);
}

function new_binary_expression(x, y, z) {
  console.log(arguments);
}

function source_add_statement(stat) {
    console.log(stat);
  console.log(arguments);
}

function new_if_statement() {
  console.log("New if statement");
  console.log(arguments);
}

