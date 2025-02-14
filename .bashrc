# brew install --cask docker iterm2 google-chrome visual-studio-code firefox sublime-text spotify github flux jetbrains-toolbox
# source <(curl -s https://raw.githubusercontent.com/PatMyron/dotfiles/master/.bashrc)
#
# https://www.gnu.org/software/bash/manual/html_node/Indexes.html
# https://www.gnu.org/software/bash/manual/html_node/Modifying-Shell-Behavior.html
# https://www.gnu.org/software/bash/manual/html_node/Readline-Init-File-Syntax.html
# https://fishshell.com/docs/current/language.html#special-variables
# https://zsh.sourceforge.io/Doc/Release/Options.html
# explainshell.com
#
# Control + command + space: emoji search
# Command + shift + a: select output of last command
# Option + arrow keys: moves cursor word-by-word
# Command + double click: opens links
# Option + click: moves cursor
# Control + r: search command history
# Control + s: search command history the other direction

alias diff='colordiff'
export CLICOLOR=1
alias grep='grep --color=auto -d skip'
if [[ $(uname -s) == Linux ]]
then
    alias ls='ls -hF --color=auto --group-directories-first'
    alias df='df -h -T'
    alias chcon='chcon --preserve-root'
    alias chmod='chmod --preserve-root'
    alias chgrp='chgrp --preserve-root'
    alias chown='chown --preserve-root'
    alias rm='rm -I --preserve-root'
else
    alias ls='ls -hFG'
    alias df='df -h'
fi
git config --global color.diff always
git config --global color.ui auto
git config --global core.excludesfile ~/.gitignore
git config --global core.attributesfile ~/.gitattributes
git config --global core.pager cat
git config --global pull.rebase true
git config --global push.default current

alias pwdls='pwd && ls'
alias gs='git status'
alias gd='git diff'
alias gdo='git diff origin'
alias gdono='git diff origin --name-only'
alias gb='git branch'
alias gf='git fetch'
alias gc='git checkout'
alias gp='git push'
alias gpr='git pull --rebase'
alias ga='git commit -a --amend --reuse-message=HEAD'
alias gr='git reset --hard origin'
alias gl='git log --all --decorate --pretty=oneline --graph --color --abbrev-commit --date=relative'
# git log --graph --format='format:%C(yellow)%h%C(reset) %C(blue)"%an" <%ae>%C(reset) %C(magenta)%ar%C(reset)%C(auto)%d%C(reset)%n%s' --date-order
alias gup='git fetch upstream && git reset --hard upstream/master && git push origin master --force'
alias g='git'
alias q='exit'
alias pyserver='python -m SimpleHTTPServer'
alias rbserver='ruby -run -ehttpd . -p8000'
alias clean='rm -f *.pyc *.class *.o *~ *.bak *.dvi *.aux *.log'
alias du='du -h'
alias free='free -h'
alias sudo='sudo '
alias cp='cp -i -r'
alias mv='mv -i'
alias mkdir='mkdir -pv'
alias ln='ln -i'
alias screen='screen -U'
alias tmux='tmux -2'
alias tree='tree -Csuh'
alias pipreqs='pipreqs --force'
alias priority='ionice -c 2 -n 0 nice -n 20'
alias rsync='rsync -a -z'

export HISTCONTROL=ignoreboth:erasedups
export HISTSIZE=100000
export HISTFILESIZE=100000
export HISTTIMEFORMAT="%F %T "
shopt -s histappend
shopt -s cdspell
shopt -s dirspell
shopt -s nocaseglob
shopt -s checkwinsize
shopt -s cmdhist
shopt -s autocd
shopt -s checkhash
shopt -s lithist
shopt -s extglob
shopt -s globstar
shopt -s nullglob

bind "set completion-ignore-case on"

export PS1="\n\n\n\n\h  \w $ "
export EDITOR=nano
export FIGNORE=DS_Store

[[ $- == *i* ]] && stty -ixon # cycle through command search both ways https://stackoverflow.com/questions/24623021

alias .1='cd ..'
alias .2='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'
alias .6='cd ../../../../../..'

subdir() { for d in */ ; do (cd "$d" && "$@"); done }
subdirpwd() { for d in */ ; do (cd "$d" && pwd && "$@"); done }

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

