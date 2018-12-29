#! /bin/bash
echo 'Setting up pyenv'
eval "$(pyenv init -)"
git clone https://github.com/momo-lab/pyenv-install-latest.git "$(pyenv root)"/plugins/pyenv-install-latest


echo 'Installing python'
pyenv install-latest 2.7
pyenv install-latest

pip install pip-tools virtualenv virtualenvwrapper python-language-server

PY2_V=`pyenv version | grep ^2.7 | awk '{print $1}' | tr -d '\n\r'`
PY3_V=`pyenv version | grep ^3 | awk '{print $1}' | tr -d '\n\r'`

echo 'Setting up neovim python environments'
pyenv virtualenv $PY2_V neovim2
pyenv activate neovim2
pip install neovim

pyenv virtualenv $PY3_V neovim3
pyenv activate neovim3
pip install neovim

pyenv deactivate neovim3

