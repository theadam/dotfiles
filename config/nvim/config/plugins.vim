if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')

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
