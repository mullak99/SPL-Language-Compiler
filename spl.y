%{
#include <stdio.h>
#include <stdlib.h>

/* make forward declarations to avoid compiler warnings */
int yylex(void);
void yyerror(char *);

#define SYMTABSIZE   	50
#define IDLENGTH    	15
#define NOTHING    		-1
#define INDENTOFFSET  	2

enum ParseTreeNodeType
{
	PROGRAM, BLOCK, DECLARATION_BLOCK, VARIABLE, STATEMENT_LIST, STATEMENT,
	ASSIGNMENT_STATEMENT, IF_STATEMENT, DO_STATEMENT,  WHILE_STATEMENT,
	FOR_STATEMENT, WRITE_STATEMENT, READ_STATEMENT, OUTPUT_LIST, CONDITIONAL,
	EXPRESSION, TERM, VALUE, CONST, NUM_CONST, VAL_CONST, ID_VALUE, RELOP,
	INT_TYPE, CHAR_TYPE, REAL_TYPE, ID_VARIABLE
};

char *NodeName[] =
{
	"PROGRAM", "BLOCK", "DECLARATION_BLOCK", "VARIABLE", "STATEMENT_LIST", "STATEMENT",
	"ASSIGNMENT_STATEMENT", "IF_STATEMENT", "DO_STATEMENT",  "WHILE_STATEMENT",
	"FOR_STATEMENT", "WRITE_STATEMENT", "READ_STATEMENT", "OUTPUT_LIST", "CONDITIONAL",
	"EXPRESSION", "TERM", "VALUE", "CONST", "NUM_CONST", "VAL_CONST", "ID_VALUE", "RELOP",
	"INT_TYPE", "CHAR_TYPE", "REAL_TYPE", "ID_VARIABLE"
};

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

struct treeNode
{
	int item;
	int nodeIdentifier;
	struct treeNode *first;
	struct treeNode *second;
	struct treeNode *third;
 };

typedef struct treeNode TREE_NODE;
typedef TREE_NODE *TERNARY_TREE;

/* ------------- forward declarations --------------------------- */

TERNARY_TREE create_node(int, int, TERNARY_TREE, TERNARY_TREE, TERNARY_TREE);
#ifdef DEBUG
void PrintTree(TERNARY_TREE t);
#else
void WriteCode(TERNARY_TREE t);
#endif

/* ------------- symbol table definition --------------------------- */

struct symTabNode
{
	char identifier[IDLENGTH];
};

typedef struct symTabNode SYMTABNODE;
typedef SYMTABNODE *SYMTABNODEPTR;

SYMTABNODEPTR symTab[SYMTABSIZE];

int currentSymTabSize = 0;

%}

%start program

%union
{
	int iVal;
	TERNARY_TREE tVal;
}

%token	NEWLINE PLUS TIMES MINUS DIVIDE BRA KET COLON SEMI COMMA CAST EQUALS
		GET LT GT GORE LORE FULL DECLARATIONS IS BY TO OF IF THEN ELSE ENDIF
		ENDDO DO CODE ENDP WHILE ENDWHILE FOR ENDFOR WRITE READ AND OR NOT

%token 	<iVal> 	ID CHAR_CONST NUMBER REAL TYPE
%type 	<tVal>	program block variable declaration_block type statement_list
				statement assignment_statement if_statement do_statement
				while_statement for_statement write_statement read_statement
				conditional output_list expression comparator term value
				constant number_constant

%%
program:
	ID COLON block ENDP ID FULL
	{
		TERNARY_TREE ParseTree;
		ParseTree = create_node(NOTHING, PROGRAM, $3, NULL, NULL);
#ifdef DEBUG
		PrintTree(ParseTree);
#else
		WriteCode(ParseTree);
#endif
	};

block:
	DECLARATIONS declaration_block CODE statement_list
	{
		$$ = create_node(NOTHING, BLOCK, $2, $4, NULL);
	}
	| CODE statement_list
	{
		$$ = create_node(NOTHING, BLOCK, $2, NULL, NULL);
	};

declaration_block:
	variable OF TYPE type SEMI
	{
		$$ = create_node(NOTHING, DECLARATION_BLOCK, $1, $4, NULL);
	}
	| variable OF TYPE type SEMI declaration_block
	{
		$$ = create_node(NOTHING, DECLARATION_BLOCK, $1, $4, $6);
	};

variable:
	ID
	{
		$$ = create_node($1, VARIABLE, NULL, NULL, NULL);
	}
	| ID COMMA variable
	{
		$$ = create_node($1, VARIABLE, $3, NULL, NULL);
	};

type:
	NUMBER
	{
		$$ = create_node($1, INT_TYPE, NULL, NULL, NULL);
	};
	| REAL
	{
		$$ = create_node($1, REAL_TYPE, NULL, NULL, NULL);
	};
	| CHAR_CONST
	{
		$$ = create_node($1, CHAR_TYPE, NULL, NULL, NULL);
	};

