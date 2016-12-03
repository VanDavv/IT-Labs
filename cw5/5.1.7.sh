#!/bin/bash

let result=1
while(( 1 ));
do
    read -p "Liczba: " a

    if (( $a == 0)); then
        break
    else
        let result=result*a
    fi
done

echo "Iloczyn $result"


