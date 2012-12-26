#!/usr/bin/env bash

if [ $# -ne 1 ]; then
  echo "Usage: convert-m4a-mp3 [m4a]"
  exit 2
fi

m4a="$1"

if [ ! -f "$m4a" ]; then
  echo "Error: cannot read '$m4a'"
  exit 1
fi

mp3=$(echo $m4a | sed 's/m4a$/mp3/')

echo "$m4a ==> $mp3"
faad --quiet --stdio "$m4a" | lame --quiet - "$mp3"
