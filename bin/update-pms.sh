#!/usr/bin/env bash

# exit on error
set -e

echo "Brew:"

brew update
brew upgrade

# occasional clean up
if [ $(($(date +%e) % 3)) -eq 0 ]; then
  brew cleanup
  brew prune
  brew doctor
fi

echo "OPAM:"

opam update
opam upgrade --yes

