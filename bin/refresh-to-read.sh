#!/usr/bin/env bash

# exit on error
set -e

TO_READ="$HOME/Dropbox/to-read"

function main {
  prompt "Doug thesis" doug_thesis
  prompt "James thesis" james_thesis
  prompt "Pavel thesis" pavel_thesis
  prompt "Shumo thesis" shumo_thesis
  prompt "Heiko preconditions report" heiko_report
  prompt "BRASS report" brass_report
  prompt "Josh Theia draft" josh_theia
}

function prompt {
  name="$1"
  func="$2"

  echo
  read -p "Update $name (y/n)? " yn
  case $yn in
    y)
      $func &> /dev/null
      echo "Updated $name."
      ;;
    *)
      echo "Skipping $name."
      ;;
  esac
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

function heiko_report {
  cd "$HOME/research/CakeML_fastmath_Notes/Preconditions"
  git pull
  make clean
  make
  install introduction.pdf heiko-report.pdf
}

function brass_report {
  cd "$HOME/research/herbie-papers/reports/brass-phase-3"
  git pull
  make clean
  make
  install main.pdf herbie-brass-report.pdf
}

function josh_theia {
  cd "$HOME/research/theia-internal/splashe19v3"
  git pull
  make clean
  make
  install paper.pdf josh-theia-draft.pdf
}

main
