#!/usr/bin/env bash

echo $* | while read d; do
  dot -Tpng "$d" > "$d.png"
done
