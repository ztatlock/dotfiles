#!/usr/bin/env bash

set -u # reading an unset variable is an error
set -e # exit on error

function BANNER {
  echo
  echo
  figlet "$@"
}

function cmd_exists {
  [ -n "$(command -v "$1")" ]
}

if cmd_exists "brew"; then
  BANNER Homebrew
  brew update
  brew upgrade
fi

if cmd_exists "opam"; then
  BANNER OCaml
  opam update
  opam upgrade
fi

if cmd_exists "raco"; then
  BANNER Racket
  raco pkg update --all
fi

if cmd_exists "rustup"; then
  BANNER Rust
  rustup update
fi

if cmd_exists "stack"; then
  BANNER Haskell
  stack update
  stack upgrade
fi

if cmd_exists "tlmgr"; then
  BANNER TeX Live
  # To update without root:
  # https://tex.stackexchange.com/questions/288667/tex-live-permissions-on-os-x
  # sudo chown -R ztatlock /usr/local/texlive
  #
  # To fix "package forcibly removed":
  # https://tex.stackexchange.com/questions/107286/what-does-skipping-forcibly-removed-package-xxx-mean-should-i-care-about-it
  # tlmgr update --all --reinstall-forcibly-removed
  tlmgr update --self
  tlmgr update --all
fi

if cmd_exists "npm"; then
  BANNER npm
  npm update -g
fi
