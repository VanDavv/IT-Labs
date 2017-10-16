#!/bin/bash

if [ -z "$1" ] ; then
    read -p "path = " dir;
else
    dir=$1;
fi

if [ -d ${dir} ]; then
    echo "Plik jest katalogiem"
elif [ -x ${dir} ]; then
    echo "Plik jest plikiem wykonywalnym"
elif [ -f ${dir} ]; then
    echo "Plik jest zwykłym plikiem"
else
    echo "Nie można określić typu pliku"
fi

