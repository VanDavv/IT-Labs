#!/bin/bash

read -p "s: " s

re='^.+\.(jpg|jpeg)$'
if [[ $s =~ $re ]] ; then
   echo "$s jest plikiem jpg lub jpeg"
else
   echo "$s nie jest plikiem jpg ani jpeg"
fi
