#!/bin/bash

if [ -z "$1" ] ; then
    read -p "katalog = " dir;
else
    dir=$1;
fi

if [ -z "$2" ] ; then
    read -p "nazwa = " s;
else
    s=$2;
fi

if [ -z "$3" ] ; then
    read -p "n = " n;
else
    n=$3;
fi

mkdir -p $dir
cd $dir

let counter=0
while (( $counter < $n ))
do
    let counter+=1
    touch "${s}${counter}"
done
