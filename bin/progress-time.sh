#!/usr/bin/env bash

MODE="PROGRESS"
if [ "$1" = "-s" ]; then
  MODE="SPREADSHEET"
fi

CODELINE="$(mktemp)"

cat > "$CODELINE"

FIRST=true
function tally {
  t=$(cat "$CODELINE" \
      | fold -w 1 \
      | grep "$1" \
      | awk 'END {print NR / 4}')
  case "$MODE" in
    "PROGRESS")
      if [ $(echo "$t > 0" | bc -l) = "1" ]; then
        printf "  %0.2f - %s\n" "$t" "$2"
      fi
      ;;
    "SPREADSHEET")
      if $FIRST; then
        FIRST=false
      else
        printf ", "
      fi
      if [ $(echo "$t > 0" | bc -l) = "1" ]; then
        printf "%0.2f" "$t"
      fi
      ;;
    *)
      echo "Invalid mode!"
      exit 1
      ;;
  esac
}

if [ "$MODE" = "PROGRESS" ]; then
  echo "Breakdown:"
fi

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

if [ "$MODE" = "SPREADSHEET" ]; then
  echo
fi

rm -f "$CODELINE"
