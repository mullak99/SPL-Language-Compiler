%token TYPE char_const declaration_block id NEWLINE PLUS TIMES MINUS DIVIDE BRA KET COLON SEMICOLON COMMA CAST EQUALS GET LT GT GORE FULL APOS ASSIGNMENT IF ELSE ENDIF ENDDO DO WHILE ENDWHILE FOR ENDFOR WRITE READ AND OR NOT BY CODE ENDP LORE INTEGER DECLARATIONS IS OF REAL THEN TO 
%token CHARACTER 
%token NUMBER 
%%

program : id COLON block ENDP id FULL;

block : DECLARATIONS declaration_block CODE statement_list | CODE statement_list;

declaration : variables OF TYPE type SEMICOLON | variables OF TYPE type SEMICOLON declaration_block;

variables : id | id COMMA variables;

type: CHARACTER | INTEGER | REAL;

statement_list : statement | statement SEMICOLON statement_list;

statement : assignment_statement | if_statement | do_statement| while_statement | for_statement | write_statement | read_statement;

assignment_statement : expression CAST id;

if_statement : IF conditional THEN statement_list ELSE statement_list ENDIF | IF conditional THEN statement_list ENDIF;

do_statement : DO statement_list WHILE conditional ENDDO;

while_statement : WHILE conditional DO statement_list ENDWHILE;

for_statement : FOR id IS expression BY expression TO expression TO expression DO statement_list ENDFOR;

write_statement : WRITE BRA id KET | NEWLINE WRITE BRA id KET;

read_statement : READ BRA id KET;

output_list : value |value COMMA output_list;

conditional : expression comparator expression
			| expression comparator expression AND conditional
			| expression comparator expression OR conditional
			| NOT conditional;

comparator : EQUALS | GET | LT | GT | GORE | LORE;

expression : term | term PLUS expression | term MINUS expression;

term : value | value TIMES term | value DIVIDE term;

value : id | constant | BRA expression KET;

constant : number_constant | char_const;

number_constant : NUMBER | MINUS NUMBER | MINUS NUMBER FULL NUMBER | NUMBER FULL NUMBER;

