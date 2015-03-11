# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="clean"

# User configuration
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  export EDITOR=vim
else
  export VISUAL=vim
  export EDITOR=$VISUAL
fi
export SSH_KEY_PATH="~/.ssh/id_dsa.pub"
export DOCKER_HOST=tcp://dockerhost:2375

# aliases
alias zshconfig="$EDITOR ~/.zshrc"
alias vimconfig="$EDITOR ~/.vimrc"
alias tlf="tail -f"
alias ln='ln -v'
alias mkdir='mkdir -p'
alias l='ls'
alias ll='ls -al'
alias lh='ls -Alh'

alias tmk="tmux kill-session -t $1"

alias sourcetree='open -a SourceTree'
# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git git-extras osx rails bundler gem rvm brew vagrant tmuxinator tmux)

source $ZSH/oh-my-zsh.sh

# history settings
setopt hist_ignore_all_dups inc_append_history
HISTFILE=~/.zhistory
HISTSIZE=4096
SAVEHIST=4096

function psgrep() { ps axu | grep -v grep | grep "$@" -i --color=auto; }

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# completions
fpath=(/usr/local/share/zsh-completions $fpath)

export PATH=/usr/local/bin:/usr/local/sbin:$PATH
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

export MANAGEMENT_SERVER=phil

# go to project
function pcompl() {
  reply=( $(ls ~/src) )
}
function p() {
  cd ~/src/$1
}
compctl -K pcompl p

# Docker default config
export DOCKER_HOST=tcp://192.168.59.104:2376
export DOCKER_CERT_PATH=/Users/phil/.boot2docker/certs/boot2docker-vm
export DOCKER_TLS_VERIFY=1

function dcclean () { # clean docker container
  docker rm $(docker ps -a -q)
}

function diclean() { # clean docker images
  docker rmi $(docker images | grep "^<none>" | awk '{print $3}')
}

### TMUX functions
function tacompl() {
  reply=( $(tmux list-sessions) )
}
compctl -K tacompl ta

function tc() { # new tmux session
  cd ~/src/$1
  tmux new-session -s "$1" -n vim -d 'vim'
  tmux new-window -t "$1:2" -n "cmd"
  tmux select-window -t "$1:1"
  tmux -2 attach-session -t "$1"
}
compctl -K pcompl tc
