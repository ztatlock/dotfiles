#!/usr/bin/env bash

# exit on error
set -e

# determine physical directory of this script
src="${BASH_SOURCE[0]}"
while [ -L "$src" ]; do
  dir="$(cd -P "$(dirname "$src")" && pwd)"
  src="$(readlink "$src")"
  [[ $src != /* ]] && src="$dir/$src"
done
MYDIR="$(cd -P "$(dirname "$src")" && pwd)"

pushd "$MYDIR"

function slink {
  echo "  $1"
  ln -f -s "$(pwd)/$1" "$HOME/$2"
}

function slinkv {
  printf "  %-14s  -->  %s\n" "$1" "~/$2"
  ln -f -s "$(pwd)/$1" "$HOME/$2"
}

echo
echo "# CRONTAB"
ctab=cron/crontab-$(hostname -s)
if [ -f $ctab ]; then
  echo "  $ctab"
  crontab "$ctab"
else
  echo "  (none)"
fi
echo

echo
echo "# $HOME/bin"
mkdir -p "$HOME/bin";
for s in bin/*; do
  slink "$s" "bin/$(basename "$s")"
done
echo

echo
echo "# CONFIGS"
slinkv bash/bashrc     .bashrc
slinkv bash/profile    .profile
slinkv bash/profile    .bash_profile
slinkv vim/vimrc       .vimrc
slinkv git/gitconfig   .gitconfig
slinkv ssh/config      .ssh/config
slinkv tmux/tmux.conf  .tmux.conf
slinkv emacs/emacs     .emacs
echo
