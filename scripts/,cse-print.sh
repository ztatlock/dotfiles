#!/usr/bin/env bash

cat "$1" | ssh recycle.cs.washington.edu "lpr -Ppg224 -o sides=two-sided-long-edge"
