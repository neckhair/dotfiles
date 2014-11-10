
set shell=/bin/bash

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

Plugin 'gmarik/vundle'

" My Plugins here:
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-fugitive'
Plugin 'kchmck/vim-coffee-script'
Plugin 'scrooloose/syntastic'
Plugin 'bling/vim-airline'
Plugin 'plasticboy/vim-markdown'
Plugin 'tpope/vim-surround'

Plugin 'rizzatti/funcoo.vim'
Plugin 'rizzatti/dash.vim'

Plugin 'rodjek/vim-puppet'

Plugin 'thoughtbot/vim-rspec'
Plugin 'tpope/vim-dispatch'

Plugin 'parkr/vim-jekyll'

Plugin 'ekalinin/Dockerfile.vim'

Plugin 'mattn/emmet-vim'
Plugin 'tomtom/tcomment_vim'

Plugin 'christoomey/vim-tmux-navigator'

call vundle#end()
filetype plugin indent on

" set the leader
let mapleader = ","

" set colorscheme (in ~/.vim/colors/)
colorscheme jellybeans
let g:rehash256 = 1

" Use the OS clipboard by default
set clipboard=unnamed

" Enhance command-line completion
set wildmenu

" Allow cursor keys in insert mode
set esckeys

" Allow backspace in insert mode
set backspace=indent,eol,start

" Optimize for fast terminal connections
set ttyfast

" Use UTF-8 without BOM
set encoding=utf-8 nobomb

" enable line numbers
set number
set relativenumber
set scrolloff=3
set numberwidth=5

" enable syntax highlighting
syntax on

" highlight current line
set cursorline

" Make tabs as wide as two spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Show “invisible” characters
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
set list

" Highlight searches
set hlsearch
" Ignore case of searches
set ignorecase
" Highlight dynamically as pattern is typed
set incsearch

" Disable error bells
set noerrorbells

" Don’t reset cursor to start of line when moving around.
set nostartofline

" Show the cursor position
set ruler

" Don’t show the intro message when starting Vim
set shortmess=atI

" Show the current mode
set showmode

" Show the filename in the window titlebar
set title

" Always show the statusline
set laststatus=2

set textwidth=110
set colorcolumn=+1
set nowrap

" disable automatic code folding for markdown plugin
let g:vim_markdown_folding_disabled=1

set guifont=Monaco:h14

" Strip trailing whitespace (,ss)
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" Automatic commands
if has("autocmd")
  " Enable file type detection
  filetype on
  " Treat .json files as .js
  autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
endif

" Toggle NerdTree
nmap <silent> <C-N> :NERDTreeToggle<CR>

" Search word under cursor in Dash
nmap <silent> <C-D> <Plug>DashSearch

" skip backup for temporary files (in particular crontab)
set backupskip=/tmp/*,/private/tmp/*

" RSpec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>
let g:rspec_command = "Dispatch rspec {spec}"
let g:rspec_runner = "os_x_iterm"

" Syntastic Rubocop integration
let g:syntastic_ruby_checkers = ['mri', 'rubocop']

" Switch between splits C-j etc
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" airline settings
" Download Font and use it in iTerm2:
" https://gist.github.com/baopham/1838072/raw/5fa73caa4af86285f11539a6b4b6c26cfca2c04b/Monaco%20for%20Powerline.otf
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
