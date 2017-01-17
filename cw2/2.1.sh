#!/bin/bash

read -p "a:" a
read -p "b:" b

if (($a > 0)); then
    if (($b > 0)); then
        echo "przechodzi przez 1, 2 i 3 ćwiartkę"
    elif (($b == 0)); then
        echo "przechodzi przez 1 i 3 ćwiartkę"
    else
        echo "przechodzi przez 1, 3 i 4 ćwiartkę"
    fi
elif (($a == 0)); then
    if (($b > 0)); then
        echo "przechodzi przez 1, 2 ćwiartkę"
    elif (($b == 0)); then
        echo "nie przechodzi przez żadną"
    else
        echo "przechodzi przez 3 i 4 ćwiartkę"
    fi
else
    if (($b > 0)); then
        echo "przechodzi przez 1, 2 i 4 ćwiartkę"
    elif (($b == 0)); then
        echo "przechodzi przez 2 i 4 ćwiartkę"
    else
        echo "przechodzi przez 2, 3 i 4 ćwiartkę"
    fi
fi

