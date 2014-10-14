set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Plugin 'Valloric/YouCompleteMe'

Plugin 'MaxWayt/ack.vim'

Plugin 'jnwhiteh/vim-golang'

Plugin 'acp.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


scriptencoding utf-8
set fileencoding=utf-8

set nocompatible
syntax on
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set textwidth=80

filetype plugin on
filetype indent on

set t_Co=256
set background=dark
let g:gruvbox_italicize_comments=0
colorscheme gruvbox

set number
set showcmd
set mouse=a
set cursorline

set list
set listchars=tab:>\ 

highlight ExtraWhitespaces  ctermbg=RED guibg=#A00000
highlight ExtraCaractere    ctermbg=124 guibg=#A00000

inoremap ''; '';<esc>hi
inoremap '' ''<esc>i
inoremap ""; "";<esc>hi
inoremap "" ""<esc>i
inoremap (( ()<esc>i
inoremap ((; ();<esc>hi
inoremap [[ []<esc>i
inoremap [[; []<esc>hi
inoremap {{ {<cr>}<esc>ki<right><cr>
inoremap {{; {<cr>};<esc>ki<right><cr>

set nobackup
set nowritebackup


set guioptions-=T "remove toolbar
set guioptions-=r "remove right-hand scroll bar
set guioptions-=L "remove left-hand scroll bar. Fix for TagBar.

set autowrite


autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

let g:ycm_collect_identifiers_from_tags_files = 1
set tags=./tags

let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'

set backspace=indent,eol,start

set shell=/bin/bash

set wildmenu    "easy tabs completition

function CheckMakefile()
	if filereadable("Makefile")
		make all
	endif
endfunction

function EPIConfig(task)
	if a:task == "set"
		if expand("%") == "Makefile"
			execute "0read ~/.vim/headers/makefile"
		else
			execute "0read ~/.vim/headers/c"
		endif
		execute "%substitute,$FILE," . expand("%") . ",e"
		execute "%substitute,$FLDR," . expand("%:p:h:t") . ",e"
		execute "%substitute,$PATH," . expand("%:p:h") . ",e"
		execute "%substitute,$NAME," . $VIM_NAME . ",e"
		execute "%substitute,$NICK," . $VIM_NICK . ",e"
		execute "%substitute,$EMAIL," . $VIM_EMAIL . ",e"
		execute "%substitute,$DATE," . strftime("%a %b %d %H:%M:%S %Y") . ",e"
		call EPIConfig("update")
		normal Go
	elseif a:task == "read"
		set shiftwidth=2
		set softtabstop=4
		set tabstop=4
	elseif a:task == "update"
		let cursor = getpos(".")
		execute "%substitute,Update.*,Update       " . strftime("%a %b %d %H:%M:%S %Y") . " " . $VIM_NICK . ",e"
		call setpos(".", cursor)
	endif
endfunction

highlight TrailingSpaces ctermbg=red
autocmd BufWinEnter * match TrailingSpaces /\s\+$/
autocmd InsertEnter * match TrailingSpaces /\s\+$/

autocmd BufNewFile		*.{c,h},Makefile	call EPIConfig("set")
"autocmd BufWinEnter		*.{c,h},Makefile	call EPIConfig("read")
autocmd BufWritePre		*.{c,h},Makefile	call EPIConfig("update")
autocmd BufWritePost	*.{c,h}				call CheckMakefile()

if filereadable(".vim.custom")
  source .vim.custom
endif
