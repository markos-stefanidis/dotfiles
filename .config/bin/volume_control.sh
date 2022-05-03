#!/bin/bash

case $1 in
	-u)
		amixer -c 1 set Master 2%+
		;;
	-d)
		amixer -c 1 set Master 2%-
		;;
esac

volume_level=$(amixer -c 1 get Master | awk 'END {print $4}' | cut -d"[" -f2 | cut -d"%" -f1)
echo $volume_level
dunstify "Volume change" -h int:value:$volume_level -r 9503 -u normal -t 1000
