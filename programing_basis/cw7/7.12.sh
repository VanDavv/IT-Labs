#!/bin/bash

if [ -z "$1" ] ; then
    read -p "katalog = " dir;
else
    dir=$1;
fi
let counter=1
for i in ${dir}*
do
    echo "plik $counter to $i"
    let counter+=1
done
