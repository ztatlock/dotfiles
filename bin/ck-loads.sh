#!/usr/bin/env bash

# exit on error
set -e

# determine physical directory of this script
src="${BASH_SOURCE[0]}"
while [ -L "$src" ]; do
  dir="$(cd -P "$(dirname "$src")" && pwd)"
  src="$(readlink "$src")"
  [[ $src != /* ]] && src="$dir/$src"
done
MYDIR="$(cd -P "$(dirname "$src")" && pwd)"

# include my bash library
source "$MYDIR/include.sh"

function usage {
  echo "
$(basename $0) -h -t N -l DIR

Report average loads for cycle servers.

OPTIONS:

  -h      print this usage information and exit
  -t N    timeout after N seconds for each host (default 15)
  -l DIR  log 5-minute average loads per host to CSVs in DIR
"
}

HOSTS="
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
uwplse.org
"

CURFEW=15
LOG=""

function parse_args {
  while getopts ":ht:l:" OPT; do
    case "$OPT" in
      h) usage; exit 0  ;;
      t) CURFEW=$OPTARG ;;
      l) LOG=$OPTARG    ;;
      :) usage_error "-$OPTARG requires an argument" ;;
      *) usage_error "bogus option '-$OPTARG'"       ;;
    esac
  done

  assert_nonnegi "timeout" "$CURFEW"

  PARSET=false
  if which env_parallel > /dev/null 2>&1; then
    source "$(which env_parallel).bash"
    if type parset > /dev/null 2>&1; then
      PARSET=true
    fi
  fi

  SSHOPTS="-oStrictHostKeyChecking=no"
  DOSSH="$TIMEOUT $CURFEW ssh $SSHOPTS"

  # prevent changing arg globals + share with subshells
  readonly HOSTS CURFEW LOG PARSET SSHOPTS DOSSH
  export   HOSTS CURFEW LOG PARSET SSHOPTS DOSSH
}

function main {
  parse_args "$@"
  parallel host_report ::: $HOSTS
}

function host_report {
  local host="$1"
  local name="$(echo "$host" | cut -d '.' -f 1)"

  if $PARSET; then
    source "$(which env_parallel).bash"
    parset proc,load,disk \
      ::: get_proc get_load get_disk ::: "$host"
  else
    local proc="$(get_proc "$host")"
    local load="$(get_load "$host")"
    local disk="$(get_disk "$host")"
  fi

  if [ "$LOG" = "" ]; then
    printf "%10s %4s %11s %4s\n" \
      "$name" "$proc" "$load" "$disk"
  else
    local log="$LOG/${name}.csv"
    local hdr="date,cores,load1,load5,load15,disk"

    mkdir -p "$LOG"
    [ ! -f "$log" ] && \
      echo "$hdr" > "$log"

    csvify "$proc" "$load" "$disk" >> "$log"
    clean_log "$log"

    local stats="$LOG/${name}-stats.txt"
    [ ! -f "$stats" ] && \
      { echo "$host stats on $($DATE):"  \
      ; echo                             \
      ; echo '# lscpu'                   \
      ; echo                             \
      ; $DOSSH "$host" 'lscpu' || true   \
      ; echo                             \
      ; echo                             \
      ; echo '# free -h'                 \
      ; $DOSSH "$host" 'free -h' || true \
      ; } > "$LOG/${name}-stats.txt"
  fi
}
export -f host_report

function get_proc {
  local host="$1"

  $DOSSH "$host" 'nproc --all' || true
}
export -f get_proc

function get_load {
  local host="$1"

  local uptime="$($DOSSH "$host" 'uptime' || true)"
  if [ -n "$uptime" ]; then
    echo "$uptime"     \
      | sed 's/.*://'  \
      | sed 's/,//g'   \
      | xargs printf "%7.2f"
  fi
}
export -f get_load

function get_disk {
  local host="$1"

  local df="$($DOSSH "$host" "df -h" || true)"
  if [ -n "$df" ]; then
    echo "$df" \
      | $AWK '$6 == "/" { print $5 }'
  fi
}
export -f get_disk

function csvify {
  local proc="$1"
  local load="$2"
  local disk="$3"

  local l1="$($AWK '{print $1}' <<< "$load")"
  local l2="$($AWK '{print $2}' <<< "$load")"
  local l3="$($AWK '{print $3}' <<< "$load")"
  local dp="$($SED 's/%//' <<< "$disk")"

  printf "%s,%d,%0.2f,%0.2f,%0.2f,%d\n" \
    "$($DATE +%s)"                      \
    "$proc" "$l1" "$l2" "$l3" "$dp"
}
export -f csvify

function clean_log {
  local log="$1"

  #TODO remove entries older than... a month?
  return  0
}
export -f clean_log

main "$@"
