" Use :PlugInstall to install anything defined here
call plug#begin('~/.vim/plugged')
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
" Cannot get ultisnips working with deoplete/nvim
" Plug 'SirVer/ultisnips'
Plug 'fatih/molokai'
Plug 'pearofducks/ansible-vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'moorereason/vim-markdownfmt'
Plug 'airblade/vim-gitgutter'
" Auto completion for neovim
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-go', { 'do': 'make'}
" Awesome status/tabline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" file browsing
Plug 'scrooloose/nerdtree'
call plug#end()

:set ruler
:set number
:set is
:set autowrite

" Status / tab line
set noshowmatch                 " Do not show matching brackets by flickering
set noshowmode                  " We show the mode with airline or lightline

set showcmd   " The command we're typing

set splitright                  " Split vertical windows right to the current windows
set splitbelow                  " Split horizontal windows below to the current windows
set encoding=utf-8              " Set default encoding to UTF-8

set autoread                    " Automatically reread changed files without asking me anything



" airline
"let g:airline_theme='solarized'
let g:airline#extensions#tabline#enabled = 1

"==================== NerdTree ====================
"" For toggling
nmap <C-n> :NERDTreeToggle<CR>
noremap <Leader>n :NERDTreeToggle<cr>
noremap <Leader>f :NERDTreeFind<cr>

let NERDTreeShowHidden=0

let NERDTreeIgnore=['\.vim$', '\~$', '\.git$', '.DS_Store']

" Close nerdtree and vim on close file
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" deoplete
if has('nvim')
  let g:python3_host_prog = '/usr/local/bin/python3'
  let g:deoplete#enable_at_startup = 1
  let g:deoplete#ignore_sources = {}
  let g:deoplete#ignore_sources._ = ['buffer', 'member', 'tag', 'file', 'neosnippet']
  let g:deoplete#sources#go#sort_class = ['func', 'type', 'var', 'const']
  let g:deoplete#sources#go#align_class = 1


  " Use partial fuzzy matches like YouCompleteMe
  call deoplete#custom#set('_', 'matchers', ['matcher_fuzzy'])
  call deoplete#custom#set('_', 'converters', ['converter_remove_paren'])
  call deoplete#custom#set('_', 'disabled_syntaxes', ['Comment', 'String'])
endif


" Better Completion
set complete=.,w,b,u,t
set completeopt=longest,menuone

" ==================== vim-mardownfmt ====================
let g:markdownfmt_autosave = 1
autocmd BufNewFile,BufReadPost *.md setl ts=4 sw=4 sts=4 expandtab
let g:markdownfmt_command = 'markdownfmt'

" ========= vim-better-whitespace ==================

" auto strip whitespace except for file with extention blacklisted
let blacklist = ['markdown', 'md']
autocmd BufWritePre * StripWhitespace

" ----- vim-go config
let g:go_fmt_command = "goimports"
let g:go_term_enabled = 1  " enables terminal for things like :GoTest
let g:go_term_mode = "split" " split terminal horizontally
" All lists are quickfix (rather than mixing in location lists)
let g:go_list_type = "quickfix"
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

" Output function into a scratch buffer
" http://vim.wikia.com/wiki/Capture_ex_command_output
function! OutputSplitWindow(...)
  " this function output the result of the Ex command into a split scratch buffer
  let cmd = join(a:000, ' ')
  let temp_reg = @"
  redir @"
  silent! execute cmd
  redir END
  let output = copy(@")
  let @" = temp_reg
  if empty(output)
    echoerr "no output"
  else
    new
    setlocal buftype=nofile bufhidden=wipe noswapfile nobuflisted
    put! =output
  endif
endfunction
command! -nargs=+ -complete=command Output call OutputSplitWindow(<f-args>)
