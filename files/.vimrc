call plug#begin('~/.vim/plugged')
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'pearofducks/ansible-vim'
call plug#end()

:set ruler
:set number
:set is
:set autowrite
