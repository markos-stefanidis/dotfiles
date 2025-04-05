#!/bin/bash
hyprland-workspaces _ | jq 'to_entries 
    | map({item: .value, counter: (.key + 1)}) 
    | map(.item.workspaces = ([range(10*.counter-9; 10*.counter+1)
    | {active:false,class:"workspace-button w\(tostring) workspace-unoccupied",id:tonumber,name:tostring}] as $all
    | (.item.workspaces + $all)
    | unique_by(.id)
    | sort_by(.id | tonumber) ))
    | map(. = .item)'

