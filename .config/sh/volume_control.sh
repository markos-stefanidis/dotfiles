#!/bin/bash

volume_level=$(pactl get-sink-volume 0 | awk 'NR==1 {print $5}' | cut -d"%" -f1)

case $1 in
	-u)
      if [[ $volume_level -lt 200 ]]; then
         pactl set-sink-volume 0 +2%
      fi
		;;
	-d)
      pactl set-sink-volume 0 -2%
		;;
esac

volume_level=$(pactl get-sink-volume 0 | awk 'NR==1 {print $5}' | cut -d"%" -f1)

echo $volume_level

if [[ $volume_level -le 100 ]]; then
   dunstify "Volume change" -h int:value:$volume_level -r 9503 -u normal -t 1000
   echo "Im in th eif"
else
   (( volume_level -= 100 ))
   echo "Im in th else"
   dunstify "Volume change" -h int:value:$volume_level -h string:hlcolor:#ff0000 -r 9503 -u normal -t 1000
fi
