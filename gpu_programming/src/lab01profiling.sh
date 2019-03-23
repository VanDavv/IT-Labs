#!/usr/bin/env bash

for n_elements in 10 100 500 1000 5000 10000 50000 100000; do
    nvprof --print-gpu-summary python lab01.py ${n_elements};
done
