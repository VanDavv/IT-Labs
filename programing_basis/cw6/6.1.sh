#!/bin/bash

read -p "n: " n

let counter=0

while(( $counter < $n ));
do
    read -p "Dodaj: " a
    let result[counter]=a
    let counter=counter+1
done

echo "${result[@]}"
echo "${result[@]}" > 6.1.txt


