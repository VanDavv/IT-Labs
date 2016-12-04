#!/bin/bash

read -p "text: " s
read -p "char: " c

let counter=0

while (( $counter < ${#s}));
do
    if [ $c == ${s:$counter:1} ]; then
        let result+=1
    fi
    let counter+=1
done

echo "$result"
