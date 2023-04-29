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
source /home/markos/zshplugins/zsh-autosuggestions.zsh
source ~/.zplug/init.zsh
source ~/.zplug/repos/olivierverdier/zsh-git-prompt/zshrc.sh
zplug "olivierverdier/zsh-git-prompt"

# History
HISTFILE=~/.bash_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# Configuring Prompt
PS1='%F{green}%~ $(git_super_status)'$'\n''%F{blue}﬌ %f '
precmd() { print "" }

# Flex on Ubuntu users
#neofetch

export QSYS_ROOTDIR="/home/markos/.cache/yay/quartus-free/pkg/quartus-free-quartus/opt/intelFPGA/21.1/quartus/sopc_builder/bin"
source /home/markos/zshplugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /home/markos/zshplugins/zsh-syntax-highlighting/colors.zsh

