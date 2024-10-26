#! /bin/bash
echo 'Installing homebrew repos'
brew tap Homebrew/cask-versions

echo 'Installing necessary applications'
FORMULAS=(
  'coreutils'
  'rbenv'
  'fish'
  'nvm'
  'boost'
  'ag'
  'fzf'
  'pyenv'
  'pyenv-virtualenv'
  'neovim'
  'stow'
  'eza'
)

for f in "${FORMULAS[@]}"; do
  if ! brew ls --versions $f >/dev/null; then
    brew install $f
  else
    # When outdated `brew outdated` returns an error code
    if ! brew outdated $f >/dev/null; then
      brew upgrade $f
    else
      echo "$f already latest version"
    fi
  fi
done

CASKS=(
  'dbeaver-community'
  'bettertouchtool'
  'docker'
  'slack'
  'google-chrome'
  'karabiner-elements'
  '1password'
  'wezterm'
)

for f in "${CASKS[@]}"; do
  if ! brew ls --cask --versions $f >/dev/null; then
    brew install --cask $f
  else
    # When outdated `brew outdated` returns an error code
    if ! brew outdated --cask $f >/dev/null; then
      brew upgrade --cask $f
    else
      echo "$f already latest version"
    fi
  fi
done

# echo 'Starting docker'
# open /Applications/Docker.app
