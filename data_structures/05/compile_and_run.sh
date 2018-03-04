#!/bin/bash

gcc 40016.sdizo.lab05.AVL.c -o lab05.out &&
    ./lab05.out 10000 0 &&
    ./lab05.out 15000 0 &&
    ./lab05.out 20000 0 &&
    ./lab05.out 25000 0 &&
    ./lab05.out 30000 0

gcc 40016.sdizo.lab05.BST.c -o lab05.out &&
    ./lab05.out 10000 0 &&
    ./lab05.out 15000 0 &&
    ./lab05.out 20000 0 &&
    ./lab05.out 25000 0 &&
    ./lab05.out 30000 0

gcc 40016.sdizo.lab05.list.c -o lab05.out &&
    ./lab05.out 10000 0 &&
    ./lab05.out 15000 0 &&
    ./lab05.out 20000 0 &&
    ./lab05.out 25000 0 &&
    ./lab05.out 30000 0
    
gcc 40016.sdizo.lab05.AVL.c -o lab05.out &&
    ./lab05.out 10000 1 &&
    ./lab05.out 15000 1 &&
    ./lab05.out 20000 1 &&
    ./lab05.out 25000 1 &&
    ./lab05.out 30000 1

gcc 40016.sdizo.lab05.BST.c -o lab05.out &&
    ./lab05.out 10000 1 &&
    ./lab05.out 15000 1 &&
    ./lab05.out 20000 1 &&
    ./lab05.out 25000 1 &&
    ./lab05.out 30000 1

gcc 40016.sdizo.lab05.list.c -o lab05.out &&
    ./lab05.out 10000 1 &&
    ./lab05.out 15000 1 &&
    ./lab05.out 20000 1 &&
    ./lab05.out 25000 1 &&
    ./lab05.out 30000 1
