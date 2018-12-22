autocmd!

let g:python_host_prog = $HOME . "/.pyenv/versions/neovim2/bin/python"
let g:python3_host_prog = $HOME . "/.pyenv/versions/neovim3/bin/python"

if has('nvim') || has('termguicolors')
  set termguicolors
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-plug
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')

" Plug 'w0rp/ale'

Plug 'neoclide/coc.nvim', {'do': 'yarn install'}
Plug 'Shougo/denite.nvim'
Plug 'itchyny/lightline.vim'

" Color scheme
Plug 'tyrannicaltoucan/vim-quantum'

Plug 'tpope/vim-abolish'
Plug 'editorconfig/editorconfig-vim'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'SirVer/ultisnips'

Plug 'justinmk/vim-dirvish'

" ruby
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-rails'

" JS
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'moll/vim-node'
Plug 'sheerun/vim-json'
Plug 'mvolkmann/vim-react'
Plug 'styled-components/vim-styled-components'

" TypeScript
Plug 'leafgarland/typescript-vim'
Plug 'ianks/vim-tsx'

" rust
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'

" HTML CSS
Plug 'othree/html5.vim'
Plug 'cakebaker/scss-syntax.vim'
Plug 'hail2u/vim-css3-syntax'

" Other Languages
Plug 'martin-svk/vim-yaml'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-git'
Plug 'keith/tmux.vim'
Plug 'honza/dockerfile.vim'

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Color
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme quantum
set background=dark

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC EDITING CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn on lin numbers
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
set splitbelow                              " Splitting a window will put the new window below the current
set splitright

" make searches case-sensitive only if they contain upper-case characters
set ignorecase smartcase

set cmdheight=1
set switchbuf=useopen
set showtabline=1
set winwidth=79

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

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

" Map leader to space
let mapleader = "\<Space>"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Undo folder. undo changes after closing and opening files
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set undofile
set undodir=~/.config/nvim/undodir

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" STATUS LINE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set statusline=[%02n]\ %f\ %(\[%M%R%H]%)%=\ %4l,%02c%2V\ %P%*

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC KEY MAPS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn off arrow movements
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Turn off mouse
set mouse=

" Clear search and redraw screen
nnoremap <C-L> :nohlsearch<CR><C-L>

" Show invisible characters
nmap <leader>i :set list!<CR>

" Remap number increment and decrement
nnoremap <leader>a <c-a>
nnoremap <leader>x <c-x>
vnoremap <leader>a <c-a>
vnoremap <leader>x <c-x>

" Use the same symbols as TextMate for tabstops and EOLs
if &encoding == 'utf-8'
    set listchars=tab:▸\ ,eol:¬,trail:·
endif

" Pretty print a json file
command! -nargs=0 Jqfile %!jq '.'

" Replace netrw with Dirvish
let loaded_netrwPlugin = 1
command! Explore :Dirvish %:p:h

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CUSTOM AUTOCMDS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" for ruby, autoindent with two spaces, always expand tabs
autocmd FileType ruby,haml,eruby,yaml,html,sass,scss,cucumber setlocal ai sw=2 sts=2 et

" make python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
autocmd FileType python setlocal sw=4 sts=4 et

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NEOVIM SETTINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has('nvim')
  " Live substitute
  set inccommand=split
endif


" Highlight the cursor line
set cul

" set guicursor
set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20

" Toggle wrapping
map <leader>w :set wrap!<cr>
