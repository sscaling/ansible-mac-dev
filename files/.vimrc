" Use :PlugInstall to install anything defined here
call plug#begin('~/.vim/plugged')
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'fatih/molokai'
Plug 'pearofducks/ansible-vim'
Plug 'ctrlpvim/ctrlp.vim'
call plug#end()

:set ruler
:set number
:set is
:set autowrite

" ----- vim-go config
let g:go_fmt_command = "goimports"
" use 4 spaces for a tab
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

" For quickfix window:  Map in 'normal' mode Ctrl+n to :next + <CR>
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

" Map normal mode <leader> (aka \) to shortcuts for building / running go
" program
"autocmd FileType go nmap <leader>b <Plug>(go-build)
autocmd FileType go nmap <leader>r <Plug>(go-run)
autocmd FileType go nmap <leader>t <Plug>(go-test)
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
autocmd FileType go nmap <Leader>i <Plug>(go-info)

" Automatically display type info in status bar
let g:go_auto_type_info = 1
" refresh status line quicker than the default 800ms
set updatetime=100

" Automatically highlight matching ids
let g:go_auto_sameids = 1

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#cmd#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

" How to open alternative file
autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

" Color scheme
let g:rehash256 = 1
let g:molokai_original = 1
colorscheme molokai
