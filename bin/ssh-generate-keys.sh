#!/usr/bin/env bash

echo
echo "About to delete any existing ssh keys."
read -p "Cool (y/n)? " yn

case $yn in
  y)
    echo
    cd ~/.ssh
    rm -f id_rsa*
    ssh-keygen -t rsa -C "$(whoami)@$(hostname)"
    ;;
  *)
    echo "No changes made."
    ;;
esac
