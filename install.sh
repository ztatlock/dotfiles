#!/usr/bin/env bash

function slink {
  echo "  $(basename "$1")"
  ln -f -s "$1" "$2"
}

echo "crontab:"
ctab=cron/crontab-$(hostname)
if [ -f $ctab ]; then
  echo "  $ctab"
  crontab "$ctab"
else
  echo "  (none)"
fi
echo

echo "$HOME/bin:"
mkdir -p "$HOME/bin";
for s in bin/*; do
  slink "$(pwd)/$s" "$HOME/bin/$(basename $s)"
done
echo

echo "configs:"
slink "$(pwd)/git/gitconfig" "$HOME/.gitconfig"
