#!/usr/bin/env sh

while true; do
  eww update day="$(date '+%A')"
  eww update date="$(date '+%B %d, %Y')"
  eww update time="$(date '+%H:%M:%S')"
  sleep 5
done
