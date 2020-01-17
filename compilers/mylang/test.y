%{
 #include <stdio.h>
 void yyerror(char *);
 int yylex(void);
 int symInt[26];
 double symDouble[26];
%}
%token INTEGER VARIABLE T_INT T_DOUBLE DOUBLE
%left '+' '-' '*'
%%
program:
 program statement '\n'
 | /* NULL */
 ;
statement:
 expression {
   printf("%d\n", $1);
 }
 | T_INT VARIABLE '=' expression { symInt[$2] = $4; }
 | T_DOUBLE VARIABLE '=' expression { symDouble[$2] = $4; }
 ;
expression:
 INTEGER
 | DOUBLE
 | T_INT VARIABLE { $$ = symInt[$2]; }
 | T_DOUBLE VARIABLE { $$ = symDouble[$2]; }
 | '-' expression { $$ = -$2; }
 | expression '+' expression { $$ = $1 + $3; }
 | expression '-' expression { $$ = $1 - $3; }
 | expression '*' expression { $$ = $1 * $3; }
 | expression '/' expression { $$ = $1 / $3; }
 | '(' expression ')' { $$ = $2; }
 ;
%%
void yyerror(char *s) {
 fprintf(stderr, "%s\n", s);
}
int main(void) {
 yyparse();
}