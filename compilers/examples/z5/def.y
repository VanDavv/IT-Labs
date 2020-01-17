%{
#include <string.h>
#include <stdio.h>
#define INFILE_ERROR 1
#define OUTFILE_ERROR 2
%}
%union 
{char *text;
int	ival;};
%type <text> wyr
%token <text> ID
%token <ival> LC
%left '+' '-'
%left '*' '/'
%start wyr
%%
wyr
	:wyr '+' skladnik	{printf("wyrazenie z + \n");}
	|wyr '-' skladnik	{printf("wyrazenie z - \n");}
	|skladnik		{printf("wyrazenie pojedyncze \n");}
	;
skladnik
	:skladnik '*' czynnik	{printf("skladnik z * \n");}
	|skladnik '/' czynnik	{printf("skladnik z / \n");}
	|czynnik		{printf("skladnik pojedynczy \n");}
	;
czynnik
	:ID			{printf("czynnik znakowy\n");} 
	|LC			{printf("czynnik liczbowy\n");}
	|'(' wyr ')'		{printf("wyrazenie w nawiasach\n");}
	;
%%
int main(int argc, char *argv[])
{
	yyparse();
	return 0;
}
