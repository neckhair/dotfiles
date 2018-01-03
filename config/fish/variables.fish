
set EDITOR nvim

# set the workspace path
set -x GOPATH $HOME/src/go

# add the go bin path to be able to execute our programs
set -x PATH $PATH $GOPATH/bin
