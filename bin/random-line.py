#!/usr/bin/env python

import sys, random

try:
  f = open(sys.argv[1], 'r')
  x = f.readlines()
  f.close()
  print random.choice(x)
except:
  sys.exit(1)
