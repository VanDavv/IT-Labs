#!/bin/bash

read -p "n: " n

let counter=0

while(( $counter < $n ));
do
    read -p "Dodaj: " a
    let arr[counter]=a
    let counter=counter+1
done

let result="brak"

for i in "${arr[@]}"
do
    if (($result == "brak" || $i < $result)); then
        let result=i
    fi
done

echo "$result"

