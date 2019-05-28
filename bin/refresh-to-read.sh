#!/usr/bin/env bash

# exit on error
set -e

TO_READ="$HOME/Dropbox/to-read"

function main {
  echo "Doug thesis"
  doug_thesis &> /dev/null

  echo "James thesis"
  james_thesis &> /dev/null

  echo "Pavel thesis"
  pavel_thesis &> /dev/null

  echo "Shumo thesis"
  shumo_thesis &> /dev/null

  echo "BRASS report"
  brass_report &> /dev/null
}

function install {
  path="$1"
  name="$2"
  dt=$(date '+%y%m%d-%H%M-')
  cp "$path" "$TO_READ/${dt}${name}"
}

function doug_thesis {
  cd "$HOME/research/dwoos-dissertation"
  git pull
  make clean
  make
  install dissertation.pdf doug-thesis.pdf
}

function james_thesis {
  wget "http://jamesrwilcox.com/thesis.pdf"
  install thesis.pdf james-thesis.pdf
  rm thesis.pdf
}

function pavel_thesis {
  cd "$HOME/research/cassius-papers/thesis"
  git pull
  make clean
  make
  install thesis.pdf pavel-thesis.pdf
}

function shumo_thesis {
  wget "https://homes.cs.washington.edu/~chushumo/files/thesis.pdf"
  install thesis.pdf shumo-thesis.pdf
  rm thesis.pdf
}

function brass_report {
  cd "$HOME/research/herbie-papers/reports/brass-phase-3"
  git pull
  make clean
  make
  install main.pdf herbie-brass-report.pdf
}

main
