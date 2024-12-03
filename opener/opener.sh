#!/usr/bin/env sh

RES=$(python /home/spy/dotfiles2/opener/export_b.py | fzf | awk '{split($0,a,"|"); print(a[2])}')

if [ $RES != "" ]; then
   devour firefox $RES
fi
