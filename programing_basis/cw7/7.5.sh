#!/bin/bash

read -p "s: " s

re='^.+\.txt$'
if [[ $s =~ $re ]] ; then
   echo "$s jest plikiem txt"
else
   echo "$s nie jest plikiem txt"
fi
