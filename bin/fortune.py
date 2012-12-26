#!/usr/bin/env python

import sys, os.path, random

jars = [ '~/Dropbox/notes/quotes.txt'
       , '~/Dropbox/notes/words.txt'
       ]
jar = random.choice(jars)
jar = os.path.expanduser(jar)

f = open(jar, 'r')
cookies = f.read().split('<<<>>>')
f.close()

c = random.choice(cookies)
print c.strip()
