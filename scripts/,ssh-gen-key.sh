#!/usr/bin/env bash

echo
echo "Deleting existing ssh keys."
read -p "OK (y/n)? " yn

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
