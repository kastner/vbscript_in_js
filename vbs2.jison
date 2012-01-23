%%
  rootfile
    : file
    | html_block
    ;
  opt_newline
    : /* nothing */
    | opt_newline any_newline
    ;

  file
    : file filecontent
    ;

  filecontent
    : statement
    | class_def
    | method_def
    ;

  class_def
    : CLASS identifier end_statement
      class_body
      END CLASS end_statement
    ;

  class_body
    : /* nothing */
    | class_body class_body_item
    ;

  class_body_item
    : class_member
    | class_method_def
    | class_property_def
    | any_newline
    ;

  class_member
    : scope ident_def end_statement

    ;
  ident_def_list
    : ident_def
    | ident_def_list ',' ident_def
    ;
  ident_def
    : identifier 
    | ident_def arg_paren ')' 
    ;
  class_method_def
    : scope method_def 
    | method_def
    ;
  method_def
    : sub_def
    | function_def
    ;
  class_property_def
    : scope property_def 
    | property_def
    ;
  scope
    : PUBLIC 
    | PRIVATE 
    ;
  property_stmt
    : PROPERTY GET 
    | PROPERTY LET 
    | PROPERTY SET 
    ;
  property_def
    : property_stmt identifier full_arg_def_list end_statement
      method_body
      END PROPERTY end_statement
    ;
  sub_def
    : SUB identifier full_arg_def_list end_statement
      method_body
      END SUB end_statement
      
      ;
  function_def
    : FUNCTION identifier full_arg_def_list end_statement
      method_body
      END FUNCTION end_statement
      
    ;
  full_arg_def_list
    : arg_paren ')' 
    | arg_paren arg_def_list ')' 
    ;
  arg_def_list
    : arg_def 
    | arg_def_list ',' arg_def 
    ;
  arg_def
    : identifier
    | BYREF identifier 
    | BYVAL identifier 
    ;
  statements
    : /* nothing */ 
    | statements statement 
    | statements '%>' html_values '<%' 
    ;
  method_body
    : statements
    ;
  statement
    : end_statement 
    | simple_statement end_statement
    | full_if_block
    | single_line_if
    | do_loop
    | for_next
    | for_each
    | select_block
    | with_block
    | EXPLICIT 
    | RANDOMIZE opt_expression 
    ;
  html_values
    : /* nothing */ 
    | html_values html 
    | html_values '<%=' expression '%>' 
    ;

  with_block
    : WITH expression end_statement statements END WITH end_statement
    ;

  select_block
    : SELECT CASE expression end_statement
      case_or_case_else
      END SELECT end_statement
      
      ;
  case_or_case_else
    : optional_case case_block 
    | optional_case CASE ELSE statements 
    ;
  case_block
    : CASE expression_list end_statement statements 
    ;
  optional_case
    : optional_case case_block 
    | /* nothing */ 
    ;
  optional_step
    : STEP expression 
    | /* nothing */ 
    ;
  for_each
    : FOR EACH identifier IN expression end_statement statements NEXT end_statement
    ;  
  do_loop
    : DO end_statement statements LOOP end_statement
      
    | DO WHILE expression end_statement statements LOOP end_statement
      
    | DO end_statement statements LOOP WHILE expression end_statement
      
    | DO UNTIL expression end_statement statements LOOP end_statement
      
    | DO end_statement statements LOOP UNTIL expression end_statement
      
    | WHILE expression end_statement statements WEND end_statement
    ;  
  for_next
    : FOR identifier '=' expression TO expression optional_step end_statement statements NEXT end_statement
    ;
  single_line_if
    : IF expression THEN simple_statement_chain opt_comment any_newline
      
    | IF expression THEN single_line_if
      
    | IF expression THEN simple_statement_chain ELSE single_line_if
      
    | IF expression THEN simple_statement_chain ELSE simple_statement_chain opt_comment any_newline
      
      ;
  full_if_block
    : IF expression THEN end_statement
      statements
      optional_else_or_elseif
      END IF end_statement
      
      ;
  optional_else_or_elseif
    : ELSEIF expression THEN end_statement statements optional_else_or_elseif 
    | else_block
    | /* nothing */ 
    ;
  else_block
    : ELSE end_statement statements 
    ;
  simple_statement_chain
    : simple_statement_chain ':' simple_statement 
    | simple_statement
    ;
  simple_statement
    : assignment
    | objvalue
    | const_assignment
    | sub_call
    | exit_statement
    | on_error_statement
    | DIM ident_def_list 
    ;
  on_error_statement
    : IGNORE_ERRORS 
    | THROW_ERRORS 
    ;
  exitable
    : SUB 
    | FUNCTION 
    | PROPERTY 
    | DO 
    | FOR 
    ;
  exit_statement
    : EXIT exitable 
    ;
  assignment
    : objvalue '=' expression 
    | SET objvalue '=' expression 
    ;
  const_assignment
    : CONST identifier '=' literal 
    ;
  objvalue
    : objvalue arg_paren opt_expression_list ')' 
    | objvalue '.' objmember 
    | with_dot objmember 
    | identifier 
    ;
  identifier
    : ident
    | '[' ident ']' 
    ;
  objmember
    : identifier
    ;
  opt_expression
    : /* nothing */ 
    | expression
    ;
  expression
    : objexpression
    | intrinsic_expression
    ;
  intrinsic_expression
    : literal

    | '+' expression =UPLUS 
    | '-' expression =UMINUS 
    | expression '^' expression 
    | expression '*' expression 
    | expression '/' expression 
    | expression '\\\\' expression 
    | expression MOD expression 
    | expression '+' expression 
    | expression '-' expression 
    | expression '&' expression 

    | expression '=' expression =COMPARISON 
    | expression '<>' expression 
    | expression '<=' expression 
    | expression '>=' expression 
    | expression '<' expression 
    | expression '>' expression 

    | NOT expression 
    | expression AND expression 
    | expression OR expression 
    | expression XOR expression 
    | expression EQV expression 
    | expression IMP expression 

    | objexpression IS objexpression 

    | '(' intrinsic_expression ')' 
    ;
  objexpression
    : objvalue
    | NEW identifier 
    | '(' objexpression ')' 
    ;
  literal
    : integer 
    | float 
    | string 
    | TRUE 
    | FALSE 
    ;
  string
    : '"' string_contents '"' 
    | '"' '"' 
    ;
  string_contents
    : string_atom
    | string_contents string_atom 
    ;
  string_atom
    : escaped_atom 
    | string_text
    ;
  sub_call
    : objvalue '.' identifier opt_expression_list 
    | identifier opt_expression_list 
    | with_dot identifier opt_expression_list 
    | CALL function_call 
    ;
  function_call
    : identifier arg_paren opt_expression_list ')' 
    | identifier 
    ;
  any_newline
    : newline 
    | fake_newline 
    ;
  end_statement
    : ':' 
    | comment any_newline 
    | any_newline 
    ;
  opt_comment
    : /* nothing */ 
    | comment 
    ;
  opt_expression_list
    : /* nothing */ 
    | expression_list
    ;
  expression_list
    : expression 
    | expression_list ',' expression 
    ;


