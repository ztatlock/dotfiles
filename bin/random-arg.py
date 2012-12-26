#!/usr/bin/env python

import sys, random

try:
  print random.choice(sys.argv[1:])
except:
  sys.exit(1)
