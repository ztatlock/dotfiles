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
  printf "%-15s -> %s\n" "$1" "~/$2"
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
slink bash/bashrc     .bashrc
slink bash/profile    .profile
slink bash/profile    .bash_profile
slink vim/vimrc       .vimrc
slink git/gitconfig   .gitconfig
slink ssh/config      .ssh/config
slink tmux/tmux.conf  .tmux.conf
slink emacs/emacs     .emacs
echo
