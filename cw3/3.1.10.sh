#!/usr/bin/env bash

for i in {1..7};
do
    echo "$(date --date="$[7 - $(date +%u) + $i] day" +"%A") to $(date --date="$[7 - $(date +%u) + $i] day" +"%u") dzień tygodnia"
done

