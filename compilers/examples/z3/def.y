%{
#include <string.h>
#include <stdio.h>
%}
%union 
{char *text;
int	ival;};
%type <text> wyr
%token <text> ID
%token <ival> LC
%start wyr
%%
wyr:	ID|LC	{printf("trtr");}
%%