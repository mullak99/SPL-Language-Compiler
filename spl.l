%{
#ifdef PRINT
#define TOKEN(t) printf("Token: " #t "\n");
#define NUMBER_TOKEN(t) printf("Number %d Token: " #t "\n", atoi(yytext));
#define ID_TOKEN(t) printf("ID %s Token: " #t "\n", yytext);
#else
#define TOKEN(t) return(t);
#define NUMBER_TOKEN(t) yylval.iVal = atoi(yytext); return(t);
#define ID_TOKEN(t) return(t);
#endif
%}

delim           [ \t\r]
ws              {delim}+
character      	[A-Za-z]
digit           [0-9]
id			    {character}({character}|{digit})*
number          {digit}+
%%

				int k;
{ws}            ; /* Do Nothing */
{id}            ID_TOKEN(ID);
\n              TOKEN(NEWLINE);
"+"             TOKEN(PLUS);
"-"				TOKEN(MINUS);
"*"             TOKEN(TIMES);
"/"				TOKEN(DIVIDE);
"<"             TOKEN(LT);
">"             TOKEN(GT);
"<>"			TOKEN(GET);
":" 	      	TOKEN(COLON);
";"             TOKEN(SEMICOLON);
"->"			TOKEN(ASSIGNMENT);
"("             TOKEN(BRA);
")"             TOKEN(KET);
"'"				TOKEN(APOS);
":="			TOKEN(ASSIGN);
"." 			TOKEN(FULL);
"," 			TOKEN(COMMA);
"=>"			TOKEN(GORE);
"=<"			TOKEN(LORE);

IF             	TOKEN(IF);
ENDIF           TOKEN(ENDIF);
THEN           	TOKEN(THEN);
ELSE           	TOKEN(ELSE);
WHILE           TOKEN(WHILE);
ENDWHILE        TOKEN(ENDWHILE);
DO             	TOKEN(DO);
ENDDO           TOKEN(ENDDO);
FOR           	TOKEN(FOR);
ENDFOR          TOKEN(ENDFOR);
WRITE			TOKEN(WRITE);
READ			TOKEN(READ);
AND				TOKEN(AND);
OR				TOKEN(OR);
NOT				TOKEN(NOT);

{number}        {
                  k = atoi(yytext) ;
                  NUMBER_TOKEN(NUMBER);
                }
