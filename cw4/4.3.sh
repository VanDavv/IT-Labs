#!/usr/bin/env bash

if [ -z "$1" ] ; then
    read -p "n = " n;
else
    n=$1;
fi

re='^-?[0-9]+([.][0-9]+)?$'
if ! [[ $n =~ $re ]] ; then
   echo "$n nie jest liczbą" >&2; exit 1
fi

let i=3
while (( $i <= $n ));
do
    echo "$[i * (i-2)]"
    let i+=2
done

