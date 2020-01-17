CC=gcc
LEX=flex
YACC=bison
LD=gcc

all:	leks

leks:	lex.yy.o
	$(CC) lex.yy.o -o leks -lfl

lex.yy.o:	lex.yy.c
	$(CC) -c lex.yy.c

lex.yy.c: z4.l
	$(LEX) -d -T z4.l

clean:
	rm *.o leks
