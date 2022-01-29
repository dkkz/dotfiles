# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
# if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
#   source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
# fi

typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

#export LANG=en_US.UTF-8

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
#HISTFILE=~/.cache/zsh/history

source $HOME/.aliases

# goss
#export GOSS_PATH=$HOME/goss-linux-amd64
export PATH=/usr/local/bin:$PATH
export PATH=$PATH:"/opt/local/bin:/opt/local/sbin"

if [ -d "/usr/local/opt/ruby/bin" ]; then
  export PATH=/usr/local/opt/ruby/bin:$PATH
  export PATH=`gem environment gemdir`/bin:$PATH
fi

# mysql-client
export PATH="/usr/local/opt/mysql-client@5.7/bin:$PATH"

# golang
if [ -x "`which go`" ]; then
  export GOPATH=$HOME/.go
  export PATH=$PATH:$GOPATH/bin
fi

# nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
# for tmux vim error
export TERM="xterm-256color"
#export TERM="screen-256color"

# ITERM 
export ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX=YES

# docker buildx
export COMPOSE_DOCKER_CLI_BUILD=1

# rust
export PATH="$HOME/.cargo/bin:$PATH"
[ -f ~/.cargo/env ] && source ~/.cargo/env

export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

# fzf-ghq
function ghq-fzf() {
  local selected_dir=$(ghq list | fzf --query="$LBUFFER")

  if [ -n "$selected_dir" ]; then
    BUFFER="cd $(ghq root)/${selected_dir}"
    zle accept-line
  fi

  zle reset-prompt
}

zle -N ghq-fzf

# fzf-branch
function git-branch-fzf() {
  local selected_branch=$(git for-each-ref --format='%(refname)' --sort=-committerdate refs/heads | perl -pne 's{^refs/heads/}{}' | fzf --query "$LBUFFER")

  if [ -n "$selected_branch" ]; then
    BUFFER="git checkout '${selected_branch}'"
    zle accept-line
  fi

  zle reset-prompt
}

zle -N git-branch-fzf

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# github gh
eval "$(gh completion -s zsh)"

# fzf-tree
function tmuxpopup() {
  local width='80%'
  local height='80%'
  local session=$(tmux display-message -p -F "#{session_name}")

  if [[ $session = *"popup"* ]]; then
    tmux detach-client
  else
    # tmux popup -d '#{pane_current_path}' -xC -yC -w$width -h$height -K -E -R "tmux attach -t popup || tmux new -s popup"
    tmux popup -d '#{pane_current_path}' -xC -yC -w$width -h$height -E "tmux attach -t popup || tmux new -s popup"
  fi
}
zle -N tmuxpopup

# fzf-snippet
function fzf-select-snippet() {
  emulate -L zsh
  BUFFER=$(cat ~/.snippet | fzf)
  CURSOR=$#BUFFER
  zle -Rc
  zle reset-prompt
}
zle -N fzf-select-snippet

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})‚Ä¶%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
 blockf \
    zsh-users/zsh-completions \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \

zinit wait lucid is-snippet as"completion" for \
  OMZP::docker/_docker \
  OMZP::docker-compose/_docker-compose \
  OMZP::rust/_rust \
  OMZP::cargo \
  OMZP::rustup

zinit is-snippet for \
  OMZL::completion.zsh \
  OMZL::key-bindings.zsh \
  OMZL::directories.zsh \
  https://github.com/aws/aws-cli/blob/v2/bin/aws_zsh_completer.sh

zinit cdclear -q

zinit light agkozak/zsh-z
zinit light reegnz/jq-zsh-plugin
zinit ice depth=1; zinit light romkatv/powerlevel10k

zinit ice depth=1; zinit light jeffreytse/zsh-vi-mode

autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:default' menu select=1 
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=244"

setopt interactivecomments
setopt AUTO_MENU
setopt AUTO_CD
setopt AUTO_NAME_DIRS
setopt share_history
setopt extended_history
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_verify
setopt hist_reduce_blanks

# bindkey -v
# bindkey '^a' beginning-of-line
# bindkey '^e' end-of-line
# bindkey '^p' up-history
# bindkey '^n' down-history

# fzf
#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

function zvm_after_init() {
  bindkey "^g" ghq-fzf
  bindkey "^v" git-branch-fzf
  bindkey "^q" tmuxpopup
  bindkey '^X^M' fzf-select-snippet
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
}
