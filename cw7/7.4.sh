#!/bin/bash

let counter=0

x="\r\n"
s=`cat $1`

while (( $counter < ${#s}));
do
    if [[ ! -z ${s:$counter:1} && '.' == ${s:$counter:1} ]]; then
        s=${s:0:$[counter]}$x${s:$[counter + 1]:${#s}}
        let counter+=${#x}
    fi
    let counter+=1
done

echo -ne "$s" > $2
