#!/bin/bash

read -p "n: " n

let counter=0
let result=0

while(( $counter < $n ));
do
    read -p "[$result] Dodaj: " a
    let result=result+a
    let counter=counter+1
done

echo "Suma $result"


