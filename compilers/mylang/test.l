%{
 #include "test.tab.h"
 #include <stdlib.h>
 void yyerror(char *);
%}
%%

[!] {
 return T_INT;
}
[?] {
 return T_DOUBLE;
}
[0-9]+\.[0-9]+ {
 yylval = strtod(yytext, NULL);
 return DOUBLE;
}
[a-z] {
 yylval = *yytext - 'a';
 return VARIABLE;
 }
[0-9]+ {
 yylval = atoi(yytext);
 return INTEGER;
 }
[-+()/=*\n] { return *yytext; }
[ \t] ;
. yyerror("Unknown character");
%%

int yywrap(void) {
  return 1;
}