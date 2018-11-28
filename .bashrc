# curl -s 'https://macapps.link/en/firefox-chrome-github-sublime-androidstudio-docker-vscode-iterm-flux-spotify' | sh
# https://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html
# https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html

alias diff='colordiff'
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias rgrep='rgrep --color=auto'
if ls --help 2>&1 | grep -q -- --color
then
    alias ls='ls -hF --color=auto'
else
    alias ls='ls -hFG'
fi
git config --global color.diff always
git config --global color.ui auto

git config --global pull.rebase true
git config --global core.excludesfile ~/.gitignore

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
alias gr='git reset --hard origin/master'
alias gl='git log --all --decorate --pretty=oneline --graph --color --abbrev-commit --date=relative'
alias g='git'
alias du='du -h'
alias df='df -h'
# alias free='free -h'
alias sudo='sudo '
alias q=exit
alias pyserver='python -m SimpleHTTPServer 8000'
alias clean='rm -f *.pyc *.class *.o *~ *.bak *.dvi *.aux *.log'

# alias chmod='chmod --preserve-root'
# alias chgrp='chgrp --preserve-root'
# alias chown='chown --preserve-root'
# alias mv='mv -i'
# alias cp='cp -i'
alias mkdir='mkdir -pv'
alias ln='ln -i'
alias rm='rm -I --preserve-root'

export HISTCONTROL=ignoreboth:erasedups
export HISTSIZE=100000
export HISTFILESIZE=100000
shopt -s histappend

shopt -s cdspell
shopt -s dirspell
shopt -s nocaseglob
shopt -s checkwinsize
shopt -s cmdhist
shopt -s autocd
shopt -s checkhash
shopt -s lithist

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

plutil -insert Window\ Settings.Basic.useOptionAsMetaKey -bool YES ~/Library/Preferences/com.apple.terminal.plist > /dev/null
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false 2> /dev/null
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false 2> /dev/null
defaults write NSGlobalDomain AppleShowAllExtensions -bool true 2> /dev/null
defaults write NSGlobalDomain com.apple.springing.delay -float 0 2> /dev/null
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false 2> /dev/null
defaults write com.apple.finder QuitMenuItem -bool true 2> /dev/null
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true 2> /dev/null
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf" 2> /dev/null
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false 2> /dev/null
defaults write com.apple.finder FXPreferredViewStyle -string "clmv" 2> /dev/null
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true 2> /dev/null
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true 2> /dev/null
defaults write com.apple.menuextra.battery ShowPercent -string "YES" 2> /dev/null
defaults write com.apple.screencapture location ~/Downloads 2> /dev/null 

(for file in C C++ Python Java Android Gradle Node Terraform Swift VisualStudio; do
  curl https://raw.githubusercontent.com/github/gitignore/master/$file.gitignore >> ~/.gitignore
done
for file in Linux Windows macOS JetBrains Xcode VisualStudioCode; do
  curl https://raw.githubusercontent.com/github/gitignore/master/Global/$file.gitignore >> ~/.gitignore
done) &>/dev/null & disown

(brew update && brew upgrade && brew cleanup && brew doctor && brew prune) &>/dev/null & disown

# Amazon specific
alias bb=brazil-build
alias bbs='bb server'
alias bbr='brazil-recursive-cmd --allPackages brazil-build'
alias register_with_aaa=/apollo/env/AAAWorkspaceSupport/bin/register_with_aaa.py
alias modelbuild='cd ../*Model && bb && cd -'
alias clockskew='sudo /sbin/service ntpd stop && sudo /usr/sbin/ntpd -gnq && sudo /sbin/service ntpd start'
alias sshtunnel='ssh -fNL 2009:localhost:2009 $USER.aka.corp.amazon.com'
alias sshdd='ssh $USER.aka.corp.amazon.com'
export LPT_ENABLE_PARTITIONING=true
export PATH=/apollo/env/SDETools/bin:/apollo/env/envImprovement/bin:/apollo/env/AmazonAwsCli/bin:$BRAZIL_CLI_BIN:$HOME/.toolbox/bin:$PATH
odin-add () {
  /apollo/bin/env -e OdinTools odin adminAPI --addmaterialsettohostentity --materialSetName "$1" --hostspec "DEV-DSK-$USER"
}
odin-rm () {
  /apollo/bin/env -e OdinTools odin adminAPI --removeMaterialSetFromHostEntity --materialSetName "$1" --hostspec "DEV-DSK-${USER^^}"
}
export AWS_DEFAULT_REGION=us-west-2

# Microsoft specific
