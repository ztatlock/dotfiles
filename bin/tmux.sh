#!/usr/bin/env bash

function status-bg {
  case $1 in
    houndstooth)
      echo colour178 ;;
    sharkskin)
      echo colour001 ;;
    warfa)
      echo colour041 ;;
    pipsqueak)
      echo colour033 ;;
    uwplse)
      echo colour098 ;;
    tatlock)
      echo colour245 ;;
    recycle|tricycle|bicycle|boom|bam)
      echo colour011 ;;
    *)
      echo colour046 ;;
  esac
}

tmux -2 new-session -d -s $$
tmux set -g status-bg $(status-bg $(hostname -s))
tmux -2 attach-session -t $$
