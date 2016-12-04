#!/bin/bash

read -p "n: " n

let counter=0

while(( $counter < $n ));
do
    read -p "Dodaj: " a
    let arr[counter]=a
    let counter=counter+1
done

let min="brak"
let max="brak"

for i in "${arr[@]}"
do
    if (($min == "brak" || $i < $min)); then
        let min=i
    fi
    if (($max == "brak" || $i > $max)); then
        let max=i
    fi
done

echo "$min - $max"

