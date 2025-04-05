#!/bin/bash

active_port=$(pactl list | grep "active port" |cut -f 2- -d"<" | cut -f1 -d ">" | grep output)

if [[ $active_port == "analog-output-lineout" ]]
then
	pactl set-sink-port 0 analog-output-headphones
  echo "1"
else
	pactl set-sink-port 0 analog-output-lineout
  echo "2"
fi
