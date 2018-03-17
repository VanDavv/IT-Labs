cc=gcc
sharedcompile=-c -fPIC -g
sharedbuild=-shared -fPIC -g

libuser.o: libuser.c
	${cc} ${sharedcompile} libuser.c

libuser.so.%: libuser.o
	${cc} ${sharedbuild} libuser.o -o $@ -nostartfiles
main.out: libuser.so.1.0 main.c
	${cc} main.c -g -o main.out -ldl
valgrind: main.out
	valgrind --leak-check=full ./main.out -ab
