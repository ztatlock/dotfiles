#!/usr/bin/env bash

P="$HOME/Dropbox/progress"
T="$P/TEMPLATE.md"
W="$P/$(gdate +'%y%m%d' -d 'last saturday').md"

if [ ! -d "$P" ]; then
  echo "Progress log directory not found!"
  exit 1
fi

if [ ! -f "$W" ]; then
  echo "Progress log for this week not found."
  read -p "Set up from template (y/n)? " yn
  case $yn in
    y)
      cp "$T" "$W"
      ;;
    *)
      echo "No changes made."
      exit 0
      ;;
  esac
fi

$EDITOR "$W"
