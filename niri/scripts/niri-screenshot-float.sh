#!/usr/bin/env bash

SCREENSHOT_DIR="$HOME/Pictures/Screenshots"

BEFORE=$(ls -t "$SCREENSHOT_DIR"/*.png 2>/dev/null | head -1)

niri msg action screenshot

for _ in {1..50}; do
    sleep 0.1
    LAST=$(ls -t "$SCREENSHOT_DIR"/*.png 2>/dev/null | head -1)

    if [ -n "$LAST" ] && [ "$LAST" != "$BEFORE" ]; then
        swayimg --config-file="/home/vaelen/.config/swayimg/config" --size=image "$LAST" &
        SWAYIMG_PID=$!
        break
    fi
done

[ -z "$LAST" ] && notify-send "Screenshot" "Timeout" && exit 1

sleep 0.2
