#!/usr/bin/env sh

RES=$(python /home/spy/dotfiles2/opener/export_b.py | fzf)

if [ $RES != "" ]; then
   devour firefox $RES
fi