statement_list:
	statement
	{
		$$ = create_node(NOTHING, STATEMENT_LIST, $1, NULL, NULL);
	}
	| statement SEMI statement_list
	{
		$$ = create_node(NOTHING, STATEMENT_LIST, $1, $3, NULL);
	};

statement:
	assignment_statement
	{
		$$ = create_node(NOTHING, STATEMENT, $1, NULL, NULL);
	}
	| if_statement
	{
		$$ = create_node(NOTHING, STATEMENT, $1, NULL, NULL);
	}
	| do_statement
	{
	    $$ = create_node(NOTHING, STATEMENT, $1, NULL, NULL);
	}
	| while_statement
	{
		$$ = create_node(NOTHING, STATEMENT, $1, NULL, NULL);
	}
	| for_statement
	{
	    $$ = create_node(NOTHING, STATEMENT, $1, NULL, NULL);
	}
	| write_statement
	{
		$$ = create_node(NOTHING, STATEMENT, $1, NULL, NULL);
	}
	| read_statement
	{
	    $$ = create_node(NOTHING, STATEMENT, $1, NULL, NULL);
	};

assignment_statement:
	expression CAST ID
	{
	    $$ = create_node(NOTHING, ASSIGNMENT_STATEMENT, $1, NULL, NULL);
	};

if_statement:
	IF conditional THEN statement_list ELSE statement_list ENDIF
	{
		$$ = create_node(NOTHING, IF_STATEMENT, $2, $4, $6);
	};
	| IF conditional THEN statement_list ENDIF
	{
		$$ = create_node(NOTHING, IF_STATEMENT, $2, $4, NULL);
	};

do_statement:
	DO statement_list WHILE conditional ENDDO
	{
		$$ = create_node(NOTHING, DO_STATEMENT, $2, $4, NULL);
	};

while_statement:
	WHILE conditional DO statement_list ENDWHILE
	{
		$$ = create_node(NOTHING, WHILE_STATEMENT, $2, $4, NULL);
	};

for_statement:
	FOR ID IS expression BY expression TO expression DO statement_list ENDFOR
	{
		$$ = create_node(NOTHING, FOR_STATEMENT, $4, $6, $10);
	};

write_statement:
	WRITE BRA output_list KET
	{
		$$ = create_node(NOTHING, WRITE_STATEMENT, $3, NULL, NULL);
	};
	| NEWLINE
	{
		$$ = create_node(NOTHING, WRITE_STATEMENT, NULL, NULL, NULL);
	};

read_statement:
	READ BRA ID KET
	{
		$$ = create_node($3, READ_STATEMENT, NULL, NULL, NULL);
	};

output_list:
	value
	{
		$$ = create_node(NOTHING, OUTPUT_LIST, $1, NULL, NULL);
	}
	| value COMMA output_list
	{
		$$ = create_node(NOTHING, OUTPUT_LIST, $1, $3, NULL);
	};

conditional:
	expression comparator expression
	{
		$$ = create_node(NOTHING, CONDITIONAL, $1, $2, $3);
	}
	| expression comparator expression AND conditional
	{
		$$ = create_node(NOTHING, CONDITIONAL, $1, $2, $5);
	}
    | expression comparator expression OR conditional
	{
		$$ = create_node(NOTHING, CONDITIONAL,  $1, $2, $5);
	}
    | NOT conditional
	{
		$$ = create_node(NOTHING, CONDITIONAL, $2, NULL, NULL);
	};

comparator:
	EQUALS
	{
		$$ = create_node(EQUALS, RELOP, NULL, NULL, NULL);
	};
	| GET
	{
		$$ = create_node(GET, RELOP, NULL, NULL, NULL);
	};
	| LT
	{
		$$ = create_node(LT, RELOP, NULL, NULL, NULL);
	};
	| GT
	{
		$$ = create_node(GT, RELOP, NULL, NULL, NULL);
	};
	| GORE
	{
		$$ = create_node(GORE, RELOP, NULL, NULL, NULL);
	};
	| LORE
	{
		$$ = create_node(LORE, RELOP, NULL, NULL, NULL);
	};

expression:
	term
	{
		$$ = create_node(NOTHING, EXPRESSION, $1, NULL, NULL);
	};
	| term PLUS expression
	{
		$$ = create_node(PLUS, EXPRESSION, $1, NULL, $3);
	};
	| term MINUS expression
	{
		$$ = create_node(MINUS, EXPRESSION, $1, NULL, $3);
	};

term:
	value
	{
		$$ = create_node(NOTHING, TERM, $1, NULL, NULL);
	};
	| value TIMES term
	{
		$$ = create_node(TIMES, TERM, $1, $3, NULL);
	};
	| value DIVIDE term
	{
		$$ = create_node(DIVIDE, TERM, $1, $3, NULL);
	};

