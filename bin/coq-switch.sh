#!/usr/bin/env bash

# $ source switch-coq.sh

if [ "$(uname)" = "Darwin" ]; then
  i=0
  for p in /Applications/CoqIDE_*; do
    echo $i : $p
    v[$i]=$p
    i=$(expr $i + 1)
  done

  echo -n "Switch to: "
  read i
  export "PATH=${v[i]}/Contents/Resources/bin:$PATH"
else
  echo "!!! WARNING !!!"
  echo "This may make significant path changes."
  echo
  i=0
  for coqc in $(locate coqc | grep '/coqc$'); do
    echo -n "$i : "
    $coqc --version \
      | head -n 1 \
      | sed 's/.*version //' \
      | sed 's/ .*//'
    i=$(expr $i + 1)
    v[$i]=$(dirname "$coqc")
  done

  echo -n "Switch to: "
  read i
  export "PATH=${v[i]}:$PATH"
fi