# do ". acd_func.sh"
# acd_func 1.0.5, 10-nov-2004
# petar marinov, http:/geocities.com/h2428, this is public domain
cd_func ()
{
  local x2 the_new_dir adir index
  local -i cnt

  if [[ $1 ==  "--" ]]; then
    dirs -v
    return 0
  fi

  the_new_dir=$1
  [[ -z $1 ]] && the_new_dir=$HOME

  if [[ ${the_new_dir:0:1} == '-' ]]; then
    #
    # Extract dir N from dirs
    index=${the_new_dir:1}
    [[ -z $index ]] && index=1
    adir=$(dirs +$index)
    [[ -z $adir ]] && return 1
    the_new_dir=$adir
  fi

  #
  # '~' has to be substituted by ${HOME}
  [[ ${the_new_dir:0:1} == '~' ]] && the_new_dir="${HOME}${the_new_dir:1}"

  #
  # Now change to the new dir and add to the top of the stack
  pushd "${the_new_dir}" > /dev/null
  [[ $? -ne 0 ]] && return 1
  the_new_dir=$(pwd)

  #
  # Trim down everything beyond 11th entry
  popd -n +11 2>/dev/null 1>/dev/null

  #
  # Remove any other occurence of this dir, skipping the top of the stack
  for ((cnt=1; cnt <= 10; cnt++)); do
    x2=$(dirs +${cnt} 2>/dev/null)
    [[ $? -ne 0 ]] && return 0
    [[ ${x2:0:1} == '~' ]] && x2="${HOME}${x2:1}"
    if [[ "${x2}" == "${the_new_dir}" ]]; then
      popd -n +$cnt 2>/dev/null 1>/dev/null
      cnt=cnt-1
    fi
  done

  return 0
}
alias cd=cd_func
if [[ $BASH_VERSION > "2.05a" ]]; then
  # ctrl+w shows the menu
  [[ $- == *i* ]] && bind -x "\"\C-w\":cd_func -- ;"
fi

(plutil -insert Window\ Settings.Basic.useOptionAsMetaKey -bool YES ~/Library/Preferences/com.apple.terminal.plist
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write NSGlobalDomain com.apple.springing.delay -float 0
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
defaults write com.apple.finder QuitMenuItem -bool true
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
defaults write com.apple.menuextra.battery ShowPercent -string "YES"
defaults write com.apple.screencapture location ~/Downloads/screen) &>/dev/null

(curl -sL https://www.gitignore.io/api/c,c++,node,go,java,xcode,macos,linux,swift,gradle,python,jekyll,android,windows,jetbrains,terraform,visualstudio,androidstudio,visualstudiocode > ~/.gitignore) & disown
(curl -sL https://gist.githubusercontent.com/tekin/12500956bd56784728e490d8cef9cb81/raw/73f0a92cd447b2151cdf3c05d1a40e4701894028/.gitattributes > ~/.gitattributes) & disown

export PATH=$PATH:~/Library/Python/*/bin:/opt/homebrew/bin:~/.local/bin:$HOME/go/bin:$HOME/.cargo/bin

# Amazon specific
alias bb=brazil-build
alias bbs='bb server'
alias bbr='brazil-recursive-cmd --allPackages brazil-build'
alias register_with_aaa=/apollo/env/AAAWorkspaceSupport/bin/register_with_aaa.py
alias modelbuild='cd ../*Model && bb && cd -'
alias clockskew='sudo /sbin/service ntpd stop && sudo /usr/sbin/ntpd -gnq && sudo /sbin/service ntpd start'
alias sshtunnel='ssh -fNL 2009:localhost:2009 $USER.aka.corp.amazon.com'
alias sshdd='ssh $USER.aka.corp.amazon.com'
export AWS_DEFAULT_REGION=us-west-2
export LPT_ENABLE_PARTITIONING=true
export PATH=$PATH:/apollo/env/SDETools/bin:/apollo/env/envImprovement/bin:/apollo/env/AmazonAwsCli/bin:$BRAZIL_CLI_BIN:$HOME/.toolbox/bin
inAWSRegions() { for REGION in $(aws ec2 describe-regions --query "Regions[*].RegionName" --output text); do "$@" --region $REGION; done }
inAWSRegionsEcho() { for REGION in $(aws ec2 describe-regions --query "Regions[*].RegionName" --output text); do (echo $REGION; "$@" --region $REGION); done }
odin-add () {
  /apollo/bin/env -e OdinTools odin adminAPI --addmaterialsettohostentity --materialSetName "$1" --hostspec "DEV-DSK-$USER"
}
odin-rm () {
  /apollo/bin/env -e OdinTools odin adminAPI --removeMaterialSetFromHostEntity --materialSetName "$1" --hostspec "DEV-DSK-${USER^^}"
} # requires bash

# Microsoft specific
