#!/usr/bin/env bash

set -u # reading an unset variable is an error
set -e # exit on error

brew update
brew upgrade

opam update
opam upgrade

rustup update
