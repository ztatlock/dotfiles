#!/usr/bin/env bash

SRC="$1"

HBOPTS="
  --format mp4
  --markers
  --encoder x264
  --vb 1500
  --two-pass
  --turbo
  --x264opts ref=2:bframes=2:subme=5:me=umh
  --aencoder faac
  --ab 160
  --arate 48
  --native-language eng
"

function mkTmp {
  echo "/tmp/encode-to-mp4.$(date "+%d-%H:%M").$(date +%N)"
}

function get_nmp {
  echo
  echo "In the naming pattern %t will be replaced by the title"
  echo "number and .mp4 will be appended to the end."
  echo
  echo -n "Naming pattern: "
  read nmp
}

function ls_titles {
  durations=$(
    HandBrakeCLI -i "$SRC" -t 0 2>&1 \
      | egrep "^\+ title" -A 4 \
      | grep duration \
      | sed 's/  + duration: //'
  )

  i=1
  for d in $durations; do
    printf " %2d : %s\n" $i $d
    i=$(expr $i + 1)
  done
}

function get_titles {
  TMP=$(mkTmp)
  echo "Delete the lines of unwanted titles below:" > $TMP
  ls_titles >> $TMP
  $EDITOR $TMP
  titles=$(tail -n +2 $TMP | awk '{print $1}')
}

function confirm {
  clear
  echo "Source : $SRC"
  echo "Naming : $nmp"
  echo "Titles : $(echo $titles | tr '\n' ' ')"
  echo 
  echo -n "Proceed? [y/N] "
  read ans
  if [ "$ans" != "y" ]; then
    exit 0
  fi
  echo
}

function encode {
  title="$1"
  out="$2"

  echo "$SRC : $title  ==>  $out"
  tick=$(date +%s)
  HandBrakeCLI -i "$SRC" -t "$title" -o "$out" $HBOPTS 2> $(mkTmp)
  tock=$(date +%s)
  echo
  echo "Encoding time : $(expr $tock - $tick) seconds"
  echo "Encoded size  : $(du -hs "$out" | awk '{print $1}')"
}

function main {
  # setup
  get_nmp
  get_titles
  confirm

  # encode
  for t in $titles; do
    tn=$(printf "%02d" $t)
    nm=$(echo $nmp | sed "s/%t/$tn/")
    encode $t "$nm.mp4"
    echo
  done
}

main
