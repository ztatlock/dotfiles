#!/usr/bin/env bash

set -u # reading an unset variable is an error
set -e # exit on error

function BANNER {
  echo
  echo
  figlet "$@"
}

BANNER Homebrew
brew update
brew upgrade

BANNER OCaml
opam update
opam upgrade

BANNER Racket
raco pkg update --all

BANNER Rust
rustup update

BANNER Haskell
stack update
stack upgrade

BANNER TeX Live
# To update without root:
# https://tex.stackexchange.com/questions/288667/tex-live-permissions-on-os-x
# sudo chown -R ztatlock /usr/local/texlive
#
# To fix "package forcibly removed" stuff:
# https://tex.stackexchange.com/questions/107286/what-does-skipping-forcibly-removed-package-xxx-mean-should-i-care-about-it
# tlmgr update --all --reinstall-forcibly-removed
tlmgr update --self
tlmgr update --all

BANNER Python3
pip3 list --outdated
pip3 list --outdated \
  | sed 1,2d \
  | cut -f1 -d' ' \
  | xargs pip3 install --upgrade

BANNER npm
npm update
npm update -g
