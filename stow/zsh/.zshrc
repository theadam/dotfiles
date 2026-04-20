# ---- locale (must be UTF-8 or prompt width-counting breaks with unicode glyphs) ----
export LANG=C.utf8
export LC_CTYPE=C.utf8

# ---- PATH / env bootstrap ----
for brew_bin in /opt/homebrew/bin/brew /usr/local/bin/brew /home/linuxbrew/.linuxbrew/bin/brew; do
  if [ -x "$brew_bin" ]; then
    eval "$("$brew_bin" shellenv)"
    break
  fi
done

path=("$HOME/.local/bin" $path)
[ -d /Applications/WezTerm.app/Contents/MacOS ] && \
  path=(/Applications/WezTerm.app/Contents/MacOS $path)
typeset -U path PATH

export EDITOR=nvim
export WORKON_HOME="$HOME/.virtualenvs"

# ---- grml-zsh-config: sensible defaults (keys, history, completion, options) ----
[ -f "$HOME/.config/zsh/grml-zshrc" ] && source "$HOME/.config/zsh/grml-zshrc"

# ---- tool integrations ----
if command -v fnm >/dev/null 2>&1; then
  eval "$(fnm env --use-on-cd --shell zsh)"
fi

if command -v fzf >/dev/null 2>&1; then
  source <(fzf --zsh)
fi

export SDKMAN_DIR="$HOME/.sdkman"
[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ] && source "$SDKMAN_DIR/bin/sdkman-init.sh"
[ -f "$HOME/.orbstack/shell/init.zsh" ] && source "$HOME/.orbstack/shell/init.zsh" 2>/dev/null

# ---- aliases ----
alias vim="nvim"
alias ls="eza"

# ---- plugins (sourced after grml so its keybindings are already in place) ----
[ -f "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ] && \
  source "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

# ---- highlight styles (must be set before zsh-syntax-highlighting loads) ----
[ -f "$HOME/.config/zsh/highlight.zsh" ] && source "$HOME/.config/zsh/highlight.zsh"

[ -f "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] && \
  source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# ---- prompt (port of fish_prompt.fish) ----
[ -f "$HOME/.config/zsh/prompt.zsh" ] && source "$HOME/.config/zsh/prompt.zsh"

# ---- user functions ----
[ -f "$HOME/.config/zsh/functions.zsh" ] && source "$HOME/.config/zsh/functions.zsh"
