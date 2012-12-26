#!/usr/bin/env bash

# rename each file in working dir via sed rule

ls | while read f; do
  g=$(echo $f | sed "$1")
  echo $f
  echo $g
  if [ "$2" = "--commit" ]; then
    mv "$f" "$g"
  fi
done
