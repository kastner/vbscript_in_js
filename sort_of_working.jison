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

/*
static void source_add_class(parser_ctx_t *class_decl_t *class_decl)
{
    class_decl->next = ctx->class_decls;
    ctx->class_decls = class_decl;
}

static void parse_complete(parser_ctx_t *BOOL option_explicit)
{
    ctx->parse_complete = TRUE;
    ctx->option_explicit = option_explicit;
}

static void *new_expression(parser_ctx_t *expression_type_t type, size_t size)
{
    expression_t *expr;

    expr = parser_alloc(size ? size : sizeof(*expr));
    if(expr) {
        expr->type = type;
        expr->next = null;
    }

    return expr;
}

static expression_t *new_bool_expression(parser_ctx_t *VARIANT_BOOL value)
{
    bool_expression_t *expr;

    expr = new_expression(EXPR_BOOL, sizeof(*expr));
    if(!expr)
        return null;

    expr->value = value;
    return &expr->expr;
}

static expression_t *new_string_expression(parser_ctx_t *const WCHAR *value)
{
    string_expression_t *expr;

    expr = new_expression(EXPR_STRING, sizeof(*expr));
    if(!expr)
        return null;

    expr->value = value;
    return &expr->expr;
}

static expression_t *new_long_expression(parser_ctx_t *expression_type_t type, LONG value)
{
    int_expression_t *expr;

    expr = new_expression(type, sizeof(*expr));
    if(!expr)
        return null;

    expr->value = value;
    return &expr->expr;
}

static expression_t *new_double_expression(parser_ctx_t *double value)
{
    double_expression_t *expr;

    expr = new_expression(EXPR_DOUBLE, sizeof(*expr));
    if(!expr)
        return null;

    expr->value = value;
    return &expr->expr;
}

static expression_t *new_unary_expression(parser_ctx_t *expression_type_t type, expression_t *subexpr)
{
    unary_expression_t *expr;

    expr = new_expression(type, sizeof(*expr));
    if(!expr)
        return null;

    expr->subexpr = subexpr;
    return &expr->expr;
}

static expression_t *new_binary_expression(parser_ctx_t *expression_type_t type, expression_t *left, expression_t *right)
{
    binary_expression_t *expr;

    expr = new_expression(type, sizeof(*expr));
    if(!expr)
        return null;

    expr->left = left;
    expr->right = right;
    return &expr->expr;
}

static member_expression_t *new_member_expression(parser_ctx_t *expression_t *obj_expr, const WCHAR *identifier)
{
    member_expression_t *expr;

    expr = new_expression(EXPR_MEMBER, sizeof(*expr));
    if(!expr)
        return null;

    expr->obj_expr = obj_expr;
    expr->identifier = identifier;
    expr->args = null;
    return expr;
}

static expression_t *new_new_expression(parser_ctx_t *const WCHAR *identifier)
{
    string_expression_t *expr;

    expr = new_expression(EXPR_NEW, sizeof(*expr));
    if(!expr)
        return null;

    expr->value = identifier;
    return &expr->expr;
}

static void *new_statement(parser_ctx_t *statement_type_t type, size_t size)
{
    statement_t *stat;

    stat = parser_alloc(size ? size : sizeof(*stat));
    if(stat) {
        stat->type = type;
        stat->next = null;
    }

    return stat;
}

static statement_t *new_call_statement(parser_ctx_t *member_expression_t *expr)
{
    call_statement_t *stat;

    stat = new_statement(STAT_CALL, sizeof(*stat));
    if(!stat)
        return null;

    stat->expr = expr;
    return &stat->stat;
}

static statement_t *new_assign_statement(parser_ctx_t *member_expression_t *left, expression_t *right)
{
    assign_statement_t *stat;

    stat = new_statement(STAT_ASSIGN, sizeof(*stat));
    if(!stat)
        return null;

    stat->member_expr = left;
    stat->value_expr = right;
    return &stat->stat;
}

static statement_t *new_set_statement(parser_ctx_t *member_expression_t *left, expression_t *right)
{
    assign_statement_t *stat;

    stat = new_statement(STAT_SET, sizeof(*stat));
    if(!stat)
        return null;

    stat->member_expr = left;
    stat->value_expr = right;
    return &stat->stat;
}

static dim_decl_t *new_dim_decl(parser_ctx_t *const WCHAR *name, dim_decl_t *next)
{
    dim_decl_t *decl;

    decl = parser_alloc(sizeof(*decl));
    if(!decl)
        return null;

    decl->name = name;
    decl->next = next;
    return decl;
}

static statement_t *new_dim_statement(parser_ctx_t *dim_decl_t *decls)
{
    dim_statement_t *stat;

    stat = new_statement(STAT_DIM, sizeof(*stat));
    if(!stat)
        return null;

    stat->dim_decls = decls;
    return &stat->stat;
}

static elseif_decl_t *new_elseif_decl(parser_ctx_t *expression_t *expr, statement_t *stat)
{
    elseif_decl_t *decl;

    decl = parser_alloc(sizeof(*decl));
    if(!decl)
        return null;

    decl->expr = expr;
    decl->stat = stat;
    decl->next = null;
    return decl;
}

static statement_t *new_while_statement(parser_ctx_t *statement_type_t type, expression_t *expr, statement_t *body)
{
    while_statement_t *stat;

    stat = new_statement(type, sizeof(*stat));
    if(!stat)
        return null;

    stat->expr = expr;
    stat->body = body;
    return &stat->stat;
}

static statement_t *new_forto_statement(parser_ctx_t *const WCHAR *identifier, expression_t *from_expr,
        expression_t *to_expr, expression_t *step_expr, statement_t *body)
{
    forto_statement_t *stat;

    stat = new_statement(STAT_FORTO, sizeof(*stat));
    if(!stat)
        return null;

    stat->identifier = identifier;
    stat->from_expr = from_expr;
    stat->to_expr = to_expr;
    stat->step_expr = step_expr;
    stat->body = body;
    return &stat->stat;
}

static statement_t *new_foreach_statement(parser_ctx_t *const WCHAR *identifier, expression_t *group_expr,
        statement_t *body)
{
    foreach_statement_t *stat;

    stat = new_statement(STAT_FOREACH, sizeof(*stat));
    if(!stat)
        return null;

    stat->identifier = identifier;
    stat->group_expr = group_expr;
    stat->body = body;
    return &stat->stat;
}

static statement_t *new_if_statement(parser_ctx_t *expression_t *expr, statement_t *if_stat, elseif_decl_t *elseif_decl,
        statement_t *else_stat)
{
    if_statement_t *stat;

    stat = new_statement(STAT_IF, sizeof(*stat));
    if(!stat)
        return null;

    stat->expr = expr;
    stat->if_stat = if_stat;
    stat->elseifs = elseif_decl;
    stat->else_stat = else_stat;
    return &stat->stat;
}

static statement_t *new_onerror_statement(parser_ctx_t *BOOL resume_next)
{
    onerror_statement_t *stat;

    stat = new_statement(STAT_ONERROR, sizeof(*stat));
    if(!stat)
        return null;

    stat->resume_next = resume_next;
    return &stat->stat;
}

static arg_decl_t *new_argument_decl(parser_ctx_t *const WCHAR *name, BOOL by_ref)
{
    arg_decl_t *arg_decl;

    arg_decl = parser_alloc(sizeof(*arg_decl));
    if(!arg_decl)
        return null;

    arg_decl->name = name;
    arg_decl->by_ref = by_ref;
    arg_decl->next = null;
    return arg_decl;
}

static function_decl_t *new_function_decl(parser_ctx_t *const WCHAR *name, function_type_t type,
        unsigned storage_flags, arg_decl_t *arg_decl, statement_t *body)
{
    function_decl_t *decl;

    if(storage_flags & STORAGE_IS_DEFAULT) {
        if(type == FUNC_PROPGET) {
            type = FUNC_DEFGET;
        }else {
            FIXME("Invalid default property\n");
            ctx->hres = E_FAIL;
            return null;
        }
    }

    decl = parser_alloc(sizeof(*decl));
    if(!decl)
        return null;

    decl->name = name;
    decl->type = type;
    decl->is_public = !(storage_flags & STORAGE_IS_PRIVATE);
    decl->args = arg_decl;
    decl->body = body;
    decl->next = null;
    decl->next_prop_func = null;
    return decl;
}

static statement_t *new_function_statement(parser_ctx_t *function_decl_t *decl)
{
    function_statement_t *stat;

    stat = new_statement(STAT_FUNC, sizeof(*stat));
    if(!stat)
        return null;

    stat->func_decl = decl;
    return &stat->stat;
}

static class_decl_t *new_class_decl(parser_ctx_t *ctx)
{
    class_decl_t *class_decl;

    class_decl = parser_alloc(sizeof(*class_decl));
    if(!class_decl)
        return null;

    class_decl->funcs = null;
    class_decl->props = null;
    class_decl->next = null;
    return class_decl;
}

static class_decl_t *add_class_function(parser_ctx_t *class_decl_t *class_decl, function_decl_t *decl)
{
    function_decl_t *iter;

    for(iter = class_decl->funcs; iter; iter = iter->next) {
        if(!strcmpiW(iter->name, decl->name)) {
            if(decl->type == FUNC_SUB || decl->type == FUNC_FUNCTION) {
                FIXME("Redefinition of %s::%s\n", debugstr_w(class_decl->name), debugstr_w(decl->name));
                ctx->hres = E_FAIL;
                return null;
            }

            while(1) {
                if(iter->type == decl->type) {
                    FIXME("Redefinition of %s::%s\n", debugstr_w(class_decl->name), debugstr_w(decl->name));
                    ctx->hres = E_FAIL;
                    return null;
                }
                if(!iter->next_prop_func)
                    break;
                iter = iter->next_prop_func;
            }

            iter->next_prop_func = decl;
            return class_decl;
        }
    }

    decl->next = class_decl->funcs;
    class_decl->funcs = decl;
    return class_decl;
}

static class_decl_t *add_variant_prop(parser_ctx_t *class_decl_t *class_decl, const WCHAR *identifier, unsigned storage_flags)
{
    class_prop_decl_t *prop;

    if(storage_flags & STORAGE_IS_DEFAULT) {
        FIXME("variant prop van't be default value\n");
        ctx->hres = E_FAIL;
        return null;
    }

    prop = parser_alloc(sizeof(*prop));
    if(!prop)
        return null;

    prop->name = identifier;
    prop->is_public = !(storage_flags & STORAGE_IS_PRIVATE);
    prop->next = class_decl->props;
    class_decl->props = prop;
    return class_decl;
}

static const_decl_t *new_const_decl(parser_ctx_t *const WCHAR *name, expression_t *expr)
{
    const_decl_t *decl;

    decl = parser_alloc(sizeof(*decl));
    if(!decl)
        return null;

    decl->name = name;
    decl->value_expr = expr;
    decl->next = null;
    return decl;
}

static statement_t *new_const_statement(parser_ctx_t *const_decl_t *decls)
{
    const_statement_t *stat;

    stat = new_statement(STAT_CONST, sizeof(*stat));
    if(!stat)
        return null;

    stat->decls = decls;
    return &stat->stat;
}

static statement_t *link_statements(statement_t *head, statement_t *tail)
{
    statement_t *iter;

    for(iter = head; iter->next; iter = iter->next);
    iter->next = tail;

    return head;
}

void *parser_alloc(parser_ctx_t *size_t size)
{
    void *ret;

    ret = vbsheap_alloc(&ctx->heap, size);
    if(!ret)
        ctx->hres = E_OUTOFMEMORY;
    return ret;
}

HRESULT parse_script(parser_ctx_t *const WCHAR *code)
{
    ctx->code = ctx->ptr = code;
    ctx->end = ctx->code + strlenW(ctx->code);

    vbsheap_init(&ctx->heap);

    ctx->parse_complete = FALSE;
    ctx->hres = S_OK;

    ctx->last_token = tNL;
    ctx->last_nl = 0;
    ctx->stats = ctx->stats_tail = null;
    ctx->class_decls = null;
    ctx->option_explicit = FALSE;

    parser_parse(ctx);

    if(FAILED(ctx->hres))
        return ctx->hres;
    if(!ctx->parse_complete) {
        FIXME("parser failed on parsing %s\n", debugstr_w(ctx->ptr));
        return E_FAIL;
    }

    return S_OK;
}

void parser_release(parser_ctx_t *ctx)
{
    vbsheap_free(&ctx->heap);
}
*/

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
/*
    arg_decl_t *arg_decl;

    arg_decl = parser_alloc(sizeof(*arg_decl));
    if(!arg_decl)
        return null;

    arg_decl->name = name;
    arg_decl->by_ref = by_ref;
    arg_decl->next = null;
    return arg_decl;
*/
}


function new_member_expression(obj_expr, identifier) {
  console.log("new member expression.. object: " + obj_expr + " ident: " + identifier);
  console.log(arguments);
/*
    member_expression_t *expr;

    expr = new_expression(EXPR_MEMBER, sizeof(*expr));
    if(!expr)
        return null;

    expr->obj_expr = obj_expr;
    expr->identifier = identifier;
    expr->args = null;
    return expr;
*/
}

function new_binary_expression(x, y, z) {
  console.log(arguments);
}

function source_add_statement(stat) {
    console.log(stat);
  console.log(arguments);
/*
    if(!stat)
        return;

    if(ctx->stats) {
        ctx->stats_tail->next = stat;
        ctx->stats_tail = stat;
    }else {
        ctx->stats = ctx->stats_tail = stat;
    }
*/
}

function new_if_statement() {
  console.log("New if statement");
  console.log(arguments);
}

