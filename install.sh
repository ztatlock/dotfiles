#!/usr/bin/env bash

# install scripts
mkdir -p ~/bin
for s in bin/*; do
  src=$(pwd)/$s
  tgt=~/bin/$(basename $s)
  ln -f -s "$src" "$tgt"
done
