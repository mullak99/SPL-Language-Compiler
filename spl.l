%{
#ifdef PRINT
#define TOKEN(t) printf("Token: " #t "\n");
#define NUMBER_TOKEN(t) printf("Number %d Token: " #t "\n", atoi(yytext));
#define CHAR_TOKEN(t) printf("Char %s Token: " #t "\n", yytext);
#define ID_TOKEN(t) printf("ID %s Token: " #t "\n", yytext);
#else
#define TOKEN(t) return(t);
#define NUMBER_TOKEN(t) yylval.iVal = atoi(yytext); return(t);
#define CHAR_TOKEN(t) return(t);
#define ID_TOKEN(t) yylval.iVal = installId(yytext); return(t);
#endif
%}

delim           [ \t\r]
ws              {delim}+
character      	[A-Za-z]
digit           [0-9]
id			    {character}({character}|{digit})*
number          {digit}+
char_const      '{character}'

%%

{ws}            ; /* Do Nothing */
\n              ; /* Do Nothing */
"+"             TOKEN(PLUS);
"-"				TOKEN(MINUS);
"*"             TOKEN(TIMES);
"/"				TOKEN(DIVIDE);
"<"             TOKEN(LT);
">"             TOKEN(GT);
"<>"			TOKEN(GET);
"->"            TOKEN(CAST);
":" 	      	TOKEN(COLON);
";"             TOKEN(SEMI);
"("             TOKEN(BRA);
")"             TOKEN(KET);
"." 			TOKEN(FULL);
"," 			TOKEN(COMMA);
">="			TOKEN(GORE);
"<="			TOKEN(LORE);
"="             TOKEN(EQUALS);
"NEWLINE" 		TOKEN(NEWLINE);

DECLARATIONS 	TOKEN(DECLARATIONS);
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
AND				TOKEN(AND);
OR				TOKEN(OR);
NOT				TOKEN(NOT);
WRITE        	TOKEN(WRITE);
READ			TOKEN(READ);
CODE			TOKEN(CODE);
ENDP			TOKEN(ENDP)
OF              TOKEN(OF);
TYPE            TOKEN(TYPE);
BY              TOKEN(BY);
IS              TOKEN(IS);
TO              TOKEN(TO);

INTEGER         TOKEN(NUMBER);
CHARACTER       TOKEN(CHAR_CONST);
REAL            TOKEN(REAL)

{id}            ID_TOKEN(ID);
{char_const}    CHAR_TOKEN(CHAR_CONST);
{number}		NUMBER_TOKEN(NUMBER);

%%

#ifndef PRINT
SYMTABNODEPTR newSymTabNode()
{
    return ((SYMTABNODEPTR)malloc(sizeof(SYMTABNODE)));
}

int lookup(char *s)
{
    extern SYMTABNODEPTR symTab[SYMTABSIZE];
    extern int currentSymTabSize;
    int i;

    for (i = 0; i < currentSymTabSize; i++)
    {
		if (strncmp(s,symTab[i]->identifier,IDLENGTH) == 0)
            return (i);
    }
    return (-1);
}

int installId(char *id)
{
    extern SYMTABNODEPTR symTab[SYMTABSIZE];
    extern int currentSymTabSize;
    int index;

    index = lookup(id);
    if (index >= 0)
        return (index);
    else if (currentSymTabSize >= SYMTABSIZE)
        return (NOTHING);
    else
    {
       symTab[currentSymTabSize] = newSymTabNode();
       strncpy(symTab[currentSymTabSize]->identifier,id,IDLENGTH);
       symTab[currentSymTabSize]->identifier[IDLENGTH-1] = '\0';
       return(currentSymTabSize++);
    }
}
#endif
