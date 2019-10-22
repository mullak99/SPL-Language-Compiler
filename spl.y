%token NEWLINE PLUS TIMES MINUS DIVIDE BRA KET COLON SEMICOLON COMMA EQUALS GET LT GT LORE GORE FULL APOS ASSIGNMENT IF ELSE ENDIF ENDDO DO WHILE ENDWHILE FOR ENDFOR WRITE READ AND OR NOT ENDP CODE

%%
program : id COLON block ENDP id FULL

block : DECLARATIONS declaration_block CODE statement_list | CODE statement_list

declaration : variables OF Type type COLON | variables OF Type type COLON declaration_block
variables : id | id COMMA variables

type: CHARACTER | INTEGER | REAL

statement_list : statement | statement SEMICOLON statement_list

statement : assignment_statement | if_statement | do_statement | while_statement | for_statement | write_statement | read_statement

assignment_statement  : expression ASSIGNMENT id

if_statement : IF conditional THEN statement_list ELSE statement_list ENDIF | IF conditional THEN statement_list ENDIF

do_statement : DO statement_list WHILE conditional ENDDO

while_statement : WHILE conditional DO statement_list ENDWHILE

for_statement : FOR id IS expression BY expression TO expression TO expression DO statement_list ENDFOR

write_statement : WRITE BRA id KET | NEWLINE WRITE BRA id KET

read_statement : READ BRA id KET

output_list : value |value COMMA output_list

conditional : expression comparator expression
			| expression comparator expression AND conditional
			| expression comparator expression OR conditional
			| NOT conditional

comparator : EQUALS | GET | LT | GT | GORE | LORE

expression : term | term PLUS expression | term MINUS expression

term : value | value TIMES term | value DIVIDE term

value : id | constant | BRA expression KET

constant : number_constant | character_constant

charater_constant : APOS character APOS

number_constant : number | MINUS number | MINUS number FULL number | number FULL number

number : digit | number digit

id : character | id character | id digit

