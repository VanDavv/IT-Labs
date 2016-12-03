#!/usr/bin/env bash

for i in {1..6};
do
    echo "jeżeli dziś jest $(date --date="$[7 - $(date +%u) + $i] day" +"%A") to jutro jest $(date --date="$[7 - $(date +%u) + $i + 1] day" +"%A")"
done

