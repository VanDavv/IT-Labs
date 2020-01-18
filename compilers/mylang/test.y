%{
 #include <stdio.h>
 void yyerror(char *);
 int yylex(void);
 int symInt[26];
 float symDouble[26];
%}
%token INTEGER VARIABLE T_INT T_DOUBLE DOUBLE PRINT_INT PRINT_DOUBLE MARK_IF
%left '+' '-' '*'
%%
program:
 program statement '\n'
 | /* NULL */
 ;
statement:
 PRINT_INT expression {
   printf("%d\n", $2);
 }
 | PRINT_DOUBLE expression {
   printf("%f\n", $2);
 }
 | T_INT VARIABLE '=' expression { symInt[$2] = $4; }
 | T_DOUBLE VARIABLE '=' expression { symDouble[$2] = (float) $4; }
 ;
expression:
 INTEGER
 | DOUBLE
 | T_INT VARIABLE { $$ = symInt[$2]; }
 | T_DOUBLE VARIABLE { $$ = symDouble[$2]; }
 | MARK_IF '(' expression ')' '(' expression ')' {
  if($3 == 1) {
    $$ = $6;
  } else {
    $$ = -1;
  }
 }
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