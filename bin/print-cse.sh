#!/usr/bin/env bash

# options https://www.cups.org/doc/man-lpr.html
#   sides=one-sided
#   sides=two-sided-long-edge (portrait)
#   sides=two-sided-short-edge (landscape)
#   number-up={2|4|6|9|16}
#   orientation-requested=4

HOST="recycle.cs.washington.edu"

P="$1"
shift
F="$1"
shift
O="$*"

PRINTERS="pg224 pgc224 pg270 pgc270 pg324 pgc324 pg370 pgc370"

function usage {
  echo "Usage:"
  echo
  echo "$(basename $0) PRINTER FILE [LPR OPTIONS]"
}

case "$P" in
  pg224 | pgc224 | pg270 | pgc270 | pg324 | pgc324 | pg370 | pgc370)
    echo "Printing in Gates Center to $P"
    ;;

  *)
    echo "Unknown printer '$P'"
    echo
    echo "I recognize the following printers:"
    echo "$PRINTERS"
    echo
    usage
    exit 1
    ;;
esac

if [ ! -f "$F" ]; then
  echo "Need path to printable file."
  echo
  usage
  exit 1
fi

case "$O" in
  "")
    O="-o sides=two-sided-long-edge"
    echo "Printing 2-sided, long edge (default)"
    ;;

  *)
    echo "Printing with options:"
    echo "$O"
    ;;
esac

BF="$(basename "$F")"

set -ex
scp "$F" $HOST:~/tmp/
ssh $HOST "lpr -P $P $O ~/tmp/$BF"
ssh $HOST "lpq -P $P"
