#!/usr/bin/env bash

awk '{print length"\t"$0}' | sort -n | cut -f 2 -
