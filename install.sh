#!/usr/bin/env bash

function slink {
  echo "  $(basename "$1")"
  ln -f -s "$1" "$2"
}

ctab=cron/crontab-$(hostname)
if [ -f $ctab ]; then
  echo "Installing crontab $ctab"
  crontab "$ctab"
fi

echo "Installing scripts to $HOME/bin"
mkdir -p "$HOME/bin";
for s in bin/*; do
  slink "$(pwd)/$s" "$HOME/bin/$(basename $s)"
done
