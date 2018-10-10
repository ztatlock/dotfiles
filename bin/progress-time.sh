#!/usr/bin/env bash

CODELINE="$(mktemp)"

cat > "$CODELINE"

function tally {
  t=$(cat "$CODELINE" \
      | fold -w 1 \
      | grep "$1" \
      | awk 'END {print NR / 4}')
  if [ $(echo "$t > 0" | bc -l) = "1" ]; then
    printf "  %0.2f - %s\n" "$t" "$2"
  fi
}

echo "Breakdown:"
tally r "Research Solo"
tally R "Research Confab"
tally a "Advising Tasks"
tally A "Advising Confab"
tally L "Learning"
tally T "Teaching"
tally E "Education"
tally C "Comms"
tally S "Service"
tally M "Management"
tally m "Misc."

rm -f "$CODELINE"