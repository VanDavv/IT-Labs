#!/bin/bash

read -p "n: " n
read -p "b: " b

let counter=0
let result=0
while(( $counter < $n ));
do
    read -p "Liczba: " a

    if (($b == $a)); then
        let result=result+1
    fi

    let counter=counter+1
done

echo "Wystąpień $result"


