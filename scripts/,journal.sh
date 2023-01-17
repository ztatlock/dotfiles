#!/usr/bin/env bash

JOURNAL="$HOME/Desktop/journal"

code --new-window \
  "$JOURNAL" \
  "$JOURNAL/journal.md" \
  "$JOURNAL/todo.md" \
  "$JOURNAL"/todo-*.md
