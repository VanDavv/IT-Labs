#!/usr/bin/env bash
nvcc -arch=sm_60 -cubin kernel2.ptx
gcc -I /usr/local/cuda/include -o lab05_2.out lab05_2.c -lcuda -lm -Wno-deprecated-declarations
./lab05_2.out