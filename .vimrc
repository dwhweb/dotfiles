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
Plugin 'jiangmiao/auto-pairs'
Plugin 'vim-syntastic/syntastic'
Plugin 'Shougo/neocomplete'
Plugin 'shawncplus/phpcomplete.vim'
Plugin 'gregsexton/MatchTag'
Plugin 'vim-scripts/closetag.vim'
Plugin 'Shougo/context_filetype.vim'
Plugin 'davidhalter/jedi-vim'


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

"Vim specific
set rnu "Enables relative line numbers
set nu "Set current line number to actual line number rather than 0
set autoindent
set encoding=utf-8
"Map :W to 'sudo save file'
"command W w !sudo tee % >/dev/null
"Filetype specific tabs
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType xhtml setlocal shiftwidth=2 tabstop=2
"Enable jumping between tags
runtime macros/matchit.vim

"Key bindings
"Map F1 to toggle paste mode
set pastetoggle=<F1> 
"Map F2 to toggle autopairs
let g:AutoPairsShortcutToggle = '<F2>'
"Map F3 to toggle absolute/relative line numbering
nnoremap <F3> :call ToggleNumber()<CR>

function! ToggleNumber() "{{{
	echo "Toggling line numbers"

	if exists('+relativenumber')
		:exec &nu==&rnu? "setl nu!" : "setl rnu!"
	else
		setl nu! 
	endif
endfunction "}}}

"Map F5 to toggle PHP/html for indentation
nnoremap <F5> :call ToggleFileType()<CR>

function! ToggleFileType()
	if &ft == 'php'
		let &ft = 'html'
		echo "Filetype set to html"
	elseif &ft == 'html'
		let &ft = 'php'	 
		echo "Filetype set to php"
	endif
endfunction

"Distinguished theme
:silent! colorscheme distinguished "Set the colour scheme

"Vim airline
set laststatus=2 "Enables vim-airline all the time
let g:airline_powerline_fonts = 1 "Populate symbol dictionary with powerline symbols for vim-airline
let g:airline#extensions#tabline#enabled = 1 "Turn on buffer line at top of window
let g:airline#extensions#tabline#buffer_nr_show = 1 "Show buffer numbers in buffer line
let g:airline_theme='distinguished' "Set airline theme

"Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
"Ignore empty tag errors in HTML files
let g:syntastic_html_tidy_ignore_errors=["trimming empty"]

"Neocomplete
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }
" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'
" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()
" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
"FileType specific omnifunc settings
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
"autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
"autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"Force neocomplete to do omnicompletion on PHP
let g:neocomplete#sources#omni#input_patterns.php =
\ '\h\w*\|[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'
"Disable preview window
set completeopt-=preview

"Python autocompletion (Jedi-vim)
if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif
autocmd FileType python setlocal omnifunc=jedi#completions
let g:jedi#auto_vim_configuration = 0
let g:jedi#popup_on_dot = 0
let g:neocomplete#force_omni_input_patterns.python = '[^. \t]\.\w*'
