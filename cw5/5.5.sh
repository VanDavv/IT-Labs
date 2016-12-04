#!/bin/bash

let result="brak"
while(( 1 ));
do
    read -p "Liczba: " a

    if (( $a == 0)); then
        break
    elif (( $result == "brak" || $result < $a)); then
        let result=a
    fi
done

echo "Maksimum $result"


