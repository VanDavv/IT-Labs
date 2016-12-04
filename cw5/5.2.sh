#!/bin/bash

read -p "n: " n

let counter=0
let result=1

while(( $counter < $n ));
do
    read -p "[$result] Pomnóż: " a
    let result=result*a
    let counter=counter+1
done

echo "Iloczyn $result"


