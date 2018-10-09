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
tally A "Advising"
tally R "Research Team"
tally r "Research Solo"
tally E "Education Group"
tally e "Education Solo"
tally C "Communication"
tally M "Management"
tally L "Logistics"
tally S "Service"

rm -f "$CODELINE"
