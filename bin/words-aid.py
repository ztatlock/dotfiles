#!/usr/bin/env python

import sys, os.path

x = sys.argv[1]
WILD = x.count('*')
BANK = sorted(x.replace('*', ''))

def test(word):
  def aux(nw, w, b):
    if w == []:
      return True
    elif b == []:
      return False
    elif w[0] == b[0]:
      return aux(nw, w[1:], b[1:])
    elif nw < WILD:
      return aux(nw+1, w[1:], b) or aux(nw, w, b[1:])
    else:
      return aux(nw, w, b[1:])
  return aux(0, sorted(word), BANK)

p = os.path.expanduser('~/bin/words.txt')
f = open(p, 'r')
words = f.read().split('\n')
cands = filter(test, words)
cands = sorted(cands, key=len)
print '\n'.join(cands)
