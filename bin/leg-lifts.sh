#!/usr/bin/env bash

function tone {
  mpg321 ~/bin/tone.mp3 &
  P=$!
  sleep 1
  kill -9 $P
}

function main {
  for i in $(seq 6); do
    sleep 5
    tone
    sleep 10
    tone
  done
  tone
}

main &> /dev/null

