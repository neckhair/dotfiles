set shell=/bin/zsh

autocmd!
set nocompatible
filetype off

call plug#begin('~/.vim/plugged')

Plug 'gmarik/Vundle.vim'

" My Plugins here:
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-fugitive'
Plug 'vim-ruby/vim-ruby'
Plug 'duggiefresh/vim-easydir'
Plug 'christoomey/vim-tmux-navigator'
Plug 'gorkunov/smartgf.vim' " not working with colorscheme onedark
Plug 'rking/ag.vim'
Plug 'danro/rename.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag'     " html tags auto close
Plug 'mhinz/vim-startify'
Plug 'mattn/emmet-vim'

Plug 'fatih/vim-go'

Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-surround'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-endwise'
Plug 'ervandew/supertab'

Plug 'rizzatti/funcoo.vim'
Plug 'rizzatti/dash.vim'

Plug 'tpope/vim-dispatch'
if has('nvim')
  Plug 'kassio/neoterm'
  Plug 'benekastah/neomake'
end

Plug 'ekalinin/Dockerfile.vim'
Plug 'smerrill/vcl-vim-plugin' " Varnish VCL Syntax
Plug 'rodjek/vim-puppet'
Plug 'plasticboy/vim-markdown'
Plug 'kchmck/vim-coffee-script'
Plug 'asciidoc/vim-asciidoc'

Plug 'flazz/vim-colorschemes'
Plug 'morhetz/gruvbox'

Plug 'elixir-lang/vim-elixir'

call plug#end()
filetype plugin indent on

" set the leader
let mapleader = ","

" set colorscheme (in ~/.vim/colors)
colorscheme gruvbox
set background=dark
set linespace=2

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
set foldlevel=2
set foldnestmax=10
set nofoldenable    " Open all folds by default
nnoremap <Space> za

" Use ack instead of grep
set grepprg=ack

" disable automatic code folding for markdown plugin
let g:vim_markdown_folding_disabled=1

set guifont=Menlo\ for\ Powerline:h14

" Automatic commands
if has("autocmd")
  " Enable file type detection
  filetype on
  " Treat .json files as .js
  autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
  " Treat .cjsx files as .coffee
  autocmd BufRead,BufNewFile *.cjsx set filetype=coffee

  autocmd BufRead,BufNewFile *.asc set filetype=asciidoc

  if has('nvim')
    " Neomake
    autocmd! BufWritePost * Neomake
  endif

  " Strip trailing whitespace (,ss)
  fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
  endfun
  autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()
endif

" Toggle NerdTree
nmap <silent> <C-N> :NERDTreeToggle<CR>

" Search word under cursor in Dash
nmap <silent> <C-D> <Plug>DashSearch

" Neoterm
if has('nvim')
  let g:neoterm_position = 'horizontal'
  let g:neoterm_rspec_lib_cmd = 'rspec'
  let g:neoterm_run_tests_bg = 1 " run tests in background
  let g:neoterm_raise_when_tests_fail = 1
  let g:neoterm_size = 15
  let g:neoterm_test_status_format = '%s '
  let g:neoterm_test_status = {'running': '🏃', 'success': '✅', 'failed': '❌'}

  nnoremap <silent> ,rt :call neoterm#test#run('all')<cr>
  nnoremap <silent> ,rf :call neoterm#test#run('file')<cr>
  nnoremap <silent> ,rn :call neoterm#test#run('current')<cr>
  nnoremap <silent> ,rr :call neoterm#test#rerun()<cr>

  " hide/close all terminals
  nnoremap <silent> ,th :Tclose<cr>

  hi MyMsg ctermbg=0 ctermfg=0
  let g:neomake_error_sign = { 'text': '‼️', 'texthl': 'MyMsg', }
  let g:neomake_warning_sign = { 'text': '⚠️', 'texthl': 'MyMsg', }
endif


" Syntastic Rubocop integration
let g:syntastic_ruby_checkers = ['mri']

" Switch between splits C-j etc
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" tab movement with H and L
nnoremap H gT
nnoremap L gt

" screen splitting
map <leader>s :sp<cr>
map <leader>v :vs<cr>

" copy file path to clipboard
noremap <Leader>f :let @+ = expand("%")<CR>

" insert binding.pry
map <Leader>bp orequire'pry';binding.pry<esc>:w<cr>

" open alternative (rails spec)
noremap <Leader>a :AV<CR>

" close current window
noremap <Leader>q :q<CR>

" save
noremap <Leader>w :w<CR>

" html autoclose file endings
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.html.erb"

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" lightline settings
let g:lightline = {
      \ 'active': {
      \   'right': [ [ 'lineinfo' ], ['percent'], [ 'neoterm', 'fileformat', 'fileencoding', 'filetype' ] ],
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"⭤":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_function': {
      \   'neoterm': 'NeotermStatus',
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '|', 'right': '|' }
      \ }

function! NeotermStatus()
  if has('nvim')
    return neoterm#test#status('running') . neoterm#test#status('success') . neoterm#test#status('failed')
  else
    return ''
  end
endfunction

" Go settings
autocmd FileType go nmap <leader>r <Plug>(go-run)
autocmd FileType go nmap <leader>b <Plug>(go-build)
autocmd FileType go nmap <leader>t <Plug>(go-test)
autocmd FileType go nmap <leader>c <Plug>(go-coverage)

autocmd FileType go nmap <Leader>ds <Plug>(go-def-split)
autocmd FileType go nmap <Leader>dv <Plug>(go-def-vertical)
autocmd FileType go nmap <Leader>dt <Plug>(go-def-tab)
