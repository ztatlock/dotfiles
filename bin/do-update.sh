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

# ANSI color codes
BLK=$'\033[1;30m' # black
RED=$'\033[1;31m' # red
GRN=$'\033[1;32m' # green
YLO=$'\033[1;33m' # yellow
BLU=$'\033[1;34m' # blue
MAG=$'\033[1;35m' # magenta
CYN=$'\033[1;36m' # cyan
WHT=$'\033[1;37m' # white
CLR=$'\033[0m'    # no color

if command -v brew &> /dev/null; then
  echo
  echo "# Brew"

  brew update
  brew upgrade

  # occasional clean up
  if [ $(($(date +%e) % 3)) -eq 0 ]; then
    brew cleanup
    brew prune
    brew doctor
  fi
  echo
fi

if command -v opam &> /dev/null; then
  echo
  echo "# OPAM"

  opam update
  opam upgrade --yes
  echo
fi

echo
echo "# Dotfiles"

pushd "$MYDIR/.."
# ensure working directory is clean
if ! git diff-index --quiet HEAD --; then
  echo "${RED}"
  echo "!!!"
  echo "!!! ERROR: need to push dotfiles changes!"
  echo "!!!"
  echo "${CLR}"
  exit 1
fi
git pull
./install.sh

