#!/usr/bin/env bash

P="$HOME/Dropbox/progress/$(gdate +'%y%m%d' -d 'last saturday').md"

$EDITOR "$P"
