set shell=/bin/bash

autocmd!
set nocompatible
filetype off

call plug#begin('~/.vim/plugged')

Plug 'gmarik/Vundle.vim'

Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'airblade/vim-gitgutter', { 'branch': 'nvim' }
Plug 'tpope/vim-fugitive'
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'duggiefresh/vim-easydir'
Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag'     " html tags auto close
Plug 'tomtom/tcomment_vim'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'ervandew/supertab'

" Neovim stuff
if has('nvim')
  Plug 'kassio/neoterm'
  Plug 'benekastah/neomake'
end

" Language plugins
Plug 'ekalinin/Dockerfile.vim'
Plug 'fatih/vim-go'
Plug 'kchmck/vim-coffee-script'
Plug 'mattn/emmet-vim'
Plug 'rodjek/vim-puppet'
Plug 'smerrill/vcl-vim-plugin' " Varnish VCL Syntax
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-rails'
Plug 'lepture/vim-jinja'
Plug 'cespare/vim-toml'
Plug 'dag/vim-fish'

" Prosa and Markdown
Plug 'reedes/vim-pencil'
Plug 'tpope/vim-markdown'

" Colors
Plug 'flazz/vim-colorschemes'
Plug 'tomasr/molokai'
Plug 'dracula/vim', { 'as': 'dracula'  }

call plug#end()
filetype plugin indent on

" set the leader
let mapleader = ","

" set colorscheme (in ~/.vim/colors)
set background=dark
let g:rehash256=1
set t_Co=256
colorscheme dracula
set linespace=2

" Use the OS clipboard by default
set clipboard=unnamed

" Enhance command-line completion
set wildmenu

" Allow backspace in insert mode
set backspace=indent,eol,start

" Optimize for fast terminal connections
set ttyfast

" disable ex-mode
nnoremap Q <nop>

" enable line numbers
set number
set scrolloff=3
set numberwidth=5

" enable syntax highlighting
syntax on

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

" pencil for prose files (markdown, text)
augroup pencil
  autocmd!
  autocmd FileType markdown,mkd,md call pencil#init({'wrap': 'soft'})
  autocmd FileType text            call pencil#init({'wrap': 'soft'})
augroup END

set guifont=Menlo:h16

" Automatic commands
if has("autocmd")
  " Enable file type detection
  filetype on
  autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript " Treat .json files as .js
  autocmd BufRead,BufNewFile *.cjsx set filetype=coffee " Treat .cjsx files as .coffee
  autocmd BufRead,BufNewFile *.asc set filetype=asciidoc
  autocmd BufNewFile,BufRead *.jbuilder setfiletype ruby syntax=ruby
  autocmd BufNewFile,BufRead *.j2 set ft=jinja

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

" Neoterm
if has('nvim')
  let g:neoterm_position = 'horizontal'
  let g:neoterm_size = 15

  " hide/close all terminals
  nnoremap <silent> ,th :Tclose<cr>
  " map escape to exit terminal
  tnoremap <Esc> <C-\><C-n>

  :highlight NeomakeWarning ctermbg=0 ctermfg=214
  :highlight NeomakeError ctermbg=0 ctermfg=196
  let g:neomake_error_sign = { 'text': '!!', 'texthl': 'NeomakeError', }
  let g:neomake_warning_sign = { 'text': 'W', 'texthl': 'NeomakeWarning', }
endif

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
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '|', 'right': '|' }
      \ }

" Go settings
autocmd FileType go nmap <leader>r <Plug>(go-run)
autocmd FileType go nmap <leader>b <Plug>(go-build)
autocmd FileType go nmap <leader>i <Plug>(go-install)
autocmd FileType go nmap <leader>t <Plug>(go-test)
autocmd FileType go nmap <leader>c <Plug>(go-coverage)

autocmd FileType go nmap <Leader>ds <Plug>(go-def-split)
autocmd FileType go nmap <Leader>dv <Plug>(go-def-vertical)
autocmd FileType go nmap <Leader>dt <Plug>(go-def-tab)

" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')
