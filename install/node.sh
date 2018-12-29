#! /bin/bash
echo 'Setting up nvm'
mkdir -p ~/.nvm
export NVM_DIR="$HOME/.nvm"
ln -sf /usr/local/opt/nvm/nvm.sh $NVM_DIR/nvm.sh
source $NVM_DIR/nvm.sh

echo 'Installing Node'
nvm install stable
nvm alias default stable

echo 'Installing global node modules'
npm install -g yarn
