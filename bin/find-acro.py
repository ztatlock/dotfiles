#!/usr/bin/env python

import sys, os.path

lets = sys.argv[1:]

def test(word):
  for l in lets:
    if not l in word:
      return False
  return True

p = os.path.expanduser('~/bin/words.txt')
f = open(p, 'r')
words = f.read().split('\n')
cands = filter(test, words)
cands = sorted(cands, key=len)
print '\n'.join(cands)
