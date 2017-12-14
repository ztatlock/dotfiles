#!/usr/bin/env bash

readonly HOSTS="
warfa.cs.washington.edu
recycle.cs.washington.edu
bicycle.cs.washington.edu
tricycle.cs.washington.edu
barb.cs.washington.edu
buffalo.cs.washington.edu
caribou.cs.washington.edu
plover.cs.washington.edu
"

function main {
  for h in $HOSTS; do
    local name="$(echo "$h" | cut -d '.' -f 1)"
    local load="$(load $h)"

    printf "%10s %s\n" "$name" "$load"
  done
}

function load {
  ssh "$1" uptime   \
    | sed 's/.*://' \
    | sed 's/,//g'  \
    | xargs printf "%7.2f"
}

main
