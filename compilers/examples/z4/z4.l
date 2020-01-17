%{
#include <stdlib.h>
#include <string.h>
#define INFILE_ERROR 1
#define OUTFILE_ERROR 2
extern int yylineno;
int yyerror(char *,...);
%}
%%
\+			{fprintf(yyout, "+\n");} 
\*			{fprintf(yyout, "*\n");}
\(			{fprintf(yyout, "(\n");}
\)			{fprintf(yyout, ")\n");}
\/			{fprintf(yyout, "/\n");}
\-			{fprintf(yyout, "-\n");}
\^			{fprintf(yyout, "^\n");}
[1-9][0-9]*		{fprintf(yyout, "liczba\n");}	
[A-Za-z_][A-Za-z0-9_]*	{fprintf(yyout, "nazwa\n");}
[1-9]+[.]{2}		{fprintf(yyout, "dziwne\n");}
\ |\t			{;}
\n			{yylineno++;}
.			{yyerror("Błąd leksykalny\n");}
%%
int yyerror(char *msg,...)
{
	printf("%d: %s", yylineno, msg);
	exit(1);
}

int main(int argc, char *argv[])
{
	if (argc>1) 
	{
		yyin = fopen(argv[1], "r");
		if (yyin==NULL)
		{
			printf("Błąd\n");
			return INFILE_ERROR;
		}
		if (argc>2)
		{
			yyout=fopen(argv[2], "w");
			if (yyout==NULL)
			{
				printf("Błąd\n");
				return OUTFILE_ERROR;
			}
		}
	}
	yylex();
	return 0;
}
