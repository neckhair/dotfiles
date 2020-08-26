source ~/.config/fish/variables.fish
source ~/.config/fish/aliases.fish

status --is-interactive; and source (rbenv init -|psub)

set -g fish_user_paths "/usr/local/sbin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/postgresql@9.6/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/helm@2/bin" $fish_user_paths
