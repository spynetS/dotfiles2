#!/usr/bin/env bash
window_id="$1"

if [ -n "$window_id" ]; then
  niri msg --json <<< "{\"Action\":{\"FocusWindow\":{\"id\":$window_id}}}"
fi
