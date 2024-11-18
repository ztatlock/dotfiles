#!/usr/bin/env bash

OUTPUT="project-code.txt"

# clear any old output
rm -rf "$OUTPUT"

# add dir structure
echo "===================================" >> "$OUTPUT"
echo "PROJECT DIRECTORY STRUCTURE" >> "$OUTPUT"
echo "===================================" >> "$OUTPUT"
tree >> "$OUTPUT"
echo -e "\n\n" >> "$OUTPUT"

find . -type f \( \
       -name "*.c" \
    -o -name "*.cpp" \
    -o -name "*.css" \
    -o -name "*.h" \
    -o -name "*.hpp" \
    -o -name "*.html" \
    -o -name "*.js" \
    -o -name "*.md" \
    -o -name "*.ml" \
    -o -name "*.mli" \
    -o -name "*.py" \
    -o -name "*.rs" \
    -o -name "*.sh" \
    -o -name "*.ts" \
    -o -name "Makefile" \
\) | while read -r file; do
    # add header
    echo "===================================" >> "$OUTPUT"
    echo "File: $file" >> "$OUTPUT"
    echo "===================================" >> "$OUTPUT"

    # file content
    cat "$file" >> "$OUTPUT"
    echo -e "\n\n" >> "$OUTPUT"
done
