#!/usr/bin/env bash

enscript -2 --landscape --highlight=ocaml "$1" --output=- \
  | ssh recycle.cs.washington.edu "lpr -Ppg224 -o sides=two-sided-long-edge"
