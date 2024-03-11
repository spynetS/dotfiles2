#!/usr/bin/env sh

kill $(xprop | grep -i pid | awk '{print $3}')
