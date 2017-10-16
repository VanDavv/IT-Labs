#!/bin/bash

read -p "s: " s

re='[0-9]{2}-[0-9]{3}+$'
if [[ $s =~ $re ]] ; then
   echo "$s jest kodem pocztowym"
else
   echo "$s nie jest kodem pocztowym"
fi
