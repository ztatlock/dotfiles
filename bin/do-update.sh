#!/usr/bin/env bash

# determine physical directory of this script
src="${BASH_SOURCE[0]}"
while [ -L "$src" ]; do
  dir="$(cd -P "$(dirname "$src")" && pwd)"
  src="$(readlink "$src")"
  [[ $src != /* ]] && src="$dir/$src"
done
export MYDIR="$(cd -P "$(dirname "$src")" && pwd)"

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

function main {
  # exit on error
  set -e

  echo
  echo "# Dotfiles"

  pushd "$MYDIR/.."
  git fetch
  # ensure working directory is clean and up to date
  if ! git merge-base --is-ancestor master origin/master \
  || ! git diff-index --quiet HEAD; then
    echo "${RED}
!!!
!!! ERROR: dotfiles repo is not up to date
!!!
${CLR}"
    exit 1
  fi
  git pull
  ./install.sh
  popd

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
}

if main; then
  echo "${GRN}Success.${CLR}"
else
  echo "${RED}
!!!
!!! ERROR: update did not complete
!!!
${CLR}"
fi
