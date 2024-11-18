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
printers=(pg224 pgc224 pg270 pgc270 pgclarge)
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
echo

# get options
options=""
read -p "Two-sided? (Y/n) " yn
case "$yn" in
  [nN])
    ;;
  *)
    options="$options -o sides=two-sided-long-edge"
esac
echo

echo "Printing '${file}' on ${printer} with options '${options}'."
cat "$file" \
  | ssh barb.cs.washington.edu "lpr -P${printer} ${options}"
echo

# offer to remove file
read -p "Remove file? (y/N) " yn
case "$yn" in
  [yY])
    echo "Removing '$file'"
    rm "$file"
    ;;
  *)
    echo "Document '$file' left in place."
esac
echo
