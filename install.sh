#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ---- Detect platform ----
case "$(uname -s)" in
  Darwin) PLATFORM="mac" ;;
  Linux)  PLATFORM="linux" ;;
  *) echo "Unsupported OS: $(uname -s)" >&2; exit 1 ;;
esac

# ---- macOS: Xcode Command Line Tools ----
if [ "$PLATFORM" = "mac" ] && ! xcode-select -p >/dev/null 2>&1; then
  echo "Installing Xcode Command Line Tools..."
  xcode-select --install
  echo "Re-run this script once Command Line Tools finish installing."
  exit 0
fi

# ---- Homebrew ----
if ! command -v brew >/dev/null 2>&1; then
  echo "Installing Homebrew..."
  NONINTERACTIVE=1 /bin/bash -c \
    "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

for candidate in /opt/homebrew/bin/brew /usr/local/bin/brew /home/linuxbrew/.linuxbrew/bin/brew; do
  if [ -x "$candidate" ]; then
    eval "$("$candidate" shellenv)"
    break
  fi
done

# ---- Dependencies ----
echo "Running brew bundle..."
brew bundle --file="$SCRIPT_DIR/Brewfile"

# ---- Stow dotfiles ----
"$SCRIPT_DIR/stow.sh"

# ---- Fish plugins (fisher is vendored, just sync plugins) ----
if command -v fish >/dev/null 2>&1; then
  echo "Syncing fish plugins..."
  fish -c 'fisher update' || echo "fisher update failed (non-fatal)"
fi

# ---- SDKMAN (optional Java SDK manager) ----
if [ ! -d "$HOME/.sdkman" ]; then
  echo "Installing SDKMAN..."
  curl -s "https://get.sdkman.io" | bash || echo "SDKMAN install failed (non-fatal)"
fi

echo
echo "Done."
echo "To switch your login shell to zsh:"
echo "  sudo chsh -s \"\$(command -v zsh)\" \"\$USER\""
