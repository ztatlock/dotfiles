#!/usr/bin/env bash

# adapted from:
#   https://stackoverflow.com/questions/687948/timeout-a-command-in-bash-without-unnecessary-delay

# ANSI color codes
BLK=$'\033[1;30m' # black
RED=$'\033[1;31m' # red
GRN=$'\033[1;32m' # green
YLO=$'\033[1;33m' # yellow
BLU=$'\033[1;34m' # blue
MAG=$'\033[1;35m' # magenta
CYN=$'\033[1;36m' # cyan
WHT=$'\033[1;37m' # white
CLR=$'\033[0m'    # no color

function error {
  local msg="$1"

  local c0=""
  local c1=""
  [ -t 1 ] && c0="$RED" && c1="$CLR"

  echo "${c0}ERROR:${c1} $msg" >&2
  exit 1
}

function usage_error {
  local msg="$1"

  usage
  echo
  error "$msg"
}

function usage {
  echo "
$(basename "$0") -h -t N CMD

Run CMD with N second time out. If CMD is still running once time expires,
then it is signaled with SIGTERM and, one second later, with SIGKILL for
good measure.

OPTIONS:

  -h    print this usage information and exit
  -t N  seconds to wait before killing CMD (default 10)
"
}

CURFEW=10

while getopts ":ht:" OPT; do
  case "$OPT" in
    h) usage; exit 0  ;;
    t) CURFEW=$OPTARG ;;
    :) usage_error "-$OPTARG requires an argument" ;;
    *) usage_error "bogus option '-$OPTARG'"       ;;
  esac
done
shift $((OPTIND - 1))

if [ "$#" -lt 1 ]; then
  usage_error "no CMD to execute"
fi

case "$CURFEW" in
  ''|*[!0-9]*)
    usage_error "timeout must be a positive number, got '$CURFEW'" ;;
  *)
    [ "$CURFEW" -le 0 ] && \
      usage_error "timeout must be positive, got '$CURFEW'" ;;
esac

# "kill -0 pid" indicates if a signal may be sent to process pid
(
    t="$CURFEW"
    while [ "$t" -gt 0 ]; do
        sleep 1
        kill -0 $$ || exit 0
        t=$(($t - 1))
    done

    kill -s SIGTERM $$ && kill -0 $$ || exit 0
    sleep 1
    kill -s SIGKILL $$
) 2> /dev/null &

exec "$@"
