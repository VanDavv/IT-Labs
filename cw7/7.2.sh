#!/bin/bash

read -p "text: " s
read -p "replace: " c
read -p "with: " x

let counter=0

while (( $counter < ${#s}));
do
    if [ $c == ${s:$counter:1} ]; then
        s=${s:0:$[counter]}$x${s:$[counter + 1]:${#s}}
        let counter+=${#x}
    fi
    let counter+=1
done

echo "$s"
