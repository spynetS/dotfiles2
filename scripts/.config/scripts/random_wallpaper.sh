#!/bin/bash

# Directory to save wallpapers
WALL_DIR="$HOME/Pictures/wallpaper"
mkdir -p "$WALL_DIR"

IMAGE=$(find $WALL_DIR -type f | shuf -n 1)

#feh --bg-scale $IMAGE
swaybg --image $IMAGE

# Set it as wallpaper using feh
wal -i $IMAGE
feh --bg-scale $IMAGE
