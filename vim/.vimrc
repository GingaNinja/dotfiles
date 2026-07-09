set nocompatible

filetype off 	" Required

set rtp+=~/.vim/bundle/vundle/
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'NLKNguyen/papercolor-theme'

call vundle#end()
filetype plugin indent on " Required
set number 
syntax enable
set background=dark
set tabstop=3
set shiftwidth=3
set expandtab
let g:solarized_termcolors = 256
colorscheme PaperColor

