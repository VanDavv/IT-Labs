#!/bin/bash

flex z1.l
gcc -c lex.yy.c
gcc lex.yy.o -o compiler -lfl
./compiler < in.txt