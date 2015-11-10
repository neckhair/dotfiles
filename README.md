# My Dotfiles

## Fix for the Ctrl-H issue in neovim

```sh
infocmp $TERM | sed 's/kbs=^[hH]/kbs=\\177/' > $TERM.ti
tic $TERM.ti
```
