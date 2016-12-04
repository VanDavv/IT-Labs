#!/usr/bin/env bash

if [ -z "$1" ] ; then
    read -p "a = " a;
else
    a=$1;
fi
re='^-?[0-9]+([.][0-9]+)?$'

if ! [[ $b =~ $re ]] ; then
   echo "$b nie jest liczbą" >&2; exit 1
fi
#WIP
let i=0
while (( $i < $a ));
do
re='^-?[0-9]+([.][0-9]+)?$'

if [ -z "$2" ] ; then
    read -p "b = " b;
else
    b=$2;
fi

if ! [[ $b =~ $re ]] ; then
   echo "$b nie jest liczbą" >&2; exit 1
fi

    echo "$[$a * $a]"
    let a+=3
done

