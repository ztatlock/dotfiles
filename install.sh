#!/usr/bin/env bash

function slink {
  echo "  $1"
  ln -f -s "$(pwd)/$1" "$HOME/$2"
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
  slink "$s" "bin/$(basename $s)"
done
echo

echo "configs:"
slink bash/bashrc     .bashrc
slink bash/profile    .profile
slink vim/vimrc       .vimrc
slink git/gitconfig   .gitconfig
slink ssh/config      .ssh/config
slink tmux/tmux.conf  .tmux.conf
slink emacs/emacs     .emacs
echo

echo "extras:"
mkdir -p "$HOME/.dotfiles-config"
slink bash/git-prompt.sh     .dotfiles-config/git-prompt.sh
slink bash/git-completions   .dotfiles-config/git-completions
slink bash/todo-completions  .dotfiles-config/todo-completions
slink bash/alias-completions .dotfiles-config/alias-completions
slink emacs/elisp            .dotfiles-config/elisp
echo
