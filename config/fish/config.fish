source ~/.config/fish/variables.fish
source ~/.config/fish/aliases.fish

status --is-interactive; and source (rbenv init -|psub)
