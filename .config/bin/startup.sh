#!/bin/bash

xrandr --output HDMI-0 --primary
xset s off -dpms
picom --experimental-backends --backend glx &
nitrogen --restore &
dunst &

