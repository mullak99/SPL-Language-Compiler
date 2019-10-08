%{
#ifdef PRINT
#define TOKEN(t) printf("Token: " #t "\n");
#else
#define TOKEN(t) return(t);
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
\n              TOKEN(NEWLINE);
"+"             TOKEN(PLUS);
"-"				TOKEN(MINUS);
"*"             TOKEN(TIMES);
"/"				TOKEN(DIVIDE);
"<"             TOKEN(LT);
">"             TOKEN(GT);
";"             TOKEN(SEMICOLON);
"->"			TOKEN(ASSIGNMENT);
"("             TOKEN(BRA);
")"             TOKEN(KET);
"'"				TOKEN(APOS);
":="			TOKEN(ASSIGN);

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
                  TOKEN(NUMBER);
                }
