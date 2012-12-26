#!/usr/bin/env bash

#  for i in $(seq 60); do
#    sox $1 -t .raw -r 44100 -c 2 -;
#  done | sox -t .raw -r 4410 -c 2 - -t .wav loop.wav

sox $(for i in $(seq 60); do echo -n " $1 "; done) loop.wav
