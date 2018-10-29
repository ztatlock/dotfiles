#!/usr/bin/env bash

P="$HOME/Dropbox/progress"
T="$P/TEMPLATE.md"

if [ "$(gdate +'%A')" = 'Saturday' ]; then
  W="$P/$(gdate +'%y%m%d').md"
  M="$(gdate +'%B')"
  D="$(gdate +'%d')"
else
  W="$P/$(gdate +'%y%m%d' -d 'last saturday').md"
  M="$(gdate +'%B' -d 'last saturday')"
  D="$(gdate +'%d' -d 'last saturday')"
fi

if [ ! -d "$P" ]; then
  echo "Progress log directory not found!"
  exit 1
fi

if [ ! -f "$W" ]; then
  echo "Progress log for this week not found."
  read -p "Set up from template (y/n)? " yn
  case $yn in
    y)
      cat "$T" \
        | sed "s/MONTH/$M/g" \
        | sed "s/SAT-DATE/$D/g" \
        > "$W"
      ;;
    *)
      echo "No changes made."
      exit 0
      ;;
  esac
fi

$EDITOR "$W"
