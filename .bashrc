export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
alias pwdls='pwd && ls'

export HISTCONTROL=ignoreboth:erasedups  # no duplicate entries
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
shopt -s histappend                      # append to history, don't overwrite it

export GREP_OPTIONS='--color=auto'
ls --color=always

PS1="\n$PS1"

stty -ixon # cycle through command search both ways

# Directory navigation aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

extract () {
     if [ -f $1 ] ; then
         case $1 in
             *.tar.bz2)   tar xjf $1        ;;
             *.tar.gz)    tar xzf $1     ;;
             *.bz2)       bunzip2 $1       ;;
             *.rar)       rar x $1     ;;
             *.gz)        gunzip $1     ;;
             *.tar)       tar xf $1        ;;
             *.tbz2)      tar xjf $1      ;;
             *.tgz)       tar xzf $1       ;;
             *.zip)       unzip $1     ;;
             *.Z)         uncompress $1  ;;
             *.7z)        7z x $1    ;;
             *)           echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

alias clean='rm -f *.pyc *.class *.o *~ *.bak *.dvi *.aux *.log'

alias mkdir='mkdir -pv' # Create parent directories

# do not delete / or prompt if deleting more than 3 files at a time
alias rm='rm -I --preserve-root'

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
export FIGNORE=DS_Store
