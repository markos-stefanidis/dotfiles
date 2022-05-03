#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
export EDITOR=vim

alias v='vim'
alias la='exa -lah --icons --color=auto'
PS1='[\u@\h \W]\$ '
alias rm='rm -i'
alias mv='mv -i'
export LS_COLORS=$LS_COLORS:'ow=1;34:'
exec zsh
