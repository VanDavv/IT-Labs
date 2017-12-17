#!/bin/bash

gcc 40016.sdizo.lab05.AVL.c -o list.out &&
    ./list.out 10000 0 &&
    ./list.out 15000 0 &&
    ./list.out 20000 0
