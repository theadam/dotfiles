#! /bin/bash
echo 'Installing homebrew repos'
brew tap caskroom/cask
brew tap caskroom/versions

echo 'Installing necessary applications'
brew install coreutils rbenv nvm bash-completion boost tmux tmuxinator-completion reattach-to-user-namespace ag fzf pyenv pipenv pyenv-virtualenv neovim stow zsh

brew cask install flux bettertouchtool docker slack licecap google-chrome dropbox alacritty karabiner-elements

echo 'Starting docker'
open /Applications/Docker.app

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# Remove zshrc installed by oh-my-zsh
rm ~/.zshrc
