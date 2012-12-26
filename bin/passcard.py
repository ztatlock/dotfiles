#!/usr/bin/env python

# based on:
#   http://www.passwordcard.org/en
# after reading:
#   http://www.schneier.com/blog/archives/2005/06/write_down_your.html
#   http://www.schneier.com/blog/archives/2010/11/changing_passwo.html
#   https://www.schneier.com/blog/archives/2012/09/recent_developm_1.html

from random import choice

K = 'abcdefghijklmnopqrstuvwxyz'
V = 'abcdefghijklmnopqrstuvwxyz' + \
    'ABCDEFGHIJKLMNOPQRSTUVWXYZ' + \
    '1234567890' + \
    '!@#$%^&*()' + \
    '-_=+[]{}|;:",.<>?'

## too long, need 2 cols
#for k in K:
#  print '%s : %s%s' % (k, choice(V), choice(V))

N  = len(K) / 2
K1 = K[:N]
K2 = K[N:]

for i in range(N):
  v1 = '%s : %s%s' % (K1[i], choice(V), choice(V))
  v2 = '%s : %s%s' % (K2[i], choice(V), choice(V))
  print '%s  |  %s' % (v1, v2)