value:
	ID
	{
		$$ = create_node($1, ID_VALUE, NULL, NULL, NULL);
		/* idk if ID should be done this way */
	};
	| constant
	{
		$$ = create_node(NOTHING, VAL_CONST, $1, NULL, NULL);
	};
	| BRA expression KET
	{
		$$ = create_node(NOTHING, VALUE, $2, NULL, NULL);
	};

constant:
	number_constant
	{
		$$ = create_node(NOTHING, CONST, NULL, NULL, NULL);
	};
	| CHAR_CONST
	{
		$$ = create_node($1, CONST, NULL, NULL, NULL);
	};

number_constant:
	NUMBER
	{
		$$ = create_node($1, NUM_CONST, NULL, NULL, NULL);
	};
	| MINUS NUMBER
	{
		$$ = create_node($2, NUM_CONST, NULL, NULL, NULL);
	};
	| MINUS NUMBER FULL NUMBER
	{
		$$ = create_node($2, NUM_CONST, NULL, NULL, NULL);
	};
	| NUMBER FULL NUMBER
	{
		$$ = create_node($1, NUM_CONST, NULL, NULL, NULL);
	};

%%

TERNARY_TREE create_node(int ival, int case_identifier, TERNARY_TREE p1,
						TERNARY_TREE p2, TERNARY_TREE p3)
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

#ifdef DEBUG
void PrintTree(TERNARY_TREE t)
{
	if (t == NULL) return;
	if (t->item != NOTHING)
	{
		if (t->nodeIdentifier == VARIABLE)
			printf("ID: %s | ", symTab[t->item]);
		else if (t->nodeIdentifier == CONST)
			printf("Char: %c | ", t->item);
		else
		{
			printf("Unknown Item: %d, ", t->item);
		}
	}
	if (t->nodeIdentifier < 0 || t->nodeIdentifier > sizeof(NodeName))
		printf("Unknown nodeIdentifier: %d\n", t->nodeIdentifier);
	else
		printf("nodeIdentifier: %s\n", NodeName[t->nodeIdentifier]);
	PrintTree(t->first);
	PrintTree(t->second);
	PrintTree(t->third);
}
#else
void WriteCode(TERNARY_TREE t)
{
	if (t == NULL) return;

	switch(t->nodeIdentifier)
        {
			case(PROGRAM):
				printf("#include <stdio.h>\n\n");
				printf("int main(void)\n{\n");
				WriteCode(t->first);
				printf("}\n");
				return;
			case(WRITE_STATEMENT):
				printf("printf(\"");
				if (t->first == NULL) printf("\\n");
				else WriteCode(t->first);
				printf("\");\n");
				return;
			case(READ_STATEMENT):
				printf("scanf(\"%%d\", &");
				printf("%s", symTab[t->item]);
				printf(");\n");
				return;
			case(IF_STATEMENT):
				printf("if (");
				if (t->first != NULL) WriteCode(t->first);
				printf(")\n{\n");
				if (t->second != NULL) WriteCode(t->second);
				printf("}\n");
				if (t->third != NULL)
				{
					printf("else\n{\n");
					WriteCode(t->third);
					printf("}\n");
				}
				return;
			case(CONST):
				if (t->first == NULL) printf("%c", t->item);
				else WriteCode(t->first);
				return;
			case(VARIABLE):
				printf("%s", symTab[t->item]);
				if (t->first != NULL)
				{
					printf(", ");
					WriteCode(t->first);
				}
				return;
			case(INT_TYPE):
				printf("int ");
				return;
			case(REAL_TYPE):
				printf("float ");
				return;
			case(CHAR_TYPE):
				printf("char* ");
				return;
			case(DECLARATION_BLOCK):
				WriteCode(t->second);
				WriteCode(t->first);
				printf(";\n");
				if (t->third != NULL) WriteCode(t->third);
				return;
			case(CONDITIONAL):
				WriteCode(t->first);
				WriteCode(t->second);
				WriteCode(t->third);
				return;
			case(RELOP):
				switch (t->nodeIdentifier)
				{
					case(EQUALS):
						printf(" = ");
						return;
					case(GET):
						printf(" <> ");
						return;
					case(LT):
						printf(" < ");
						return;
					case(GT):
						printf(" > ");
						return;
					case(LORE):
						printf(" <= ");
						return;
					case(GORE):
						printf(" >= ");
						return;
				}
				return;
			case(EXPRESSION):
				WriteCode(t->first);
				switch (t->nodeIdentifier)
				{
					case(PLUS):
						printf(" + ");
						return;
					case(MINUS):
						printf(" - ");
						return;
				}
				if (t->second != NULL) WriteCode(t->second);
				return;
			case(TERM):
				WriteCode(t->first);
				switch (t->nodeIdentifier)
				{
					case(TIMES):
						printf(" * ");
						return;
					case(DIVIDE):
						printf(" / ");
						return;
				}
				if (t->second != NULL) WriteCode(t->second);
				return;
        }
	WriteCode(t->first);
	WriteCode(t->second);
	WriteCode(t->third);
}
#endif

#include "lex.yy.c"
