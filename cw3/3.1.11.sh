#!/usr/bin/env bash

for i in {1..12};
do
    echo "$(date --date="$[12 - $(date +%m) + $i] month" +"%B") to $(date --date="$[12 - $(date +%m) + $i] month" +"%m") miesiąc roku"
done

