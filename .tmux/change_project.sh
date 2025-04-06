#!/bin/bash

project_dir="$HOME/.tmux/projects"

function getProjects () {
  selection=$(ls $1 | fzf --tmux)

  if [[ -d "$1/$selection" ]]; then
    # Selection is a directory
    getProject "$1/$selection"
    return $?
  elif [[ -f "$1/$selection" ]]; then
    # Selection is a file
    tmux has-session -t "$selection" 2>/dev/null
    session_not_found=$?

    if [[ $session_not_found == 0 ]]; then
      # Session was found
      if [[ -n $TMUX ]]; then
        # Already inside tmux. Switch client
        tmux switch-client -t $selection
      else
        # Outside tmux. Attach session
        tmux attach -t $selection
      fi
      tmux select-pane -t $selection:1.1

      return 0
    elif [[ $session_not_found == 1 ]]; then
      # Session was not found
      exec $1/$selection
      tmux select-pane -t $selection:1.1
      return 0
    else
      echo "Session was neither found attached nor found not-attached."
      echo "Something weird happened."
      return 1
    fi
  else
    echo "Selection was neither a directory nor a file."
    echo "Something weird happened."
    return 2
  fi
}

getProjects $project_dir
