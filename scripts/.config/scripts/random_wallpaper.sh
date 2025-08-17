#!/bin/bash

# Directory to save wallpapers
WALL_DIR="$HOME/Pictures/Noctax-Wallpapers"
mkdir -p "$WALL_DIR"

IMAGE=$(find $WALL_DIR -type f | shuf -n 1)
echo $IMAGE
# Make sure swww is running
if ! pgrep -x "swww-daemon" > /dev/null; then
    swww-daemon &
    sleep 1
fi

# Set wallpaper using swww with a transition
swww img "$IMAGE" --transition-type any --transition-step 90 --transition-fps 60
wal -i "$IMAGE"
alacritty_wal
