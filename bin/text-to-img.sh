#!/usr/bin/env bash

# read text from stdin
pbmtext -builtin fixed -space 1 -lspace 5 > $$.pbm
convert $$.pbm $1
rm $$.pbm
