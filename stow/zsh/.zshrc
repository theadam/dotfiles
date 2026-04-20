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

# Syntax highlighting colors mirrored from fish (Ayu Dark palette).
# Requires a true-color terminal.
typeset -gA ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[default]='fg=#CBCCC6'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#FF3333,bold'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=#5CCFE6'
ZSH_HIGHLIGHT_STYLES[alias]='fg=#5CCFE6'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#5CCFE6'
ZSH_HIGHLIGHT_STYLES[function]='fg=#5CCFE6'
ZSH_HIGHLIGHT_STYLES[command]='fg=#5CCFE6'
ZSH_HIGHLIGHT_STYLES[arg0]='fg=#5CCFE6'
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=#5CCFE6'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=#5CCFE6,underline'
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=#F29E74'
ZSH_HIGHLIGHT_STYLES[path]='fg=#73D0FF,underline'
ZSH_HIGHLIGHT_STYLES[path_pathseparator]='fg=#73D0FF,underline'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=#73D0FF,underline'
ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]='fg=#73D0FF,underline'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=#FFCC66'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=#FFCC66'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#CBCCC6'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#CBCCC6'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#BAE67E'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#BAE67E'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=#BAE67E'
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=#95E6CB'
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=#95E6CB'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=#CBCCC6'
ZSH_HIGHLIGHT_STYLES[assign]='fg=#CBCCC6'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=#D4BFFF'
ZSH_HIGHLIGHT_STYLES[comment]='fg=#5C6773'

# Fish-matched autosuggestion color
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#707A8C'

[ -f "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] && \
  source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# ---- prompt (port of fish_prompt.fish) ----
[ -f "$HOME/.config/zsh/prompt.zsh" ] && source "$HOME/.config/zsh/prompt.zsh"

# ---- user functions ----
[ -f "$HOME/.config/zsh/functions.zsh" ] && source "$HOME/.config/zsh/functions.zsh"
