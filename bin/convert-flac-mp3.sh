#!/usr/bin/env bash

if [ $# -ne 1 ]; then
  echo "Usage: convert-flac-mp3 [flac]"
  exit 2
fi

flac="$1"

if [ ! -f "$flac" ]; then
  echo "Error: cannot read '$flac'"
  exit 1
fi

mp3=$(echo $flac | sed 's/flac$/mp3/')

echo "$flac ==> $mp3"
flac --decode --silent --stdout "$flac" | lame --quiet - "$mp3"
