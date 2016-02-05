#!/usr/bin/env bash

TTF="$HOME/dotfiles/content/impact.ttf"

if [ ! -f "$TTF" ]; then
  echo "Error: could not find impact.ttf"
  exit 1
fi

if [ $# -lt 4 ]; then
  echo "Usage: $0 <img> <top-cap> <bot-cap> <font-size>"
  exit
fi

IMG="$1"
TOP="$2"
BOT="$3"
SIZ="$4"

convert "$IMG" \
  -fill white -stroke black -strokewidth 5 \
  -font "$TTF" -pointsize $SIZ \
  -gravity North -annotate 0 "$TOP" \
  -gravity South -annotate 0 "$BOT" \
  "captioned-$IMG"
