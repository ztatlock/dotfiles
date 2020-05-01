#!/usr/bin/env bash

# determine physical directory of this script
src="${BASH_SOURCE[0]}"
while [ -L "$src" ]; do
  dir="$(cd -P "$(dirname "$src")" && pwd)"
  src="$(readlink "$src")"
  [[ $src != /* ]] && src="$dir/$src"
done
MYDIR="$(cd -P "$(dirname "$src")" && pwd)"

# ANSI color codes
RED=$'\033[1;31m' # red
GREEN=$'\033[1;32m' # green
CLEAR=$'\033[0m'    # no color

function error {
  echo "${RED}
!!!
!!! ERROR: $@
!!!
${CLEAR}" >&2
  exit 1
}

function fail {
  error "update did not complete"
}

trap fail ERR
trap fail SIGINT

echo
echo "# Dotfiles"
pushd "$MYDIR/.." &> /dev/null
git fetch
# ensure working directory is clean and up to date
if ! git merge-base --is-ancestor master origin/master \
|| ! git diff-index --quiet HEAD \
|| [ $(git ls-files --exclude-standard --others | wc -c) -ne 0 ]; then
  error "dotfiles repo is not up to date"
fi
git pull
./install.sh
popd &> /dev/null

echo "# tmux Plugin Manager"
pushd "$HOME/.tmux/plugins/tpm" &> /dev/null
git pull
popd &> /dev/null

if command -v brew &> /dev/null; then
  echo
  echo "# Brew"
  brew update
  brew upgrade

  # occasional clean up
  if [ $(($(date +%e) % 3)) -eq 0 ]; then
    brew cleanup
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

echo "${GREEN}Success.${CLEAR}"
