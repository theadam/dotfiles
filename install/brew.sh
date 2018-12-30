#! /bin/bash
echo 'Installing homebrew repos'
brew tap caskroom/cask
brew tap caskroom/versions

echo 'Installing necessary applications'
FORMULAS=(
    'coreutils'
    'rbenv'
    'nvm'
    'bash-completion'
    'boost'
    'tmux'
    'tmuxinator-completion'
    'reattach-to-user-namespace'
    'ag'
    'fzf'
    'pyenv'
    'pyenv-virtualenv'
    'neovim'
    'stow'
    'zsh'
)

for f in "${FORMULAS[@]}"; do
    if ! brew ls --versions $f > /dev/null; then
        brew install $f
    else
        # When outdated `brew outdated` returns an error code
        if ! brew outdated $f > /dev/null; then
            brew upgrade $f
        else
            echo "$f already latest version"
        fi
    fi
done

CASKS=(
    'flux'
    'bettertouchtool'
    'docker'
    'slack'
    'licecap'
    'google-chrome'
    'dropbox'
    'alacritty'
    'karabiner-elements'
    'kitty'
    '1password',
    'insomnia'
)

for f in "${CASKS[@]}"; do
    if ! brew cask ls --versions $f > /dev/null; then
        brew cask install $f
    else
        # When outdated `brew outdated` returns an error code
        if ! brew cask outdated $f > /dev/null; then
            brew cask upgrade $f
        else
            echo "$f already latest version"
        fi
    fi
done

echo 'Starting docker'
open /Applications/Docker.app

if [ ! -d ~/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    # Remove zshrc installed by oh-my-zsh
    rm ~/.zshrc
else
    echo "Skipping installation of oh-my-zsh (directorty exists)"
fi
