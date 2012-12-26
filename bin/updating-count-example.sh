#!/usr/bin/env bash

MAX=30

for i in $(seq $MAX); do
  echo -n -e "Processed $i/$MAX \r"
  sleep 1
done
