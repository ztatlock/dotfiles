#!/usr/bin/env bash

if [ "$(uname)" = "Darwin" ]; then
  open /Applications/Google\ Chrome.app "$@"
else
  chromium-browser "$@"
fi
