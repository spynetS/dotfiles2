#!/usr/bin/zsh

cd ~/dev
P=$(fd . "/home/spy" | fzf --algo=v1)
if [ $P != "" ]; then
emacsclient -c -nw $P
fi
