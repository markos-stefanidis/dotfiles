#!/bin/bash

# Terminate already running bar instaces
killall -q polybar

# Wait unitl the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch polybar, using default config location ~/.config/polybar/config
polybar markos &
