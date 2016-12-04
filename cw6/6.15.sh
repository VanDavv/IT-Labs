#!/bin/bash

read -p "n: " n

let counter=0

while(( $counter < $n ));
do
    read -p "Dodaj: " a
    let arr[counter]=a
    let counter=counter+1
done

for i in "${!arr[@]}"
do
    let result[i]=arr[$[${#arr[@]} - $i - 1]]
done

echo "${result[@]}"

