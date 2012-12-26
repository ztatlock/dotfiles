#!/usr/bin/env bash

mencoder \
  -forceidx -of lavf -oac mp3lame -lameopts abr:br=128 -srate 22050 -ovc lavc \
  -lavcopts vcodec=flv:vbitrate=1800:mbd=2:mv0:trell:v4mv:cbp:last_pred=3     \
  -vf scale=400:300 -o $1.flv $1
