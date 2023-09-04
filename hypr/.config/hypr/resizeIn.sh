#!/bin/sh

INC=$1
OG=`hyprctl getoption general:gaps_in | awk 'FNR==2{print $2}'`
OG=`expr $OG + $INC`

hyprctl keywords general:gaps_in $OG

