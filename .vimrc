call plug#begin('~/.vim/plugged')

Plug 'AlessandroYorba/Alduin' " colorscheme
Plug 'Townk/vim-autoclose'
Plug 'airblade/vim-gitgutter'
Plug 'bling/vim-bufferline'
Plug 'itchyny/lightline.vim'
Plug 'ivan-krukov/vim-snakemake'
Plug 'jlanzarotta/bufexplorer'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim' "depends on the basic Vim plugin of the main fzf repository (junegunn/fzf)
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'ekalinin/Dockerfile.vim'

call plug#end()

set laststatus=2

map ,n  :NERDTreeToggle<cr>
map delb  :+,$d<cr>

highlight clear
colorscheme alduin " AlessandroYorba/Alduin
highlight String ctermbg=none

autocmd bufwritepre         *                :%s/\s\+$//e
autocmd bufwritepre         *                :%s/^\s\+$//e


set cmdheight=1
set cursorline
set dir=/var/tmp
set encoding=utf-8
set expandtab
set formatoptions=""
set hidden
set history=10000
set ignorecase
set laststatus=2
set list
set listchars=tab:>-,trail:·
set mouse=""
set noautoindent
set nocompatible
set nohlsearch
set noshowmatch   " don't light up matching brackets/braces
set noswapfile
set number
set scrolloff=0   " centers line in middle of screen so typing is stable
set shiftround    " always indent/outdent to nearest tabstop
set showtabline=1 " show tabline with more than one doc
set smartcase     " case matters in searches if you use uppercase
set spellsuggest=7
set splitbelow
set splitright
set t_vb="" " disable visualbell flashing
set textwidth=132
set timeoutlen=1000 " 300ms timeout on mapped key combinations
set updatetime=30000 " milliseconds after you stop typing before swap file written and CursorHold autocommand event (default 4000ms)
set viminfo='1000,f1,\"500
set visualbell     " visual bell instead of beeping
set wildignore+=.git/**,tmp/venv/**,venv/**,vendor/**,.venv/**
set wildmenu
set wildmode=list:longest
set winwidth=132 winminwidth=24
set wrap   "     "

"----

nnoremap ,b :BufExplorer<cr>
nnoremap ,<tab> :bn<cr>
nnoremap <space> <C-w>

nnoremap ,z <C-z>

nnoremap ,m :w<enter>:!make<enter>

"----

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

set list
set listchars=tab:>-,trail:.

set background=dark
set t_Co=256



