#!/usr/bin/env bash

f=$(mktemp "get-ip-XXXX")
wget -q -O $f "http://automation.whatismyip.com/n09230945.asp"
cat $f
echo
rm $f
