let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

syntax on

set fileformat=unix
set encoding=UTF-8

set tabstop=2
set softtabstop=2
set shiftwidth=2
set autoindent
set smartindent
set smarttab
set expandtab
set nowrap

set cursorline
set number
set relativenumber
set scrolloff=8

set noerrorbells visualbell t_vb=
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set clipboard=unnamedplus

set ignorecase
set smartcase
set incsearch
set hlsearch
nnoremap <CR> :noh<CR><CR>:<backspace>

set termguicolors

" install plugins
call plug#begin()
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'jiangmiao/auto-pairs'

call plug#end()

" use catppuccin colorscheme
colorscheme catppuccin_mocha
hi Normal ctermbg=NONE guibg=NONE

