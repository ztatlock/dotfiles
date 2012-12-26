#!/usr/bin/env bash

function usage {
  echo "Usage: $(basename $0) [-n NUMBER] [-l LABEL] [-v]"
  exit 1
}

if [ $# -lt 1 ]; then
  usage
fi

NUM=0
LBL=0
VRB=0

while getopts "n:l:v" OPT; do
  case "$OPT" in
    "n") NUM=$OPTARG ;;
    "l") LBL=$OPTARG ;;
    "c") VRB=1 ;;
      *) usage ;;
  esac
done
