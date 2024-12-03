#!/bin/bash

LAYOUT=$(setxkbmap -query | awk 'FNR==3{ print $2}')

if [ $LAYOUT == "us" ] 
then
	setxkbmap se;
else
	setxkbmap us;
fi;

