#!/usr/bin/env bash

f=$1
shift 1

for i in $*; do
  $f $i
done

