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
readonly MYDIR="$(cd -P "$(dirname "$src")" && pwd)"

# include my bash library
source "$MYDIR/include.sh"

function usage {
  echo "
$(basename $0) -h -t N -l DIR

Report status of work machines.

OPTIONS:

  -h      print this usage information and exit
  -t N    timeout after N seconds for each host (default 15)
  -l DIR  log results to per host CSVs in DIR
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
  DOSSH="$TIMEOUT $CURFEW ssh -oStrictHostKeyChecking=no -q"

  # prevent changing arg globals + share with subshells
  readonly HOSTS CURFEW LOG DOSSH
  export   HOSTS CURFEW LOG DOSSH
}

function main {
  parse_args "$@"

  [ "$LOG" = "" ] && \
    echo "HOST          1 MIN    5 MIN   15 MIN   DU    RND  CPU"
  parallel host_report ::: $HOSTS
}

function host_report {
  local host="$1"

  local name="$(echo "$host" | cut -d '.' -f 1)"
  local report="$($DOSSH "$host" \
    "$(typeset -f host_report_aux); host_report_aux")"

  if [ "$LOG" = "" ]; then
    local avg01="$(echo "$report" | cut -d ',' -f 1)"
    local avg05="$(echo "$report" | cut -d ',' -f 2)"
    local avg15="$(echo "$report" | cut -d ',' -f 3)"
    local disku="$(echo "$report" | cut -d ',' -f 4)"
    local chaos="$(echo "$report" | cut -d ',' -f 5)"
    local procs="$(echo "$report" | cut -d ',' -f 6)"

    printf "%-10s  %7.2f  %7.2f  %7.2f  %2d%%  %5d  %3d\n" \
      $name \
      $avg01 $avg05 $avg15 \
      $disku $chaos $procs

  else
    local log="$LOG/${name}.csv"
    local hdr="date,load1,load5,load15,disk,entropy,cores"

    mkdir -p "$LOG"
    [ ! -f "$log" ] && \
      echo "$hdr" > "$log"
    echo "$($DATE +%s),$report" >> "$log"
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

function host_report_aux {
  avg01="$(uptime | awk '{print $(NF - 2) }' | sed 's/,//')"
  avg05="$(uptime | awk '{print $(NF - 1) }' | sed 's/,//')"
  avg15="$(uptime | awk '{print $(NF - 0) }' | sed 's/,//')"
  disku="$(df | awk '$6 == "/" { print $5 }' | sed 's/%//')"
  chaos="$(cat /proc/sys/kernel/random/entropy_avail)"
  procs="$(nproc --all)"

  printf "%s,%s,%s,%s,%s,%s\n" \
    $avg01 $avg05 $avg15       \
    $disku $chaos $procs
}
export -f host_report_aux

function clean_log {
  local log="$1"

  #TODO remove entries older than... a month?
  return  0
}
export -f clean_log

main "$@"
