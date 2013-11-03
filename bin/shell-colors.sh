#!/usr/bin/env bash

for c in $(seq 0 255); do
  printf "\x1b[38;5;${c}mc${c}\t"
  if [ $(expr $c % 10) == 0 ]; then
    echo
  fi
done
echo
