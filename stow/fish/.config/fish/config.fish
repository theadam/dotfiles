if test -x /home/linuxbrew/.linuxbrew/bin/brew
    /home/linuxbrew/.linuxbrew/bin/brew shellenv fish | source
end

if type -q fnm
    fnm env --use-on-cd --shell fish | source
end

alias vim="nvim"
alias ls="eza"

set -gx WORKON_HOME ~/.virtualenvs
set -gx EDITOR nvim

# function javav
#     set -gx JAVA_HOME (/usr/libexec/java_home -v$argv[1])
#     echo "JAVA_HOME set to $JAVA_HOME"
# end

# javav 11

fzf --fish | source

test -f ~/.config/local/fish/config.fish; and source ~/.config/local/fish/config.fish
