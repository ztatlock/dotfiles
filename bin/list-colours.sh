#!/usr/bin/env bash

for i in $(seq 0 255); do
   printf "\x1b[38;5;${i}mcolour%03d\x1b[0m " $i
   if ! (( ( $i + 1 ) % 8 )); then
     echo
   fi
 done
