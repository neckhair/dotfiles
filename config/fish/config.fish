set EDITOR nvim

set --universal -x GOPATH $HOME/src/go
set PATH $GOPATH/bin $PATH

status --is-interactive; and source (rbenv init -|psub)
