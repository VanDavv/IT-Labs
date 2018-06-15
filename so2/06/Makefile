cc=gcc

first.out: first.c
	${cc} first.c -lcrypt -g -o first.out

valgrind-first: first.out
	valgrind --leak-check=full -v ./first.out

second.out: second.c
	${cc} second.c -o second.out -lcrypt -lpthread
