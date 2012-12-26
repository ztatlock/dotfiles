#!/usr/bin/env bash

# before running, ensure dvd is not mounted

echo "dd if=/dev/dvd of=$1 bs=1024"
tick=$(date +%s)
dd if=/dev/dvd of="$1" bs=1024
tock=$(date +%s)
echo "Ripping Time: $(expr $tock - $tick) seconds"
