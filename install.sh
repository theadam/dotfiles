#! /bin/bash

set -e

source install/install.sh

stow home -t $HOME
nvim +PlugInstall +qall
