#history
HISTSIZE=3000

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra,fzf.bash}; do
# for file in ~/.{bash_prompt,aliases,functions,fzf.bash}; do
for file in ~/.{aliases,functions,fzf.bash}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;

eval "$(starship init bash)"

#vim
export EDITOR=/usr/local/bin/vim

#path
export PATH="$HOME/bin:$PATH";

# export PS1="\W \! \$ "
export GREP_OPTIONS='--color=auto'

#nvm path

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

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
# avoid vim error - bash
export LANG='en_US.UTF-8';
export LC_ALL='en_US.UTF-8';
