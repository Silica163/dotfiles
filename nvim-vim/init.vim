source /usr/share/nvim/archlinux.vim
source ~/.config/nvim/colors/colors.vim
set number relativenumber cursorline mouse= scrolloff=5
syntax on
filetype plugin indent on

call plug#begin('~/.vim/plugged')
    Plug 'ThePrimeagen/vim-be-good'
    Plug 'yuezk/vim-js'
    Plug 'vim-python/python-syntax'
    Plug 'bfrg/vim-cpp-modern'
"	Plug 'nvim-treesitter/nvim-treesitter'
call plug#end()

set tabstop=4 softtabstop=4 shiftwidth=4 expandtab
set laststatus=3
set stl=%f\ %h%m%r%=%-30{strftime('%R\ %d-%h-%Y')}%-15.(%l,%c%)\ %P
