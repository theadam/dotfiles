# rbenv setup
eval "$(rbenv init -)"

# add custom bin
export PATH=~/bin:$PATH
# add node_modules/.bin
export PATH=./node_modules/.bin:$PATH

# Setup nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# setup git autocomplete and PS1
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
  GIT_PS1_SHOWDIRTYSTATE=true
  GIT_PS1_SHOWCOLORHINTS=true
  GIT_PS1_SHOWSTASHSTATE=true
  GIT_PS1_SHOWUNTRACKEDFILES=true
  export PROMPT_COMMAND='__git_ps1 "\h:\W \u" "\\\$ "'
fi

alias vim='nvim'
alias ls='ls -G'
alias psql='docker exec -it postgres psql -U postgres'
alias redis-cli='docker exec -it redis redis-cli'

export EDITOR=nvim

export JAVA_HOME="$(/usr/libexec/java_home -v 1.8)"

export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh
