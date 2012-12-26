#!/usr/bin/env python

import sys, os.path, datetime

DB = os.path.expanduser('~/Dropbox/notes/important-dates.txt')

CATS = [ ('BIRTHDAY', 10)
       , ('DAVIS BIRTHDAY', 10)
       , ('TATLOCK BIRTHDAY', 10)
       , ('ANNIVERSARY', 10)
       , ('HOLIDAY', 10)
       , ('DEADLINE', 100)
       ]

MONTH = { 'Jan' : 1
        , 'Feb' : 2
        , 'Mar' : 3
        , 'Apr' : 4
        , 'May' : 5
        , 'Jun' : 6
        , 'Jul' : 7
        , 'Aug' : 8
        , 'Sep' : 9
        , 'Oct' : 10
        , 'Nov' : 11
        , 'Dec' : 12
        }

NOW = datetime.date.today()

def load():
  db = {}
  cat = None
  f = open(DB, 'r')
  for l in f:
    l = l.split()
    if len(l) < 2:
      continue
    elif l[0] == '>':
      cat = ' '.join(l[1:])
      db[cat] = []
    else:
      m = MONTH[l[0]]
      d = int(l[1])
      if (m, d) < (NOW.month, NOW.day):
        y = NOW.year + 1
      else:
        y = NOW.year
      dist = (datetime.date(y, m, d) - NOW).days
      event = ' '.join(l)
      db[cat].append((dist, event))
  f.close()
  return db

def main():
  db = load()
  if len(sys.argv) < 2:
    cats = CATS
  else:
    cats = [(c, h) for (c, h) in CATS if c in sys.argv]
  for (cat, horizon) in cats:
    ves = filter(lambda x: x[0] <= horizon, db[cat])
    if ves != []:
      print cat
      for (dist, event) in ves:
        if dist == 0:
          print '  %s (today!)' % event
        elif dist == 1:
          print '  %s (tomorrow)' % event
        else:
          print '  %s (%d days)' % (event, dist)
      print

main()
