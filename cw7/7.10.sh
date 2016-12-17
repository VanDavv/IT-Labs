#!/bin/bash

if [ -z "$1" ] ; then
    read -p "katalog = " dir;
else
    dir=$1;
fi

re='^(/\w+)+$'
if ! [[ $dir =~ $re ]] ; then
   echo "$dir nie jest poprawną ścieżką" >&2; exit 1
fi


if [ -z "$2" ] ; then
    read -p "n = " n;
else
    n=$2;
fi

re='^[1-9]+|0$'
if ! [[ $n =~ $re ]] ; then
   echo "$n nie jest poprawną liczba" >&2; exit 1
fi

let counter=0

while (( $counter < $n ));
do
    read -p "imie = " s1
    read -p "nazwisko = " s2
    read -p "data urodzenia = " s3
    read -p "zawód = " s4
    echo -e "$s1\n$s2\n$s3\n$s4\n" > "${dir}/${s1}_${s2}"
    let counter+=1
done
