#!/usr/bin/env bash

# exit on error
set -e

brew update
brew upgrade

# occasional clean up
if [ "$(bc <<< "$(date +"%e") % 3" -eq 0 ]; then
  brew cleanup
  brew prune
  brew doctor
fi

opam update
opam upgrade --yes

