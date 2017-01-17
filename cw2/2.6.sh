#!/bin/bash

read -p "x:" x

if (($x > 0)); then
    echo "sgnx = 1"
elif (( $x == 0)); then
    echo "sgnx = 0"
else
    echo "sgnx = -1"
fi

