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
# Install nvim config
#-----------------------------------------------------
echo -n "[ Neovim config ]"

if [ ! -d ~/.config/nvim ]; then
  echo "    Creating nvim folder!"
  mkdir ~/.config/nvim
  install_nvim_folder
elif $REPLACE_FILES; then
  echo "    Deleting old nvim folder!"
  rm -rf ~/.config/nvim
  install_nvim_folder
else
  echo "    Keeping existing nvim folder!"
fi

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
