
source /Users/theadam/.docker/init-fish.sh || true # Added by Docker Desktop

alias vim="nvim"
alias kafka-consumer-groups="/Users/theadam/Documents/workspace/kafka-topics/bin/kafka-consumer-groups.sh"
alias kafka-topics="/Users/theadam/Documents/workspace/data-producer/bin/kafka-topics.sh"
alias kafka-configs="/Users/theadam/Documents/workspace/kafka-topics/bin/kafka-configs.sh"
alias kcat="/Users/theadam/Documents/workspace/kafka-topics/bin/kcat.sh"

set -gx WORKON_HOME ~/.virtualenvs
set -gx JAVA_8_HOME (/usr/libexec/java_home -v1.8)
set -gx JAVA_11_HOME (/usr/libexec/java_home -v11)
set -gx JAVA_16_HOME (/usr/libexec/java_home -v16)
set -gx EDITOR nvim

fish_add_path (pyenv root)/shims
fish_add_path (nodenv root)/shims

set -gx JAVA_HOME $JAVA_11_HOME

function java8
    set -gx JAVA_HOME $JAVA_8_HOME
end

function java11
    set -gx JAVA_HOME $JAVA_11_HOME
end

function java16
    set -gx JAVA_HOME $JAVA_16_HOME
end
