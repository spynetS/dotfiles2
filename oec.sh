#!/usr/bin/zsh

cd ~/dev
P=$(fzf --algo=v1)
if [ $P != "" ]; then
emacsclient -c $P
fi
