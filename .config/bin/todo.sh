#!/bin/bash

#sleep 120;

if [ -s ~/.calcurse/todo ]; then

	file='/home/markos/.calcurse/todo'
	#todo_list=$(cat ~/.calcurse/todo)
	n=1
	todo_list=""
	while read line; do
		if [ "$(echo $line | awk '{print substr($0,4,1)}')" == '>' ]; then
			task=$(cut -f 2- -d" " <<< "$line")
			note_location=$(cut -f1 -d" " <<< "$line" | cut -f2 -d">")
			note=$(cat /home/markos/.calcurse/notes/$note_location)
			todo_list="$todo_list\n$n: $task\n\t> $note"
		else
			task=$(cut -f 2- -d" " <<< "$line")
			todo_list="$todo_list\n$n: $task"
		fi
		n=$((n+1))
	done < $file

	echo -e $todo_list



	dunstify "Hey There!" "Tasks at hand:\n$todo_list" -r 9502 -u normal -t 10000
else
	dunstify "Hey There!" "No tasks for today." -r 9502 -u nomral -t 10000
fi
