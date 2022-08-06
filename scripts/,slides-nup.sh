#!/usr/bin/env bash

pdfjam \
  --nup 2x2 \
  --landscape \
  --suffix '4up' \
  --frame true \
  --scale 0.9 \
  --quiet \
  "$1"
