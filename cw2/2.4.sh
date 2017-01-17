#!/bin/bash


read -p "1:" a
read -p "2:" b
read -p "3:" c

if (($a > $b)); then
    if (($b >= $c)); then
        echo "$a, $b, $c"
    else
        if (($a >= $c)); then
            echo "$a, $c, $b"
        else
            echo "$c, $a, $b"
        fi
    fi
elif (($a == $b)); then
    if (($a >= $c)); then
        echo "$a, $b, $c"
    else
        echo "$c, $b, $a"
    fi
else
    if (($a >= $c)); then
        echo "$b, $a, $c"
    else
        if (($b >= $c)); then
            echo "$b, $c, $a"
        else
            echo "$c, $b, $a"
        fi
    fi
fi

