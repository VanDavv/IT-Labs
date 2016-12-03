#!/bin/bash

let result=0

while(( $result < 100 ));
do
    read -p "[$result] Dodaj: " a
    let result=result+a
done

echo "Suma $result"


