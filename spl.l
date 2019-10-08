delim           [ \t\r]
ws              {delim}+
character      	[A-Za-z]
digit           [0-9]
id			    {character}({character}|{digit})*
number          {digit}+
%%

				int k;
{ws}            ; /* Do Nothing */
{id}			printf("identifier: %s\n",yytext);
\n              printf("binaryOp: NEWLINE\n");
"+"             printf("binaryOp: PLUS\n");
"-"				printf("binaryOp: MINUS\n");
"*"             printf("binaryOp: TIMES\n");
"/"				printf("binaryOp: DIVIDE\n");
"<"             printf("relop: LT\n");
">"             printf("relop: GT\n");
";"             printf("separator: SEMICOLON\n");
"->"			printf("separator: ASSIGNMENT\n");
"("             printf("keyword: BRA\n");
")"             printf("keyword: KET\n");
"'"				printf("separator: APOS\n");
":="			printf("assignment\n");

IF             	printf("keyword: IF\n");
ENDIF           printf("keyword: ENDIF\n");
THEN           	printf("keyword: THEN\n");
ELSE           	printf("keyword: ELSE\n");
WHILE           printf("keyword: WHILE\n");
ENDWHILE        printf("keyword: ENDWHILE\n");
DO             	printf("keyword: DO\n");
ENDDO           printf("keyword: ENDDO\n");
FOR           	printf("keyword: FOR\n");
ENDFOR          printf("keyword: ENDFOR\n");
WRITE			printf("keyword: WRITE\n");
READ			printf("keyword: READ\n");
THEN			printf("keyword: THEN\n");
AND				printf("keyword: AND\n");
OR				printf("keyword: OR\n");
NOT				printf("keyword: NOT\n");

{number}        {
                  k = atoi(yytext) ;
                  printf("number: %d\n", k);
                }
