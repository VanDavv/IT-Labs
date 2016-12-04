#!/bin/bash

read -p "n: " n
read -p "x: " x

let counter=0

while(( $counter < $n ));
do
    read -p "Dodaj: " a
    let arr[counter]=a
    let counter=counter+1
done

let result=0

for i in "${arr[@]}"
do
    if (($x == $i)); then
        let result+=1
    fi
done

echo "$result"

