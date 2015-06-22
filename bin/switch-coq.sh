#!/usr/bin/env bash

# $ source switch-coq.sh

i=0
for p in /Applications/CoqIDE_*; do
  echo $i : $p
  v[$i]=$p
  i=$(expr $i + 1)
done
echo -n "Switch to: "
read i

export "PATH=${v[i]}/Contents/Resources/bin:$PATH"
