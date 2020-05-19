#! /bin/bash
echo 'Setting up rbenv'
eval "$(rbenv init -)"

echo 'Installing ruby'
rbenv install -s 2.7.1
rbenv global 2.7.1

echo 'Installing global gems'
gem install bundler tmuxinator
