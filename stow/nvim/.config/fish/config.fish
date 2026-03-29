alias vim="nvim"
alias ls="eza"
alias kafka-consumer-groups="/Users/theadam/Documents/workspace/kafka-topics/bin/kafka-consumer-groups.sh"
alias kafka-topics="/Users/theadam/Documents/workspace/data-producer/bin/kafka-topics.sh"
alias kafka-configs="/Users/theadam/Documents/workspace/kafka-topics/bin/kafka-configs.sh"
alias kcat="/Users/theadam/Documents/workspace/kafka-topics/bin/kcat.sh"

set -gx WORKON_HOME ~/.virtualenvs
set -gx EDITOR nvim

# function javav
#     set -gx JAVA_HOME (/usr/libexec/java_home -v$argv[1])
#     echo "JAVA_HOME set to $JAVA_HOME"
# end

# javav 11

fzf --fish | source

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :
