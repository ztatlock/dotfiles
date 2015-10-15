#!/usr/bin/env bash

V="$1"
PDF="$(basename "$V").pdf"

a2ps --medium=Letter \
     --pretty-print=$HOME/dotfiles/content/coqv.ssh \
     "$V" -o - \
  | ps2pdf - "$PDF"
