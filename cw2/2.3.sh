#!/bin/bash


read -p "1:" a
read -p "2:" b
read -p "3:" c

if (($a > $b)); then
    if (($b >= $c)); then
        echo "max $a, min $c"
    else
        if (($a >= $c)); then
            echo "max $a, min $b"
        else
            echo "max $c, min $b"
        fi
    fi
elif (($a == $b)); then
    if (($a >= $c)); then
        echo "max $a, min $c"
    else
        echo "max $c, min $a"
    fi
else
    if (($a >= $c)); then
        echo "max $b, min $c"
    else
        if (($b >= $c)); then
            echo "max $b, min $a"
        else
            echo "max $c, min $a"
        fi
    fi
fi

