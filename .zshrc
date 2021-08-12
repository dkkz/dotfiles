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
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi


# goss
export GOSS_PATH=$HOME/goss-linux-amd64

# golang
if [ -x "`which go`" ]; then
  export GOPATH=$HOME/.go
  export PATH=$PATH:$GOPATH/bin
fi

source $HOME/.aliases

# nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm


# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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
bindkey "^g" ghq-fzf

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
bindkey "^v" git-branch-fzf

# fzf-tree
function tree-fzf() {
  local SELECTED_FILE=$(tree --charset=o -f | fzf --query "$LBUFFER" | tr -d '\||`|-' | xargs echo)

  if [ "$SELECTED_FILE" != "" ]; then
    BUFFER="$EDITOR $SELECTED_FILE"
    zle accept-line
  fi

  zle reset-prompt
}
zle -N tree-fzf
bindkey "^]" tree-fzf

export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

# for tmux vim error
export TERM="xterm-256color"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ITERM 
export ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX=YES

# github gh
eval "$(gh completion -s zsh)"

# fasd
eval "$(fasd --init auto)"

# docker buildx
export COMPOSE_DOCKER_CLI_BUILD=1


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
bindkey "^q" tmuxpopup

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
  zinit-zsh/z-a-rust \
  zinit-zsh/z-a-as-monitor \
  zinit-zsh/z-a-patch-dl \
  zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk

zinit light reegnz/jq-zsh-plugin

zinit wait lucid is-snippet as"completion" for \
  OMZ::plugins/docker/_docker \
  OMZ::plugins/docker-compose/_docker-compose \

zinit snippet OMZ::plugins/kubectl/kubectl.plugin.zsh

zinit cdclear -q

# autoload for plugins completion
#autoload -U dompinit && compinit -i
# Enable autocompletions
autoload -Uz compinit
typeset -i updated_at=$(date +'%j' -r ~/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
if [ $(date +'%j') != $updated_at ]; then
  compinit -i
else
  compinit -C -i
fi
