#!/usr/bin/env python

# generate random password

from random import choice

N = 15
A = 'abcdefghijklmnopqrstuvwxyz' + \
    'ABCDEFGHIJKLMNOPQRSTUVWXYZ' + \
    '1234567890' + \
    '!@#$%^&*()' + \
    '-_=+[]{}|;:",.<>?'

for i in range(N):
  for j in range(N):
    print choice(A),
  print ''
