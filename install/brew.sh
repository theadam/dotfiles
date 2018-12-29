#! /bin/bash
echo 'Installing homebrew repos'
brew tap caskroom/cask
brew tap caskroom/versions

echo 'Installing necessary applications'
brew install rbenv nvm bash-completion boost tmux tmuxinator-completion reattach-to-user-namespace ag fzf pyenv pipenv pyenv-virtualenv neovim stow

brew cask install flux bettertouchtool docker slack licecap google-chrome dropbox alacritty karabiner-elements
