#!/usr/bin/env bash

if [ -z "$1" ] ; then
    read -p "a = " a;
else
    a=$1;
fi

re='^-?[0-9]+([.][0-9]+)?$'
if ! [[ $a =~ $re ]] ; then
   echo "$a nie jest liczbą" >&2; exit 1
fi

if [ -z "$2" ] ; then
    read -p "n = " n;
else
    n=$2;
fi

if ! [[ $n =~ $re ]] ; then
   echo "$n nie jest liczbą" >&2; exit 1
fi

let a+=a%2
while (( $a <= $n ));
do
    echo "$a"
    let a+=2
done

