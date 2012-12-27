#!/usr/bin/env bash

# read text from stdin and convert to img
pbmtext -builtin fixed -space 1 -lspace 5 | convert pbm:- "$1"
