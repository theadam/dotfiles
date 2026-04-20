# dotfiles

Cross-platform dotfiles for macOS and Linux. Bootstraps Homebrew, installs
declared dependencies from `Brewfile`, then symlinks everything with `stow`.

## Installation

```
git clone https://github.com/theadam/dotfiles.git
cd dotfiles
./install.sh
```

The script will:
1. On macOS, prompt for Xcode Command Line Tools if missing.
2. Install Homebrew if not already present.
3. Install everything in `Brewfile` (casks are macOS-only and auto-skipped on Linux).
4. Stow every package under `stow/` into `$HOME`.
5. Sync fish plugins via `fisher update`.
6. Install SDKMAN (optional, best-effort).

Before re-running on a machine that already has `~/.zshrc`, `~/.config/fish`,
`~/.gitconfig`, etc., move or delete those so `stow` can symlink without conflict.

## Changing the login shell to zsh

```
sudo chsh -s "$(command -v zsh)" "$USER"
```
