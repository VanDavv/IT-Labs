#!/bin/bash
for i in {3..100}
    do
        ./compile_and_run.sh > result${i}.txt
    done