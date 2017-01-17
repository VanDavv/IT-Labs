#!/bin/bash

read -p "a:" a
read -p "b:" b
read -p "c:" c

delta=$(bc <<< "$b*$b-4*$a*$c")

if (($delta < 0)); then
    echo "brak pierwiastków"
elif(($delta == 0)); then
    x=$(bc <<< "-$b/2*$a")
    echo "Pierwiastki są w punkcie $x"
else
    delta_root=$(bc -l <<< "sqrt($delta)")
    x_1=$(bc <<< "(-$b-$delta_root)/2*$a")
    x_2=$(bc <<< "(-$b+$delta_root)/2*$a")
    echo "Pierwiastki są następujące: x_1 = ${x_1} , x_2 = ${x_2}"
fi

