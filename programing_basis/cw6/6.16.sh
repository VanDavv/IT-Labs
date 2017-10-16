#!/bin/bash

read -p "n: " n

let counter=0

while(( $counter < $n ));
do
    read -p "Dodaj: " a
    let arr[counter]=a
    let counter=counter+1
done

let is25=0
let is32=0
let result=0

for i in "${arr[@]}"
do
    if (( ( $is25 == 1 && $i == 32 ) || ( $is32 == 1 && $i == 25 ) )); then
        let result+=1
        let is25=0
        let is32=0
    elif (( $i == 25 )); then
        let is25=1
    elif (( $i == 32 )); then
        let is32=1
    else
        let is25=0
        let is32=0
    fi
done

echo "$result"

