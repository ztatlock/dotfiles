#!/usr/bin/env bash

# ANSI color codes
export BLK=$'\033[1;30m' # black
export RED=$'\033[1;31m' # red
export GRN=$'\033[1;32m' # green
export YLO=$'\033[1;33m' # yellow
export BLU=$'\033[1;34m' # blue
export MAG=$'\033[1;35m' # magenta
export CYN=$'\033[1;36m' # cyan
export WHT=$'\033[1;37m' # white
export CLR=$'\033[0m'    # no color

function error {
  local msg="$1"

  local c0=""
  local c1=""
  [ -t 1 ] && c0="$RED" && c1="$CLR"

  echo "${c0}ERROR:${c1} $msg" >&2
  exit 1
}
export -f error

function warn {
  local msg="$1"

  local c0=""
  local c1=""
  [ -t 1 ] && c0="$YLO" && c1="$CLR"

  echo "${c0}Warning:${c1} $msg" >&2
}
export -f warn

function usage_error {
  local msg="$1"

  usage
  echo
  error "$msg"
}
export -f usage_error

function assert_nonnegi {
  local name="$1"
  local val="$2"

  case "$val" in
    ''|*[!0-9]*)
      usage_error "$name must be a nonnegative integer, got '$val'" ;;
    *) ;;
  esac
}
export -f assert_nonnegi

function prompt_yn {
  local msg="$1"
  local response

  read -p "$msg (y/n)? " response
  case "${response:0:1}" in
    y|Y) true  ;;
     * ) false ;;
  esac
}
export -f prompt_yn

function prompt_continue {
  if prompt_yn $'\nContinue'; then
    return 0
  else
    exit 0
  fi
}
export -f prompt_continue

# use GNU utils if available

export DATE="date"
command -v gdate > /dev/null 2>&1 && \
  DATE="gdate"

export TIME="command time"
command -v gtime > /dev/null 2>&1 && \
  TIME="command gtime"

export AWK="awk -W lint=fatal"
command -v gawk > /dev/null 2>&1 && \
  AWK="gawk -W lint=fatal"

export TIMEOUT="timeout"
command -v gtimeout > /dev/null 2>&1 && \
  TIMEOUT="gtimeout"

true
