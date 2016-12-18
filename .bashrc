export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
alias pwdls='pwd && ls'

export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
shopt -s histappend                      # append to history, don't overwrite it

export GREP_OPTIONS='--color=auto'
ls --color=always

PS1="\n$PS1"

stty -ixon # cycle through command search both ways
