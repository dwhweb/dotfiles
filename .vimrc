"Map :W to 'sudo save file'
command W w !sudo tee % >/dev/null

set nocompatible              " be iMproved, required
filetype off                  " required
set t_Co=256
syntax on
set background=dark

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'Distinguished'
Plugin 'vim-airline/vim-airline'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'Raimondi/delimitMate'
Plugin 'myusuf3/numbers.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'vim-syntastic/syntastic'
Plugin 'ternjs/tern_for_vim'
Plugin 'Shougo/neocomplete'

call vundle#end()            " required
filetype plugin indent on    " required

" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

:silent! colorscheme distinguished "Set the colour scheme
set laststatus=2 "Enables vim-airline all the time
set number "Enables line numbers all the time
let g:airline_powerline_fonts = 1 "Populate symbol dictionary with powerline symbols for vim-airline
let g:airline#extensions#tabline#enabled = 1 "Turn on buffer line at top of window
let g:airline#extensions#tabline#buffer_nr_show = 1 "Show buffer numbers in buffer line
let g:airline_theme='distinguished' "Set airline theme
let delimitMate_expand_cr = 2 "Setup delimitmate to automatically expand delimiters on <CR> 

"Map F3 to turn relative numbering on and off
nnoremap <F3> :NumbersToggle<CR>

"Syntastic default options
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"Enable neocomplete
let g:neocomplete#enable_at_startup = 1

"Set neocomplete options
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS

"Tab related settings
set autoindent noexpandtab tabstop=4 shiftwidth=4
