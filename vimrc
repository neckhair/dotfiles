
set shell=/bin/bash

autocmd!
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

" My Plugins here:
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-fugitive'
Plugin 'kchmck/vim-coffee-script'
Plugin 'scrooloose/syntastic'
Plugin 'duggiefresh/vim-easydir'
Plugin 'christoomey/vim-tmux-navigator'

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

Plugin 'tomtom/tcomment_vim'
Plugin 'tpope/vim-endwise'

Plugin 'altercation/vim-colors-solarized'

Plugin 'smerrill/vcl-vim-plugin' " Varnish VCL Syntax

call vundle#end()
filetype plugin indent on

" set the leader
let mapleader = ","

" set colorscheme (in ~/.vim/colors/)
set background=dark
colorscheme smyck

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

" disable ex-mode
nnoremap Q <nop>

" enable line numbers
set number
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

" automatically resize vim in command windows
autocmd VimResized * :wincmd =

" Searching
set hlsearch    " Highlight searches
set ignorecase  " Ignore case of searches
set smartcase   " ... unless they contain at least one capital letter
set incsearch   " Highlight dynamically as pattern is typed
nnoremap <leader>h :noh<cr>

set autoindent  " indent on enter
set smartindent " do smart indenting when starting a new line
set shiftround  " indent to the closest shiftwidth

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

set splitright                  " open vertical splits on the right
set splitbelow                  " open the horizontal split below

set wildignore+=*/tmp/*,*.so,*.swp,*.zip

" Use only 1 space after "." when joining lines instead of 2
set nojoinspaces

" Make those debugger statements painfully obvious
au BufEnter *.rb syn match error contained "\<binding.pry\>"
au BufEnter *.rb syn match error contained "\<debugger\>"

set nobackup
set noswapfile

" Auto-reload buffers when files are changed on disk
set autoread

" Lines with equal indent form a fold.
set foldmethod=indent
set foldlevel=1
set foldnestmax=10
set nofoldenable    " Open all folds by default

" Use ack instead of grep
set grepprg=ack

" disable automatic code folding for markdown plugin
let g:vim_markdown_folding_disabled=1

set guifont=Menlo\ for\ Powerline:h14

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

" RSpec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>
let g:rspec_runner = "os_x_iterm"

if has('gui_running')
  let g:rspec_command = "bundle exec rspec {spec}"
else
  let g:rspec_command = "Dispatch bundle exec rspec {spec}"
endif

" Syntastic Rubocop integration
let g:syntastic_ruby_checkers = ['mri']

" Switch between splits C-j etc
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" screen splitting
map <leader>s :sp<cr>
map <leader>v :vs<cr>

" Emmet vim
let g:user_emmet_leader_key='<C-Z>'

" copy file path to clipboard
noremap <Leader>f :let @+ = expand("%")<CR>

" airline settings
" Download Font and use it in iTerm2:
" https://gist.github.com/baopham/1838072/raw/5fa73caa4af86285f11539a6b4b6c26cfca2c04b/Monaco%20for%20Powerline.otf
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
