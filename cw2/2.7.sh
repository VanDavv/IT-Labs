#!/bin/bash

read -p "a:" a
read -p "p:" p

x=$(bc <<< "$p / sqrt(1 + $a^2)")
echo "x = ${x} , y = $(bc <<< "$x * $a")"

