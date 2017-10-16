#!/bin/bash

read -p "n1: " n

let counter=0

while(( $counter < $n ));
do
    read -p "Dodaj1: " a
    let arr1[counter]=a
    let counter=counter+1
done

read -p "n2: " n

let counter=0

while(( $counter < $n ));
do
    read -p "Dodaj2: " a
    let arr2[counter]=a
    let counter=counter+1
done


for i in "${!arr1[@]}"
do
    let result[i]=arr1[i]+arr2[i]
done
echo "${result[@]}"
