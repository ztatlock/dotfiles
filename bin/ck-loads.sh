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

export CURFEW=10

export TIMEOUT="timeout $CURFEW"
if command -v gtimeout > /dev/null 2>&1; then
  TIMEOUT="gtimeout $CURFEW"
fi

function main {
  parallel host_report ::: $HOSTS
}

function host_report {
  local host="$1"
  local name="$(echo "$host" | cut -d '.' -f 1)"

  source "$(which env_parallel).bash"
  parset proc,load \
    ::: get_proc get_load ::: "$host"
  printf "%10s %4s %s\n" \
    "$name" "$proc" "$load"
}
export -f host_report

function get_proc {
  local host="$1"

  $TIMEOUT \
    ssh "$host" "nproc --all"
}
export -f get_proc

function get_load {
  local host="$1"

  $TIMEOUT \
    ssh "$host" uptime \
      | sed 's/.*://'  \
      | sed 's/,//g'   \
      | xargs printf "%7.2f"
}
export -f get_load

main "$@"
