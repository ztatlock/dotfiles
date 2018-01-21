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

NAP=60

function usage {
  echo "
$(basename $0) -h -s N

Randomly sleep up to N seconds

OPTIONS:

  -h      print this usage information and exit
  -s N    sleep randomly up to N seconds (default $NAP)
"
}

function parse_args {
  while getopts ":hs:" OPT; do
    case "$OPT" in
      h) usage; exit 0  ;;
      s) NAP=$OPTARG    ;;
      :) usage_error "-$OPTARG requires an argument" ;;
      *) usage_error "bogus option '-$OPTARG'"       ;;
    esac
  done

  assert_nonnegi "sleep" "$NAP"

  # prevent changing arg globals + share with subshells
  readonly NAP
  export   NAP
}

function main {
  parse_args "$@"

  # random delay
  sleep $(($RANDOM % $NAP + 1))
}

main "$@"
