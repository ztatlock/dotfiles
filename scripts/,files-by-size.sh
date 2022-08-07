#!/usr/bin/env bash

# https://askubuntu.com/questions/558979/how-to-display-disk-usage-by-file-type
find -type f -printf '%f %s\n' | awk '
  {
    split($1, a, ".");       # first token is filename
    ext = a[length(a)];      # only take the extension part of the filename
    size = $2;               # second token is file size
    total_size[ext] += size; # sum file sizes by extension
  }
  END {
    # print sums
    for (ext in total_size) {
      print ext, total_size[ext];
    }
  }'
