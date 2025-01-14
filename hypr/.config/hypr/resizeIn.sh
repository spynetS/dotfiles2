#!/bin/sh

INC=$1
OG=`hyprctl getoption general:gaps_in | awk 'FNR==1{print $3}'`
OG=`expr $OG + $INC`

hyprctl keywords general:gaps_in $OG

