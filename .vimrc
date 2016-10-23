" Significant portion has been copied from
" https://github.com/venantius/dotfiles/blob/master/.vimrc

set nocompatible


call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'nanotech/jellybeans.vim'
Plug 'endel/vim-github-colorscheme'
Plug 'morhetz/gruvbox'

Plug 'ctrlpvim/ctrlp.vim'

Plug 'guns/vim-clojure-highlight'
Plug 'guns/vim-clojure-static'

Plug 'tpope/vim-fireplace'

Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'guns/vim-sexp'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

Plug 'tpope/vim-fugitive'

Plug 'ervandew/supertab'

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

call plug#end()

" theme

set background=dark
set t_Co=256
color jellybeans
 
" syntax
syntax on
filetype plugin indent on

" leader
let mapleader=','
set pastetoggle=<Leader>t
map <Leader>d <C-]>

" font
if has("gui_running")
  if has("gui_gtk3")
    set guifont=Fira\ Code\ 13
  endif
endif

""""""""""
" config
""""""""""

set wildmenu
set wildmode=list:longest
set nocompatible
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set cindent " replaceing smartindent because of some weird stuff with # symbols
set laststatus=2
set backspace=indent,eol,start
set number
set laststatus=2
set showmatch
set incsearch
set hlsearch
set ignorecase smartcase
set cmdheight=1
set switchbuf=useopen
set wrap
set linebreak
set nolist
set textwidth=0
set wrapmargin=0
set winwidth=79
set shell=bash
set scrolloff=3
set showcmd
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" autoclose omni-complete preview
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif


" Clojure
au Filetype clojure nmap <c-c><c-k> :Require<cr>
au Filetype clojure let g:clojure_fuzzy_indent = 1
au Filetype clojure let g:clojure_fuzzy_indent_patterns = ['^with', '^def', '^let']
au BufNewFile,BufRead *.edn set filetype=clojure
au Filetype clojure autocmd BufWritePre * :%s/\s\+$//e
function! TestToplevel() abort
    "Eval the toplevel clojure form (a deftest) and then test-var the
    "result."
    normal! ^
    let line1 = searchpair('(','',')', 'bcrn', g:fireplace#skip)
    let line2 = searchpair('(','',')', 'rn', g:fireplace#skip)
    let expr = join(getline(line1, line2), "\n")
    let var = fireplace#session_eval(expr)
    let result = fireplace#echo_session_eval("(clojure.test/test-var " . var . ")")
    return result
endfunction
au Filetype clojure nmap <c-c><c-t> :call TestToplevel()<cr>
