#!/usr/bin/env bash

CODE="$1"

if [ ! -f "$CODE" ]; then
  echo "Could not find '$CODE'."
fi

PDF="$(basename "$CODE").pdf"

a2ps --header --medium='Letter' --silent "$CODE" -o - \
  | ps2pdf - "$PDF"
