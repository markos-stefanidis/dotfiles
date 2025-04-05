#! /bin/bash

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
alias eww-x11="/home/markos/eww-x11/eww/target/release/eww"

function zvm_config() {
  ZVM_LINE_INIT_MODE=$ZVM_MODE_LAST
  ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
}
# Plugins
source ~/.zplug/init.zsh
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "jeffreytse/zsh-vi-mode"
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
export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:/tools/Xilinx/Vivado/2022.1/bin/
export PATH=$PATH:$HOME/.config/emacs/bin
export PATH=$PATH:$HOME/.local/bin
export QT_QPA_PLATFORMTHEME=qt5ct
export MARKOS_ROOT=/home/markos/repos/6502.bak

#---- FZF ---
eval "$(fzf --zsh)"

alias svn='python3 ~/repos/svn-wrapper/python/svn_wrapper.py'
