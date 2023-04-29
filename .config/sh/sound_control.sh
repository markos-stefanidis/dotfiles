#!/bin/bash

active_port=$(pacmd list | grep "active port" |cut -f 2- -d"<" | cut -f1 -d ">" | grep output)

if [ $active_port == "analog-output-lineout" ]
then
	pacmd set-sink-port 0 analog-output-headphones
	echo " "
else
	pacmd set-sink-port 0 analog-output-lineout
	echo "墳 "
fi
