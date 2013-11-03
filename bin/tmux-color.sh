#!/usr/bin/env bash

case "$1" in
  "background"|"bg")
    case $(hostname -s) in
      "herringbone"|"houndstooth")
        echo "colour124"
        ;;
      "totalcrazyhack")
        echo "colour25"
        ;;
      *)
        echo "colour220"
        ;;
    esac
    ;;
  *)
    echo "ERROR: Sorry, I don't know how to '$1'"
    ;;
esac
