#!/usr/bin/env bash

function main {
  SRC=$(mktemp mt-XXXXX)
  TST=$(mktemp mt-XXXXX)

  find-src > $SRC
  grep -i 'test\|regression' $SRC > $TST

  printf 'source files  : %8s\n' $(line-count $SRC)
  printf 'testing files : %8s\n' $(line-count $TST)
  printf 'source lines  : %8s\n' $(line-count-foreach $SRC)
  printf 'testing lines : %8s\n' $(line-count-foreach $TST)

  rm $SRC
  rm $TST
}

function find-src {
  find . -name '*.c'    \
     -or -name '*.h'    \
     -or -name '*.cpp'  \
     -or -name '*.cc'   \
     -or -name '*.hpp'  \
     -or -name '*.ll'   \
     -or -name '*.java' \
     -or -name '*.py'
}

function line-count {
  awk 'END {print NR}' $1
}

function line-count-foreach {
  for f in $(cat $1); do
    line-count $f
  done | sum
}

function sum {
  awk 'BEGIN {TOT = 0}        \
             {TOT = TOT + $1} \
       END   {print TOT}'
}

main
