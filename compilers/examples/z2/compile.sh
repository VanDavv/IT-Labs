#!/bin/bash

flex z2.l
gcc -c lex.yy.c
gcc lex.yy.o -o compiler -lfl
./compiler < in1.txt