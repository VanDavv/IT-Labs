#!/bin/bash

read -p "n: " n

let counter=0

while(( $counter < $n ));
do
    read -p "Dodaj: " a
    let arr[counter]=a
    let counter=counter+1
done

let result=0

for i in "${!arr[@]}"
do
    if (($i % 2 == 0)); then
        let result=result+arr[i]
    fi
done

echo "$result"

