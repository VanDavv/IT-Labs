cc=gcc

main.out: main.c
	${cc} main.c -g -o main.out

valgrind: main.out
	valgrind --leak-check=full -v ./main.out abcd1234
