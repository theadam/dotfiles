" Colors
colorscheme quantum
set background=dark

" Turn on line numbers
set number
set nocompatible

" This allows buffers to be hidden if you've modified a buffer.
" This is almost a must if you wish to use buffers in this way.
set hidden

" remember more commands and search history
set history=10000
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set laststatus=2
set incsearch
set hlsearch

" Natural split changes
set splitbelow
set splitright

" make searches case-sensitive only if they contain upper-case characters
set ignorecase smartcase

set cmdheight=1
set switchbuf=useopen
set showtabline=1
set winwidth=79

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=750

" keep more context when scrolling off the end of a buffer
set scrolloff=3

" Don't make backups at all
set nobackup
set nowritebackup

set backspace=indent,eol,start

" display incomplete commands
set showcmd

" Enable highlighting for syntax
syntax on

" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on

" use emacs-style tab completion when selecting files, etc
set wildmode=longest,list,full

" make tab completion for files/buffers act like bash
set wildmenu

" Enable syntax folding
set foldmethod=manual
set nofoldenable

" Fix slow O inserts
set timeout timeoutlen=1000 ttimeoutlen=0

" Normally, Vim messes with iskeyword when you open a shell file. This can
" leak out, polluting other file types even after a 'set ft=' change. This
" variable prevents the iskeyword change so it can't hurt anyone.
let g:sh_noisk=1

" Modelines (comments that set vim options on a per-file basis)
set modeline
set modelines=3

" Insert only one space when joining lines that contain sentence-terminating
" punctuation like `.`.
set nojoinspaces

" If a file is changed outside of vim, automatically reload it without asking
set autoread

set noswapfile

set backupdir=$HOME/.config/nvim/backup
set directory=$HOME/.config/nvim/tmp

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Undo folder. undo changes after closing and opening files
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set undofile
set undodir=~/.config/nvim/undodir

" Turn off mouse
set mouse=

" Use the same symbols as TextMate for tabstops and EOLs
if &encoding == 'utf-8'
    set listchars=tab:▸\ ,eol:¬,trail:·
endif

if has('nvim')
  " Live substitute
  set inccommand=split
endif


" Highlight the cursor line
set cul

" set guicursor
set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20

" Toggle wrapping
if has('nvim') || has('termguicolors')
  set termguicolors
endif

set signcolumn=yes

set completeopt+=noselect
