#!/usr/bin/env bash
nvcc -arch=sm_60 -cubin kernel.ptx
gcc -I /usr/local/cuda/include -o lab05.out lab05.c -lcuda -lm -Wno-deprecated-declarations
./lab05.out