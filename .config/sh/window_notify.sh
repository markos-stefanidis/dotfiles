#!/bin/bash
old_window=$(xdotool getwindowfocus)
sleep 0.1
current_window=$(xdotool getwindowfocus)

if [[ $old_window != $current_window ]];
then
	dunstify "Changed Focus" "Current window: $(xdotool getwindowfocus getwindowname)" -r 9500 -u low -t 1000
	#killall rofi
	#rofi -show window &
	#sleep 1
	#killall rofi
fi

