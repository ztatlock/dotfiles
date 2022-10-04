#!/usr/bin/env bash

enscript -2 --landscape --highlight=ocaml "$1" --output=- \
  | ps2pdf - - \
  | ,print-cse.sh -
