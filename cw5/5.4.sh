#!/bin/bash

read -p "n: " n

let counter=0
let result="brak"
while(( $counter < $n ));
do
    read -p "Liczba: " a

    if (( $result == "brak" || $result > $a)); then
        let result=a
    fi

    let counter=counter+1
done

echo "Minimum $result"


