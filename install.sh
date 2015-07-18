#!/usr/bin/env bash

function slink {
  echo "  $1"
  ln -f -s "$(pwd)/$1" "$HOME/$2"
}

echo "crontab:"
ctab=cron/crontab-$(hostname -s)
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
  slink "$s" "bin/$(basename $s)"
done
echo

echo "configs:"
slink bash/bashrc     .bashrc
slink bash/profile    .profile
slink vim/vimrc       .vimrc
slink git/gitconfig   .gitconfig
slink ssh/config      .ssh/config
slink ssh/rc          .ssh/rc
slink tmux/tmux.conf  .tmux.conf
slink emacs/emacs     .emacs
echo
