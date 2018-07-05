#!/bin/bash

# target path
export NVM_DIR="$HOME/.nvm"

# nvm & node.js stable version
if test ! -d ~/.nvm; then
  (
    git clone https://github.com/creationix/nvm.git "$NVM_DIR"
    cd "$NVM_DIR"
    git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" origin`
  ) && \. "$NVM_DIR/nvm.sh"

  # install node lts version as default
  nvm install stable
  nvm alias default stable

fi

# brew for macOS
if [ "$(uname -s)" == "Darwin" ]; then
  if test ! $(which brew); then
    xcode-select --install
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  brew tap homebrew/bundle
  brew bundle
fi

source $HOME/.bash_profile
