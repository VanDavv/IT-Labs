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

i=1
while (( $i <= $n ));
do
    echo "$i"
    let i+=1
done

