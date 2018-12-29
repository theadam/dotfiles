#! /bin/bash
echo 'Installing homebrew'
brew tap caskroom/cask
brew tap caskroom/versions

echo 'Installing necessary applications'
brew install rbenv nvm bash-completion boost tmux tmuxinator-completion reattach-to-user-namespace ag fzf pyenv pipenv pyenv-virtualenv neovim stow
brew cask install flux bettertouchtool docker slack licecap google-chrome dropbox alacritty

pyenv install-latest 2.7
pyenv install-latest

pip install pip-tools virtualenv virtualenvwrapper python-language-server

PY2_V=`pyenv version | grep ^2.7 | awk '{print $1}' | tr -d '\n\r'`
PY3_V=`pyenv version | grep ^3 | awk '{print $1}' | tr -d '\n\r'`

pyenv virtualenv $PY2_V neovim2
pyenv activate neovim2
pip install neovim

pyenv virtualenv $PY3_V neovim3
pyenv activate neovim3
pip install neovim

pyenv deactivate neovim3

mkdir -p ~/.nvm
export NVM_DIR="$HOME/.nvm"
ln -sf /usr/local/opt/nvm/nvm.sh $NVM_DIR/nvm.sh
source $NVM_DIR/nvm.sh

eval "$(rbenv init -)"

open /Applications/Docker.app

/usr/local/opt/fzf/install --all

