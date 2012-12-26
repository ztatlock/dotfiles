#!/usr/bin/env bash

# patterns to color
BKPAT=black
RDPAT=red
GRPAT=green
YLPAT=yellow
BLPAT=blue
MGPAT=magenta
CYPAT=cyan
WTPAT=white

# ANSI color codes
BK=$'\033[1;30m' # black
RD=$'\033[1;31m' # red
GR=$'\033[1;32m' # green
YL=$'\033[1;33m' # yellow
BL=$'\033[1;34m' # blue
MG=$'\033[1;35m' # magenta
CY=$'\033[1;36m' # cyan
WT=$'\033[1;37m' # white
NC=$'\033[0m'    # no color

sed -e "s/$BKPAT/${BK}${BKPAT}${NC}/g" \
    -e "s/$RDPAT/${RD}${RDPAT}${NC}/g" \
    -e "s/$GRPAT/${GR}${GRPAT}${NC}/g" \
    -e "s/$YLPAT/${YL}${YLPAT}${NC}/g" \
    -e "s/$BLPAT/${BL}${BLPAT}${NC}/g" \
    -e "s/$MGPAT/${MG}${MGPAT}${NC}/g" \
    -e "s/$CYPAT/${CY}${CYPAT}${NC}/g" \
    -e "s/$WTPAT/${WT}${WTPAT}${NC}/g" $*

