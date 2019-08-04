#!/usr/bin/env bash

# exit on error
set -e

TO_READ="$HOME/Desktop/to-read"

function main {
  prompt "Relay ASPLOS" relay_asplos
  prompt "BRASS report" brass_report
  prompt "Heiko preconditions report" heiko_report
  prompt "James thesis" james_thesis

  #prompt "Josh Theia draft" josh_theia
  #prompt "Doug thesis" doug_thesis
  #prompt "Pavel thesis" pavel_thesis
  #prompt "Shumo thesis" shumo_thesis
}

function prompt {
  name="$1"
  func="$2"

  echo
  read -p "Update $name (y/n)? " yn
  case $yn in
    y)
      echo "Updating $name ..."
      #$func &> /dev/null &
      $func
      ;;
    *)
      echo "Skipping $name"
      ;;
  esac
}

function install {
  path="$1"
  name="$2"
  dt=$(date '+%y%m%d-%H%M-')
  cp "$path" "$TO_READ/${dt}${name}"
}

function relay_asplos {
  cd "$HOME/research/pl4ml/asplos20"
  git pull
  make clean
  make
  install paper.pdf relay-asplos-draft.pdf
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
