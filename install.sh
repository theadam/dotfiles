#! /bin/bash

set -e

source install/install.sh
source stow.sh

nvim +PlugInstall +qall
