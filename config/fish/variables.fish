
set EDITOR nvim

# set the workspace path
set -x GOPATH $HOME/src/go

# add the go bin path to be able to execute our programs
set -x PATH $PATH $GOPATH/bin

set -x PATH $HOME/bin $PATH
set -g fish_user_paths "/usr/local/sbin"

set -x TF_VAR_nine_mnt_ssh_user phil
