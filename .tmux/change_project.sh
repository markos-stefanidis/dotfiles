#!/bin/bash

project_dir="$HOME/.tmux/projects"

function getProjects () {
  selection=$(ls $1 | fzf --tmux)

  if [[ -d "$1/$selection" ]]; then
    # Selection is a directory
    getProjects "$1/$selection"
    return $?
  elif [[ -f "$1/$selection" ]]; then
    # Selection is a file
    tmux has-session -t "$selection" 2>/dev/null
    session_not_found=$?

    if [[ $session_not_found != 0 && $session_not_found != 1 ]]; then
      echo "Session was neither found attached nor found not-attached."
      echo "Something weird happened."
      return 1
    fi

    if [[ $session_not_found == 1 ]]; then
      source $1/$selection
    fi

    if [[ -n $TMUX ]]; then
      # Already inside tmux. Switch client
      tmux switch-client -t $selection
    else
      # Outside tmux. Attach session
      tmux attach -t $selection
    fi

    if [[ $session_not_found == 1 ]]; then
      tmux select-window -t $selection:1
    fi

    return 0
  else
    echo "Selection was neither a directory nor a file."
    echo "Something weird happened."
    return 2
  fi
}

getProjects $project_dir
