#!/bin/bash

current_layout=$(setxkbmap -query | awk 'END {print$2}')
case $current_layout in
us)
	setxkbmap gr
	;;
gr)
	setxkbmap us
	;;
*)
	setxkbmap us
	;;
esac
current_layout=$(setxkbmap -query | grep layout | awk '{print $2}')
echo $current_layout
dunstify "Changed Layout" "Current Layout: ${current_layout^^}" -r 9501

