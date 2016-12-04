#!/bin/bash

read -p "n: " n

let result=1
while(( $n > 1 ));
do
    let result=result*n
    let n=n-1
done

echo "Wynik $result"


