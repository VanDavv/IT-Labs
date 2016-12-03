#!/bin/bash

read -p "a: " a
read -p "b: " b

let counter=0
let result=1
while(( $counter < $b ));
do
    let result=result*a
    let counter=counter+1
done

echo "Wynik $result"


