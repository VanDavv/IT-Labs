#!/bin/bash

if [ -z "$1" ] ; then
    read -p "katalog = " dir;
else
    dir=$1;
fi

ls -l | grep $dir | awk -F ' ' '{print $1}'
chmod +x $dir
bash $dir
