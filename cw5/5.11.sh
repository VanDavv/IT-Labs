#!/bin/bash

let result=0
let last=0
while(( 1 ));
do
    read -p "liczba: " a

    if (($last == 25 && $a == 10)); then
        let result=result-last
        break
    fi

    let result=result+a
    let last=a
done

echo "Wynik $result"


