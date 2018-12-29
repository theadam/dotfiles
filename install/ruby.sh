echo 'Installing ruby'
rbenv install 2.3.3
rbenv global 2.3.3

echo 'Installing global gems'
gem install bundler tmuxinator solargraph
