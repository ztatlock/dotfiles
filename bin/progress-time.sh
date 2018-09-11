#!/usr/bin/env bash

X="$(mktemp)"

cat > "$X"

echo -n 'Working: '
cat "$X" \
  | fold -w 1 \
  | grep W \
  | awk 'END {print NR / 4}'

echo -n 'Meeting: '
cat "$X" \
  | fold -w 1 \
  | grep m \
  | awk 'END {print NR / 4}'
