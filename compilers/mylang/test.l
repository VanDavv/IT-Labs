%{

#include <stdio.h>
#include <string.h>
#include "test.tab.h"
void showError();
%}


numbers     ([0-9])+
alpha       ([a-zA-Z])+
mixed       ([a-zA-Z0-9])+

%%

{alpha}			   {sscanf(yytext, "%s", yylval.name); return (STRING);}
{numbers}      {yylval.number = atoi(yytext); return (NUM);}
";"      		   {return (SEMICOLON);}
{mixed}			   {sscanf(yytext, "%s", yylval.name); return (MIXED);}
.      		     {showError(); return(OTHER);}

%%


void showError(){
    printf("Other input");
}
