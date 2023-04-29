#!/bin/bash

xrandr --output DP-0 --primary
xrandr --output HDMI-0 --mode 1280x1024 --noprimary --left-of DP-0
xset s off -dpms
picom  #--experimental-backends --backend glx &
nitrogen --restore &
dunst &
