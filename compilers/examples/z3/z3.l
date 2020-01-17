%{
#include <stdlib.h>
#include <string.h>
#include "def.tab.h"
extern int yylineno;
int yyerror(char *msg,...);
%}
%%
\+			{return '+';} 
\*			{return '*';}
\(			{return '(';}
\)			{return ')';}
\/			{return '/';}
\-			{return '-';}
\^			{return '^';}
[1-9][0-9]*		{printf("liczba\n"); yylval.ival = atoi(yytext);
			return LC;}	
[A-Za-z_][A-Za-z0-9_]*	{printf("nazwa\n"); yylval.text = strdup(yytext);
			return ID;}
\ |\t			{;}
\n			{yylineno++ ;}
.			{yyerror("B³±d leksykalny\n");}
%%
int yyerror(char *msg,...)
{
	printf("%d: %s", yylineno, msg);
	exit(1);
}
