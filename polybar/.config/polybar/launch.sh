#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
# while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    echo $m
    MONITOR=$m polybar -q bar &
  done
else
  polybar -q bar &
fi

echo "Polybar launched..."
