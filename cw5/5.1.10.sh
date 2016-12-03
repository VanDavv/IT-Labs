#!/bin/bash

read -p "n: " n
read -p "k: " k

echo "scale=2; $(seq -s "*" 1 $n |bc)/$[$(seq -s "*" 1 $k |bc) * $(seq -s "*" 1 $[n-k] |bc)]" | bc


