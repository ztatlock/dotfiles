#!/usr/bin/env bash

pdfjam \
  --paper letterpaper \
  --landscape \
  --nup 2x2 \
  --suffix '4up' \
  --frame true \
  --scale 0.9 \
  --quiet \
  "$1"
