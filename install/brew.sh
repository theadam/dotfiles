#! /bin/bash
echo 'Installing homebrew'
brew tap caskroom/cask
brew tap caskroom/versions

echo 'Installing necessary applications'
brew install rbenv nvm bash-completion python3 boost homebrew/completions/tmuxinator-completion
brew cask install flux bettertouchtool docker slack licecap iterm2 google-chrome

brew install neovim/neovim/neovim
pip3 install neovim

mkdir -p ~/.nvm
export NVM_DIR="$HOME/.nvm"
source /usr/local/opt/nvm/nvm.sh

eval "$(rbenv init -)"

open /Applications/Docker.app
