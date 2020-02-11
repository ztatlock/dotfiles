#!/usr/bin/env bash

HOST="recylce.cs.washington.edu"

P="$1"
F="$2"

PRINTERS="pg224 pgc224 pg270 pgc270 pg324 pgc324 pg370 pgc370"

case "$P" in
  pg224 | pgc224 | pg270 | pgc270 | pg324 | pgc324 | pg370 | pgc370)
    echo "Printing in Gates Center to $P"
    ;;

  *)
    echo "Unknown printer $P"
    echo
    echo "I recognize the following printers:"
    echo "$PRINTERS"
    exit 1
    ;;
esac

if [ ! -f "$F" ]; then
  echo "Need path to printable file."
  exit 1
fi

BF="$(basename "$F")"

scp "$F" $HOST:~/tmp/
ssh $HOST "lpr -P $P ~/tmp/$BF"
ssh $HOST "lpq -P $P"
