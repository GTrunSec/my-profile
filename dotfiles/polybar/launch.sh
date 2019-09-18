#!/usr/bin/env sh

# Terminate already running bar instances
kill -9 $(pgrep polybar)

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch top and bottom
#polybar top &
polybar bottom &
