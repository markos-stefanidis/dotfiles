#! /bin/bash
# Created by newuser for 5.8.1

# Define variables
export EDITOR=vim

# Define aliases
alias la="exa -lah --icons"
alias v="vim"
alias rm="rm -i"
alias mv="mv -i"

# Plugins
source /home/markos/zshplugins/zsh-autosuggestions.zsh
source ~/.zplug/init.zsh
zplug "olivierverdier/zsh-git-prompt"

# History
HISTFILE=~/.bash_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# Configuring Prompt
PS1='%F{green}%~ $(git_super_status)'$'\n''%F{blue}$ %f '

# Flex on Ubuntu users
neofetch
