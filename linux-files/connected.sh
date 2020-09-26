#!/bin/sh
echo "Maypad device connected at $(date)" >> /tmp/maypad_scripts.log
cat /proc/bus/input/devices | grep -A 4 '"KeyHive maypad"' | grep event | cut -f 5 -d " " | tr -d '\n' | /bin/exfilpad

