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
# build fortune databases
###############################################################################

echo
echo "FORTUNES"
cd "$MYDIR/fortunes"

make

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

# ensure necessary directories exist
mkdir -p "$HOME/.ssh"

install "$(pwd)/bashrc" "$HOME/.bashrc"
install "$(pwd)/gitattributes" "$HOME/.gitattributes"
install "$(pwd)/gitconfig" "$HOME/.gitconfig"
install "$(pwd)/profile" "$HOME/.bash_profile"
install "$(pwd)/profile" "$HOME/.profile"
install "$(pwd)/ssh-config" "$HOME/.ssh/config"
install "$(pwd)/tmux.conf" "$HOME/.tmux.conf"
install "$(pwd)/vimrc" "$HOME/.vimrc"
install "$(pwd)/zshrc" "$HOME/.zshrc"

###############################################################################
# install scripts
###############################################################################

echo
echo "SCRIPTS"
cd "$MYDIR/scripts"

mkdir -p "$HOME/bin"

for s in *; do
  install "$(pwd)/$s" "$HOME/bin/$(basename "$s")"
done
