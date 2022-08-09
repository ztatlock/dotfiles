#!/usr/bin/env bash

# TODO switch to ed25519
# https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent

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
