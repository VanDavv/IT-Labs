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

cd ${dir}

for i in $dir*
do
    i=`awk -F "/" '{print $(NF)}' <<< "$i"`

    if [ "$i" == "$s" ]; then
        echo "Istnieje"
        exit 0;
    fi
done

echo "Nieistnieje"
exit 1;
