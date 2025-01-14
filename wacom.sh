#!/usr/bin/sh

xinput map-to-output $(xinput | fzf | grep -oP 'id=\K\d+') DP-2
