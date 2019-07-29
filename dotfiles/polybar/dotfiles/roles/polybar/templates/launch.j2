#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch top and bottom
{% if launch_file.stat.exists %}
{% include 'by_host/' + ansible_hostname + '/launch.j2' %}
{% else %}
polybar top &
polybar bottom &
{% endif %}

echo "Bars launched..."
