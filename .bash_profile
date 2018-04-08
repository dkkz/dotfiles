#Get the aliases and functions
if [ -f ~/.bashrc ]; then
. ~/.bashrc
fi

#history
HISTSIZE=3000

#export PS1='\[\033[32m\]\u@\h\[\033[00m\]:\[\033[34m\]\w\[\033[31m\]$(__git_ps1)\[\033[00m\]\$ '

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;

#vim
export EDITOR=/usr/local/bin/vim

#path
export PATH=$PATH:/usr/local/bin:/usr/bin
export PATH="/usr/local/sbin:$PATH"

# export PS1="\W \! \$ "
export GREP_OPTIONS='--color=auto'

#nvm path
export NVM_DIR="$HOME/.nvm"
  . "/usr/local/opt/nvm/nvm.sh"

# brew cask applications location
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

#phpbrew
[[ -e ~/.phpbrew/bashrc ]] && source ~/.phpbrew/bashrc

#go lang
if [ -x "`which go`" ]; then
  export GOPATH=$HOME/.go
  export PATH=$PATH:$GOPATH/bin
fi

#git complete
source /usr/local/etc/bash_completion.d/git-prompt.sh
source /usr/local/etc/bash_completion.d/git-completion.bash

GIT_PS1_SHOWDIRTYSTATE=true

#for change ruby version
#for call rbenv init
eval "$(rbenv init -)"

#fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

bind "$(bind -s | grep fzf_history | sed 's/r/f/')"
bind '"\C-r": reverse-search-history'
