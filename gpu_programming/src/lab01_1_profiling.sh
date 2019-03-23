#!/usr/bin/env bash

for n_elements in 10 100 500 1000 5000 10000 50000 100000 500000 1000000 5000000 10000000 50000000 100000000; do
    nvprof --print-gpu-summary python lab01_1.py ${n_elements};
done
