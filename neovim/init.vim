autocmd!
let g:python3_host_prog = '/usr/local/bin/python3'

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

if has('nvim')
  " Plug 'autozimu/LanguageClient-neovim', {
  "   \ 'branch': 'next',
  "   \ 'do': 'bash install.sh',
  "   \ }
  Plug 'roxma/python-support.nvim'
endif

Plug 'vimwiki/vimwiki'
Plug 'tpope/vim-abolish'
Plug 'mhinz/vim-grepper'

Plug 'editorconfig/editorconfig-vim'
Plug 'freeo/vim-kalisi'
Plug 'sjl/badwolf'
Plug 'morhetz/gruvbox'
Plug 'romainl/Apprentice'
Plug 'arcticicestudio/nord-vim'
Plug 'blueshirts/darcula'
Plug 'trevordmiller/nova-vim'
Plug 'challenger-deep-theme/vim'
Plug 'joshdick/onedark.vim'
Plug 'tyrannicaltoucan/vim-quantum'

" Plug 'ctrlpvim/ctrlp.vim'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'SirVer/ultisnips'

if has('nvim')
  " Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'roxma/nvim-completion-manager'
  Plug 'roxma/ncm-flow'
else
  Plug 'maralla/completor.vim'
endif

Plug 'w0rp/ale'
Plug 'justinmk/vim-dirvish'
Plug 'tpope/vim-eunuch'

" ruby
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-haml'

" JS
Plug 'pangloss/vim-javascript'
Plug 'moll/vim-node'
Plug 'mxw/vim-jsx'
Plug 'leafgarland/typescript-vim'
Plug 'sheerun/vim-json'
Plug 'mvolkmann/vim-react'
Plug 'flowtype/vim-flow'
Plug 'styled-components/vim-styled-components'
" Plug 'theadam/vim-enhanced-resolver', { 'do': 'npm install' }

" HTML CSS
Plug 'othree/html5.vim'
Plug 'cakebaker/scss-syntax.vim'
Plug 'lilydjwg/colorizer', { 'for': ['css', 'sass', 'scss', 'less', 'html', 'xdefaults', 'javascript', 'javascript.jsx', 'conf'] }
Plug 'hail2u/vim-css3-syntax'

" OCAML / REASON
if has('nvim')
  Plug 'reasonml-editor/vim-reason'
  " Plug 'reasonml-editor/vim-reason-plus'
endif

" Purescript
Plug 'raichoo/purescript-vim'
" Plug 'FrigoEU/psc-ide-vim'
Plug 'coot/psc-ide-vim', { 'branch': 'sync-purescript-0.11' }

" Other Languages
Plug 'elixir-lang/vim-elixir'
Plug 'ElmCast/elm-vim'
Plug 'martin-svk/vim-yaml'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-git'
Plug 'keith/tmux.vim'
Plug 'honza/dockerfile.vim'
Plug 'JamshedVesuna/vim-markdown-preview'

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Color
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme quantum
set background=dark

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC EDITING CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

" keep more context when scrolling off the end of a buffer
set scrolloff=3

" Don't make backups at all
set nobackup
set nowritebackup

set backspace=indent,eol,start

" display incomplete commands
set showcmd

if has('nvim')
  " Live substitute
  set inccommand=split
endif

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

" Fix slow O inserts
set timeout timeoutlen=1000 ttimeoutlen=0

" Normally, Vim messes with iskeyword when you open a shell file. This can
" leak out, polluting other file types even after a 'set ft=' change. This
" variable prevents the iskeyword change so it can't hurt anyone.
let g:sh_noisk=1

" Modelines (comments that set vim options on a per-file basis)
set modeline
set modelines=3

" Turn folding off for real, hopefully
set foldmethod=manual
set nofoldenable

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
set statusline=[%02n]\ %f\ %(\[%M%R%H]%)%=\ %{ALEGetStatusLine()}\ %4l,%02c%2V\ %P%*

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CUSTOM AUTOCMDS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" for ruby, autoindent with two spaces, always expand tabs
autocmd FileType ruby,haml,eruby,yaml,html,javascript,javascript.jsx,sass,scss,cucumber set ai sw=2 sts=2 et

" make python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
autocmd FileType python set sw=4 sts=4 et

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NEOVIM SETTINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1         " Set an environment variable to use the t_SI/t_EI hack
let loaded_netrwPlugin = 1
command! Explore :Dirvish %:p:h

set cul

