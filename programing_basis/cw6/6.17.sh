#!/bin/bash

read -p "n: " n
read -p "b: " b

let counter1=0
let counter2=0

while(( $[counter1 + counter2] < $n ));
do
    read -p "Dodaj: " a
    if (( $a > $b )); then
        let arr1[counter1]=a
        let counter1+=1
    elif (( $a < $b )); then
        let arr2[counter2]=a
        let counter2+=1
    else
        let n-=1
    fi
done

echo "${arr1[@]} , ${arr2[@]}"

