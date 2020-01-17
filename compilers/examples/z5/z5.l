%{
#include <stdlib.h>
#include <string.h>
#include "def.tab.h"
#define INFILE_ERROR 1
#define OUTFILE_ERROR 2
extern int yylineno;
int yyerror(char *,...);
%}
%%
\+			{fprintf(yyout, "+\n");return '+';} 
\*			{fprintf(yyout, "*\n");return '*';}
\(			{fprintf(yyout, "(\n");return '(';}
\)			{fprintf(yyout, ")\n");return ')';}
\/			{fprintf(yyout, "/\n");return '/';}
\-			{fprintf(yyout, "-\n");return '-';}
\^			{fprintf(yyout, "^\n");return '^';}
\=			{
				fprintf(yyout, "^\n");
				return '=';
			}
[1-9][0-9]*		{
				fprintf(yyout, "liczba\n");
				yylval.ival = atoi(yytext);
				return LC;
			}	
[A-Za-z_][A-Za-z0-9_]*	{
				fprintf(yyout, "nazwa\n");
				yylval.text = strdup(yytext);
				return ID;
			}
[1-9]+[.]{2}		{fprintf(yyout, "dziwne\n");}
\ |\t			{;}
\n			{yylineno++;}
.			{yyerror("Blad leksykalny\n");}
%%
int yyerror(char *msg,...)
{
	printf("%d: %s", yylineno, msg);
	exit(1);
}

