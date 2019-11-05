%{
#include <stdio.h>
#include <stdlib.h>

/* make forward declarations to avoid compiler warnings */
int yylex (void);
void yyerror (char *);

/* 
  Some constants.
*/

 /* These constants are used later in the code */
#define SYMTABSIZE   50
#define IDLENGTH    15
#define NOTHING    -1
#define INDENTOFFSET  2

enum ParseTreeNodeType { PROGRAM, BLOCK, VARIABLE, DECLARATION_BLOCK, STATEMENT_LIST, STATEMENT, ASSIGNMENT_STATEMENT }; 

#ifndef TRUE
#define TRUE 1
#endif

#ifndef FALSE
#define FALSE 0
#endif

#ifndef NULL
#define NULL 0
#endif

/* ------------- parse tree definition --------------------------- */

struct treeNode {
	int item;
	int nodeIdentifier;
	struct treeNode *first;
	struct treeNode *second;
	struct treeNode *third;
 };

typedef struct treeNode TREE_NODE;
typedef TREE_NODE *TERNARY_TREE;

/* ------------- forward declarations --------------------------- */

TERNARY_TREE create_node(int,int,TERNARY_TREE,TERNARY_TREE,TERNARY_TREE);

/* ------------- symbol table definition --------------------------- */

struct symTabNode {
	char identifier[IDLENGTH];
};

typedef struct symTabNode SYMTABNODE;
typedef SYMTABNODE    *SYMTABNODEPTR;

SYMTABNODEPTR symTab[SYMTABSIZE]; 

int currentSymTabSize = 0;

%}

%start program

%union {
	int iVal;
	TERNARY_TREE tVal;
}

%token	NEWLINE PLUS TIMES MINUS DIVIDE BRA KET COLON SEMI COMMA CAST EQUALS GET LT GT
		GORE LORE FULL DECLARATIONS IS BY TO OF IF THEN ELSE ENDIF ENDDO DO CODE
		ENDP WHILE ENDWHILE FOR ENDFOR WRITE READ AND OR NOT 

%token 	<iVal> 	ID CHAR_CONST NUMBER REAL TYPE 
%type 	<iVal> 	program block variable declaration_block statement_list statement assignment_statement type
%type 	<iVal> 	if_statement do_statement while_statement for_statement write_statement read_statement expression


%%
program : ID COLON block ENDP ID FULL 
			{ 
			 TERNARY_TREE ParseTree;
			 ParseTree = create_node(NOTHING,PROGRAM,$3,NULL,NULL,NULL,NULL,NULL); 
			};

block : DECLARATIONS declaration_block CODE statement_list 
		{
		$$ = create_node(NOTHING,BLOCK,$2,$4,NULL,NULL);
		}
		| CODE statement_list {$$ = create_node(NOTHING,BLOCK,$2,NULL);};

declaration_block : variable OF TYPE type SEMI 
					{$$ = create_node(NOTHING, DECLARATION_BLOCK,$1,NULL,NULL,$4,NULL);} 
					| variable OF TYPE type SEMI declaration_block						
					{$$ = create_node(NOTHING, DECLARATION_BLOCK, $1, $4, $6, NULL, NULL, NULL);};

variable : 	ID 
			{ $$ = create_node(NOTHING, VARIABLE, NULL);} |
			ID COMMA variable
			{ 
				$$ = create_node(NOTHING, VARIABLE, NULL, NULL, $3);
			}; 		  
		  
type :  	CHAR_CONST	| 
			NUMBER		    | 
			REAL;

statement_list : statement 
				{ 
				$$ = create_node(NOTHING, STATEMENT_LIST, $1, NULL, NULL);
				} 		  
				| statement SEMI statement_list 
				{ 
				$$ = create_node(NOTHING, STATEMENT_LIST, $1, $3);
				}; 		  

statement : assignment_statement 
			{ 
				$$ = create_node(NOTHING, STATEMENT, $1);
			}
			| if_statement 			
			{ 
				$$ = create_node(NOTHING, STATEMENT, $1);
			}	
			| do_statement 			
			{ 
				$$ = create_node(NOTHING, STATEMENT, $1);
			}
			| while_statement 
			{ 
				$$ = create_node(NOTHING, STATEMENT, $1);
			}
			| for_statement 			
			{ 
				$$ = create_node(NOTHING, STATEMENT, $1);
			}
			| write_statement			
			{ 
				$$ = create_node(NOTHING, STATEMENT, $1);
			}
			| read_statement 			
			{ 
				$$ = create_node(NOTHING, STATEMENT, $1);
			};

assignment_statement : expression CAST ID 
					{ 
						$$ = create_node(NOTHING, ASSIGNMENT_STATEMENT, $1, NULL, NULL);
					};

if_statement : IF conditional THEN statement_list ELSE statement_list ENDIF | IF conditional THEN statement_list ENDIF;

do_statement : DO statement_list WHILE conditional ENDDO; 

while_statement : WHILE conditional DO statement_list ENDWHILE; 

for_statement : FOR ID IS expression BY expression TO expression DO statement_list ENDFOR;

write_statement : WRITE BRA output_list KET | NEWLINE;
	
read_statement : READ BRA ID KET;

output_list : value | value COMMA output_list;

conditional : expression comparator expression
			| expression comparator expression AND conditional
            | expression comparator expression OR conditional
            | NOT conditional;

comparator :  EQUALS
			| GET
			| LT
			| GT
			| GORE
			| LORE;

expression : term | term PLUS expression | term MINUS expression;

term : value | value TIMES term | value DIVIDE term; 

value: ID | constant | BRA expression KET;

constant : number_constant | CHAR_CONST;

number_constant : NUMBER | MINUS NUMBER | MINUS NUMBER FULL NUMBER | NUMBER FULL NUMBER; 

%% 

TERNARY_TREE create_node(int ival, int case_identifier, TERNARY_TREE p1, TERNARY_TREE p2, TERNARY_TREE p3)
{
	TERNARY_TREE t;
	t = (TERNARY_TREE)malloc(sizeof(TREE_NODE));
	t->item = ival;
	t->nodeIdentifier = case_identifier;
	t->first = p1;
	t->second = p2;
	t->third = p3;
	return (t);
}

#include "lex.yy.c" 