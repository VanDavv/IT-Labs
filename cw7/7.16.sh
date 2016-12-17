#!/bin/bash

if [ -z "$1" ] ; then
    read -p "path = " dir;
else
    dir=$1;
fi

let dirs=0
let exec=0
let file=0

for i in $dir*
do
    if [ -d ${i} ]; then
        let dirs+=1
    elif [ -x ${i} ]; then
        let exec+=1
    elif [ -f ${i} ]; then
        let file+=1
    fi
done

echo "Directories: $dirs"
echo "Executables: $exec"
echo "Normal files: $file"

