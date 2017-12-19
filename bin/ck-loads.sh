#!/usr/bin/env bash

readonly HOSTS="
recycle.cs.washington.edu
bicycle.cs.washington.edu
tricycle.cs.washington.edu
boom.cs.washington.edu
bam.cs.washington.edu
barb.cs.washington.edu
warfa.cs.washington.edu
buffalo.cs.washington.edu
caribou.cs.washington.edu
plover.cs.washington.edu
"

function main {
  local h
  for h in $HOSTS; do
    local name="$(echo "$h" | cut -d '.' -f 1)"
    local proc="$(get_proc $h)"
    local load="$(get_load $h)"

    printf "%10s %4d %s\n" \
      "$name" "$proc" "$load"
  done
}

function get_proc {
  local host="$1"

  ssh "$host" "nproc --all"
}

function get_load {
  local host="$1"

  ssh "$host" uptime   \
    | sed 's/.*://' \
    | sed 's/,//g'  \
    | xargs printf "%7.2f"
}

main
