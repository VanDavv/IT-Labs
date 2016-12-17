#!/bin/bash

read -p "s: " s

re='^\w+@\w+\.\w+$'
if [[ $s =~ $re ]] ; then
   echo "$s jest adresem email"
else
   echo "$s nie jest adresem email"
fi
