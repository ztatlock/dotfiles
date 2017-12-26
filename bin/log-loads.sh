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

function main {
  # log 5 minute average load
  "$MYDIR/ck-loads.sh" \
    | awk 'BEGIN { d = systime() } { print d "," $1 "," $4 }' \
    >> "$HOME/.loads.csv"

  clean_log
}

function clean_log {
  # TODO
  return 0
}

main "$@"
