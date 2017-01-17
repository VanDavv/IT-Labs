#!/bin/bash

read -p "a11:" a_11
read -p "a12:" a_12
read -p "a21:" a_21
read -p "a22:" a_22
read -p "b1:" b_1
read -p "b2:" b_2

w=$(bc <<< "$a_11*$a_22-$a_12*$a_21")
w_x=$(bc <<< "$b_1*$a_22-$a_12*$b_2")
w_y=$(bc <<< "$a_11*$b_2-$b_1*$a_21")

if (($w != 0)); then
    echo "Posiada jedno rozwiązanie"
else
    if (($w_x != 0 || $w_y != 0)); then
        echo "Układ jest sprzeczny"
    else
        echo "Układ jest nieoznaczony"
    fi
fi

