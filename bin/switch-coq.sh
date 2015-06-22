#!/usr/bin/env bash

case $1 in
  "8.4pl4")
    echo "PATH=/Applications/CoqIde_8.4pl4.app/Contents/Resources/bin:$PATH"
    ;;
  *)
    for v in /Applications/CoqI*; do
      echo $v
    done
    ;;
esac
