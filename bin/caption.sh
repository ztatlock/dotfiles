#!/usr/bin/env bash

TTF="~/Dropbox/notes/impact.ttf"

if [ $# -lt 2 ]; then
  echo "Usage: $0 <img> <top-cap> <bot-cap> <font-size>"
  exit
fi

IMG="$1"
TOP="$2"
BOT="$3"
SIZ="$4"

convert "$IMG" \
  -fill white -stroke black \
  -font "$TTF" -pointsize $SIZ \
  -gravity North -annotate 0 "$TOP" \
  -gravity South -annotate 0 "$BOT" \
  "captioned-$IMG"
