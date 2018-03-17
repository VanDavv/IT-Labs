cc=gcc

main.out: main.c
	${cc} main.c -g -o main.out

valgrind: main.out
	valgrind -v ./main.out -ab
