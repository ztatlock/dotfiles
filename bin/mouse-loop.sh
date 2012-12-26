#!/usr/bin/env bash

OFF=300
RAD=300

C=$(expr $OFF + $RAD)

function x {
  echo "$RAD * c($1)" \
    | bc -l \
    | awk '{print int($1 + 0.5)}' \
    | xargs expr $C +
}

function y {
  echo "$RAD * s($1)" \
    | bc -l \
    | awk '{print int($1 + 0.5)}' \
    | xargs expr $C +
}

t=0
d=0.02
while true; do
  xdotool mousemove $(x $t) $(y $t)
  d=$(echo "$d * 1.001" | bc -l)
  t=$(echo "$t + $d" | bc -l)
done

