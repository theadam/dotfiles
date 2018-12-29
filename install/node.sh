#! /bin/bash
echo 'Installing Node'
nvm install stable
nvm alias default stable

echo 'Installing global node modules'
npm install -g yarn
