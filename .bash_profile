#history
HISTSIZE=3000

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra,fzf.bash}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;

#vim
export EDITOR=/usr/local/bin/vim

#path
export PATH="$HOME/bin:$PATH";

# export PS1="\W \! \$ "
export GREP_OPTIONS='--color=auto'

#for change ruby version
#for call rbenv init
# eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/bin:$PATH"
if which rbenv > /dev/null; then 
    eval "$(rbenv init -)";
fi

#nvm path
export NVM_DIR="$HOME/.nvm"
  . "/usr/local/opt/nvm/nvm.sh"

# brew cask applications location
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export PATH="/usr/local/bin:$PATH"

#go lang
if [ -x "`which go`" ]; then
  export GOPATH=$HOME/.go
  export PATH=$PATH:$GOPATH/bin
fi

GIT_PS1_SHOWDIRTYSTATE=true

#z
. /usr/local/etc/profile.d/z.sh

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
  shopt -s "$option" 2> /dev/null;
done;

#git complete
source /usr/local/etc/bash_completion.d/git-prompt.sh
source /usr/local/etc/bash_completion.d/git-completion.bash
#fzf
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
