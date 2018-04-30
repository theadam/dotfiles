#! /bin/bash

set -e

# Existing files won't be replaced
REPLACE_FILES=false

#-----------------------------------------------------
# Functions and variables
#-----------------------------------------------------
current_path=$(pwd)

command_exists() {
  type "$1" &>/dev/null
}
install_plug_nvim() {
  curl -fLo ~/.config/nvim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

install_nvim_folder() {
  mkdir -p ~/.config/nvim/autoload
  install_plug_nvim
  ln -sf $current_path/neovim/custom-snippets ~/.config/nvim/custom-snippets
  ln -sf $current_path/neovim/plugin ~/.config/nvim/plugin
  ln -sf $current_path/neovim/init.vim ~/.config/nvim/init.vim
}

#-----------------------------------------------------
# Install programs
#-----------------------------------------------------
# source install/install.sh

#-----------------------------------------------------
# Install git config
#-----------------------------------------------------
echo -n "[ .gitconfig ]"

if [ ! -f ~/.gitconfig ]; then
  echo "    Creating .gitconfig!"
  ln -sf $current_path/.gitconfig ~/.gitconfig
elif $REPLACE_FILES; then
  echo "    Deleting old .gitconfig!"
  rm ~/.gitconfig
  ln -sf $current_path/.gitconfig ~/.gitconfig
else
  echo "    Keeping existing .gitconfig!"
fi

#-----------------------------------------------------
# Install bash_profile
#-----------------------------------------------------
echo -n "[ .bash_profile ]"

if [ ! -f ~/.bash_profile ]; then
  echo "    Creating .bash_profile!"
  ln -sf $current_path/.bash_profile ~/.bash_profile
elif $REPLACE_FILES; then
  echo "    Deleting old .bash_profile!"
  rm ~/.bash_profile
  ln -sf $current_path/.bash_profile ~/.bash_profile
else
  echo "    Keeping existing .bash_profile!"
fi

#-----------------------------------------------------
# Install nvim config
#-----------------------------------------------------
echo -n "[ Neovim config ]"

if [ ! -d ~/.config/nvim ]; then
  echo "    Creating nvim folder!"
  mkdir -p ~/.config/nvim
  install_nvim_folder
elif $REPLACE_FILES; then
  echo "    Deleting old nvim folder!"
  rm -rf ~/.config/nvim
  install_nvim_folder
else
  echo "    Keeping existing nvim folder!"
fi
nvim +PlugInstall +qall

#-----------------------------------------------------
# Install tmux config
#-----------------------------------------------------
echo -n "[ tmux.conf ]"

if [ ! -f ~/.tmux.conf ]; then
  echo "    Creating tmux.conf!"
  ln -sf $current_path/tmux/tmux.conf ~/.tmux.conf
elif $REPLACE_FILES; then
  echo "    Deleting old tmux.conf!"
  rm ~/.tmux.conf
  ln -sf $current_path/tmux/tmux.conf ~/.tmux.conf
else
  echo "    Keeping existing tmux.conf!"
fi

#-----------------------------------------------------
# Install karabiner-elements config
#-----------------------------------------------------
echo -n "[ karabiner.json ]"

mkdir -p ~/.karabiner.d/configuration/

if [ ! -f ~/.karabiner.d/configuration/karabiner.json ]; then
  echo "    Creating karabiner.conf!"
  ln -sf $current_path/karabiner-elements/karabiner.json ~/.karabiner.d/configuration/karabiner.json
elif $REPLACE_FILES; then
  echo "    Deleting old karabiner.conf!"
  rm ~/.karabiner.d/configuration/karabiner.json
  ln -sf $current_path/karabiner-elements/karabiner.json ~/.karabiner.d/configuration/karabiner.json
else
  echo "    Keeping existing karabiner.conf!"
fi

#-----------------------------------------------------
# Install kitty config
#-----------------------------------------------------
echo -n "[ Kitty Config ]"

if [ ! -f ~/Library/Preferences/kitty/kitty.conf ]; then
  echo "    Creating kitty config!"
  ln -sf $current_path/kitty.conf ~/Library/Preferences/kitty/kitty.conf
elif $REPLACE_FILES; then
  echo "    Deleting old kitty config!"
  rm ~/Library/Preferences/kitty/kitty.conf
  ln -sf $current_path/kitty.conf ~/Library/Preferences/kitty/kitty.conf
else
  echo "    Keeping existing kitty config!"
fi
