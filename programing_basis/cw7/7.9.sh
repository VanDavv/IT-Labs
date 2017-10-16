#!/bin/bash

read -p "s: " s

re='^[1-9]+|0$'
if [[ $s =~ $re ]] ; then
   echo "$s jest liczbą całkowitą"
else
   echo "$s nie jest liczbą całkowitą"
fi
