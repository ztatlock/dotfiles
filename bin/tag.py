#!/usr/bin/env python

import os, os.path, sys, re

def main():
  for p in find_mp3s():
    s = mp3(p)
    s.parse()
    s.tag()
    print s,

class mp3:
  def __init__(self, p):
    self.path = p

  def parse(self):
    P = '^.*/(.*)/(....) (.*)/(..) (.*).mp3$'
    m = re.match(P, self.path)
    if m != None:
      self.artist = m.group(1)
      self.year   = int(m.group(2))
      self.album  = m.group(3)
      self.track  = int(m.group(4))
      self.title  = m.group(5)
      self.art    = os.path.join(os.path.dirname(self.path), 'album.jpg')
    else:
      print 'PARSE FAIL: %s' % self.path
      sys.exit(1)

  def tag(self):
    cmd  = 'eyeD3'
    cmd += ' --remove-all'  # nuke any prev tags
    cmd += ' --artist="%s"' % self.artist
    cmd += ' --year=%d'     % self.year
    cmd += ' --album="%s"'  % self.album
    cmd += ' --track=%d'    % self.track
    cmd += ' --title="%s"'  % self.title
    cmd += ' --add-image="%s":FRONT_COVER' % self.art
    cmd += ' "%s"'          % self.path
    cmd += ' > /dev/null 2>&1'

    if os.system(cmd) != 0:
      print 'TAG FAIL: %s\n\n%s\n' % (self.path, cmd)
      sys.exit(1)

  def __str__(self):
    return '''
%s
artist : %s
year   : %d
album  : %s
track  : %d
title  : %s
''' % ( self.path
      , self.artist
      , self.year
      , self.album
      , self.track
      , self.title
      )

def find_mp3s():
  mp3s = []
  for (root, dirs, files) in os.walk('.'):
    for f in files:
      if f.endswith('.mp3'):
        p = os.path.abspath(os.path.join(root, f))
        mp3s.append(p)
  return mp3s

main()
