#!/usr/bin/env bash

OUTPUT="$HOME/Downloads/project-code.txt"

# clear any old output
rm -rf "$OUTPUT"

# add dir structure, ignoring .venv
echo "===================================" >> "$OUTPUT"
echo "PROJECT DIRECTORY STRUCTURE        " >> "$OUTPUT"
echo "===================================" >> "$OUTPUT"
tree --prune \
  -I "_build" \
  -I ".venv" \
  -I "__pycache__" \
  -I "dist" \
  -I "node_modules" \
  -I "eslint.config.js" \
  -I "package-lock.json" \
  -I "package.json" \
  -I "vite-env.d.ts" \
  -I "tsconfig.app.json" \
  -I "tsconfig.json" \
  -I "tsconfig.node.json" \
  -I "vite.config.ts" \
  -I '*.log' \
  >> "$OUTPUT"
echo -e "\n\n" >> "$OUTPUT"

# find source files
find . \
  -type d -name "_build"       -prune -o \
  -type d -name ".venv"        -prune -o \
  -type d -name "__pycache__"  -prune -o \
  -type d -name "dist"         -prune -o \
  -type d -name "node_modules" -prune -o \
  -type f \( \
    -name "*.c"    -o \
    -name "*.cpp"  -o \
    -name "*.css"  -o \
    -name "*.h"    -o \
    -name "*.hpp"  -o \
    -name "*.html" -o \
    -name "*.js"   -o \
    -name "*.md"   -o \
    -name "*.ml"   -o \
    -name "*.mli"  -o \
    -name "*.py"   -o \
    -name "*.rs"   -o \
    -name "*.sh"   -o \
    -name "*.ts"   -o \
    -name "Makefile" \
  \) -print \
| while read -r file; do
  # add header
  echo "===================================" >> "$OUTPUT"
  echo "File: $file" >> "$OUTPUT"
  echo "===================================" >> "$OUTPUT"

  # file content
  cat "$file" >> "$OUTPUT"
  echo -e "\n\n" >> "$OUTPUT"
done
