#! /bin/bash
echo 'Installing homebrew'
brew tap caskroom/cask
brew tap caskroom/versions

echo 'Installing necessary applications'
brew install rbenv nvm bash-completion python3 boost tmux homebrew/completions/tmuxinator-completion reattach-to-user-namespace ag fzf
brew cask install flux bettertouchtool docker slack licecap iterm2 google-chrome dropbox

brew install neovim/neovim/neovim
pip3 install neovim

brew install python
pip install pip-tools virtualenv virtualenvwrapper

mkdir -p ~/.nvm
export NVM_DIR="$HOME/.nvm"
ln -sf /usr/local/opt/nvm/nvm.sh $NVM_DIR/nvm.sh
source $NVM_DIR/nvm.sh

eval "$(rbenv init -)"

open /Applications/Docker.app

/usr/local/opt/fzf/install --all

