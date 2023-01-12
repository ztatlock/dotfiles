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

BANNER Rust
rustup update

BANNER Haskell
stack update
stack upgrade
