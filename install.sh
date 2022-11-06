#!/usr/bin/env bash

###############################################################################
# exit loudly if anything errors
###############################################################################

set -o errexit
set -o errtrace

function fail {
  echo "
!!!
!!! ERROR
!!!
" >&2
  exit 1
}

trap fail ERR
trap fail SIGINT

###############################################################################
# determine this script's directory
###############################################################################

src="${BASH_SOURCE[0]}"
while [ -L "$src" ]; do
  dir="$(cd -P "$(dirname "$src")" && pwd)"
  src="$(readlink "$src")"
  [[ $src != /* ]] && src="$dir/$src"
done

MYDIR="$(cd -P "$(dirname "$src")" && pwd)"

###############################################################################
# chatty symbolic linker
###############################################################################

function install {
  src="$1"
  tgt="$2"

  echo "$src --> $tgt"

  [ -r "$src" ]
  ln -sf "$src" "$tgt"
}

###############################################################################
# install configs
###############################################################################

echo
echo "CONFIGS"
cd "$MYDIR/configs"
install "$(pwd)/profile" "$HOME/.profile"
install "$(pwd)/profile" "$HOME/.bash_profile"
install "$(pwd)/bash"    "$HOME/.bashrc"
install "$(pwd)/vim"     "$HOME/.vimrc"
install "$(pwd)/git"     "$HOME/.gitconfig"
install "$(pwd)/ssh"     "$HOME/.ssh/config"
install "$(pwd)/ssh-rc"  "$HOME/.ssh/rc"
install "$(pwd)/tmux"    "$HOME/.tmux.conf"

###############################################################################
# install scripts
###############################################################################

mkdir -p "$HOME/bin"

echo
echo "SCRIPTS"
cd "$MYDIR/scripts"
for s in *; do
  install "$(pwd)/$s" "$HOME/bin/$(basename "$s")"
done
