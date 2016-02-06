#!/usr/bin/env bash

brew update \
  && brew upgrade \
  && brew cleanup \
  && brew prune \
  && brew linkapps \
  && brew doctor
