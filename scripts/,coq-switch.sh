#!/usr/bin/env bash

# Switch to a different installation of Coq on macOS

if [ "$(uname)" = "Darwin" ]; then
  echo "Make sure to run as:"
  echo "$ source $0"
  echo
else
  echo "Only works for macOS"
  exit -1
fi

i=0
for p in /Applications/CoqIDE_*; do
  echo "$i : $p"
  v[$i]=$p
  i=$(expr $i + 1)
done

echo -n "Switch to: "
read i
export "PATH=${v[i]}/Contents/Resources/bin:$PATH"
