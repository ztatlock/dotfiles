#!/usr/bin/env bash

set -u # reading an unset variable is an error
set -e # exit on error

# ensure file passed as arg
if [ $# -lt 1 ]; then
  echo
  echo "Usage: $(basename "$0") [file]"
  exit -1
fi
file="$1"
if [ ! -f "$file" ]; then
  echo
  echo "No such file '$file'"
  exit -1
fi

# prompt for which printer
printers=(pg224 pgc224 pg270 pgc270)
echo
for i in ${!printers[@]}; do
  if [ $i -eq 0 ]; then
    echo "$i : ${printers[$i]} (default)"
  else
    echo "$i : ${printers[$i]}"
  fi
done
echo
read -p "Print on: " i
if [ -z "$i" ]; then
  i=0
fi
printer="${printers[$i]}"
echo "OK, printing on $printer."
echo

# actually print (two-sided)
cat "$file" \
  | ssh recycle.cs.washington.edu "lpr -P${printer} -o sides=two-sided-long-edge"

# offer to remove file
read -p "Remove file? " yn
case "$yn" in
  [Yy]*)
    rm "$file"
    ;;
esac
