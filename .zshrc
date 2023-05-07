#! /bin/bash
# Created by newuser for 5.8.1

# Define variables
export EDITOR=nvim

# Define LANG
export LANG='en_US.UTF-8'

# Define aliases
alias la="exa -lah --icons"
alias ls="exa -ah --icons"
alias v="vim"
alias rm="rm -i"
alias mv="mv -i"
alias vim="nvim"
alias config="/usr/bin/git --git-dir=$HOME/repos/dotfiles/ --work-tree=$HOME"

# Plugins
source ~/.zplug/init.zsh
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug load 

# History
HISTFILE=~/.bash_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# Configuring Prompt
PS1='%F{green}%~'$'\n''%F{blue}󰘍 %f '
precmd() { print "" }

# Flex on Ubuntu users
#neofetch

export QSYS_ROOTDIR="/home/markos/.cache/yay/quartus-free/pkg/quartus-free-quartus/opt/intelFPGA/21.1/quartus/sopc_builder/bin"


