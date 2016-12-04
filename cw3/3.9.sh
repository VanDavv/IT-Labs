#!/usr/bin/env bash

for i in {1..7};
do
    # Prints the date from monday to sunday, no matter what day of week it is now
    echo "$(date --date="$[7 - $(date +%u) + $i] day" +"%A")"
done

