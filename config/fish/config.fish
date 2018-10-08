source ~/.config/fish/variables.fish
source ~/.config/fish/aliases.fish

status --is-interactive; and source (rbenv init -|psub)

set -g fish_user_paths "/usr/local/sbin" $fish_user_paths
