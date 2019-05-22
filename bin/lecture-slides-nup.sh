#!/usr/bin/env bash

pdfnup \
  --nup 2x2 \
  --suffix '4up' \
  --frame true \
  --scale 0.95 \
  --quiet \
  "$1"
