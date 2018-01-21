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

LOG=""

function usage {
  echo "
$(basename $0) -h -l DIR

Update load log csv.

OPTIONS:

  -h      print this usage information and exit
  -l DIR  log results to per host CSVs in DIR (required)
"
}

function parse_args {
  while getopts ":hl:" OPT; do
    case "$OPT" in
      h) usage; exit 0  ;;
      l) LOG=$OPTARG    ;;
      :) usage_error "-$OPTARG requires an argument" ;;
      *) usage_error "bogus option '-$OPTARG'"       ;;
    esac
  done

  assert_nonemptys "log" "$LOG"

  # prevent changing arg globals + share with subshells
  readonly LOG
  export   LOG
}

function main {
  parse_args "$@"

  local host="$(hostname)"
  local name="$(echo "$host" | cut -d '.' -f 1)"

  local avg01="$(uptime | awk '{print $(NF - 2) }' | sed 's/,//')"
  local avg05="$(uptime | awk '{print $(NF - 1) }' | sed 's/,//')"
  local avg15="$(uptime | awk '{print $(NF - 0) }' | sed 's/,//')"
  local disku="$(df | awk '$6 == "/" { print $5 }' | sed 's/%//')"
  local chaos="$(cat /proc/sys/kernel/random/entropy_avail      )"
  local procs="$(nproc --all                                    )"

  local report="$(printf '%s,%s,%s,%s,%s,%s\n' \
    $avg01 $avg05 $avg15 \
    $disku $chaos $procs )"

  update_log "$LOG/${name}.csv" "$report"

  local stats="$LOG/${name}-stats.txt"
  if [ ! -f "$stats" ] \
  || [ $($STAT --format=%Y "$stats") -le $(($($DATE +%s) - 3600)) ]; then
    host_status > "$stats"
  fi
}

function host_status {
  echo "$(hostname) status on $($DATE):"
  echo

  echo '# uptime'
  uptime
  echo

  echo '# lscpu'
  lscpu
  echo

  echo '# free -h'
  free -h
}

function update_log {
  local log="$1"
  local row="$2"
  local hdr="date,load1,load5,load15,disk,entropy,cores"

  # ensure log exists
  mkdir -p "$LOG"
  [ ! -s "$log" ] && \
    echo "$hdr" > "$log"

  awk -F',' "
    # keep header and add new row
    NR < 2 {
      print \"$hdr\"
      print \"$($DATE +%s),$row\"
      next
    }

    # drop bad rows
    NF < 7 {
      next
    }

    # drop old rows
    NR > 1024 {
      next
    }

    # print everything else
    {
      print \$0
    }
  " "$log" > "$log.tmp"
  mv "$log.tmp" "$log"
}

main "$@"
