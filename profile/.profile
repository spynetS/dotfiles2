#!/usr/bin/bash

export QT_QPA_PLATFORMTHEME=qt6ct
export EDITOR=emacsclient
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export jgazm="/usr/bin/jgazm"
# fix "xdg-open fork-bomb" export your preferred browser from here
export BROWSER=/usr/bin/firefox
setxkbmap us
export TERM=alacritty
export FILE_EXPLORER=dolphin



./.screenlayout/main.sh
#./.config/polybar/launch.sh --cuts

mpd &
mpDris2 &

wal -R -n -a 75 &
nitrogen --restore &

emacs --daemon &
