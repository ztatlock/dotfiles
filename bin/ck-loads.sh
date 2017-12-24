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

export CURFEW=5
export TIMEOUT="timeout"
command -v gtimeout > /dev/null 2>&1 && \
  TIMEOUT="gtimeout"
export SSHOPTS="-oStrictHostKeyChecking=no"
export DOSSH="$TIMEOUT $CURFEW ssh $SSHOPTS"

export PARSET=false
if which env_parallel > /dev/null 2>&1; then
  source "$(which env_parallel).bash"
  if type parset > /dev/null 2>&1; then
    PARSET=true
  fi
fi

function main {
  parallel host_report ::: $HOSTS
}

function host_report {
  local host="$1"
  local name="$(echo "$host" | cut -d '.' -f 1)"

  if $PARSET; then
    source "$(which env_parallel).bash"
    parset proc,load \
      ::: get_proc get_load ::: "$host"
  else
    local proc="$(get_proc "$host")"
    local load="$(get_load "$host")"
  fi

  printf "%10s %4s %s\n" \
    "$name" "$proc" "$load"
}
export -f host_report

function get_proc {
  local host="$1"

  $DOSSH "$host" "nproc --all"
}
export -f get_proc

function get_load {
  local host="$1"

  local uptime="$($DOSSH "$host" "uptime")"
  if [ -n "$uptime" ]; then
    echo "$uptime"     \
      | sed 's/.*://'  \
      | sed 's/,//g'   \
      | xargs printf "%7.2f"
  fi
}
export -f get_load

main "$@"
