autocmd!

let g:python_host_prog = $HOME . "/.pyenv/versions/neovim2/bin/python"
let g:python3_host_prog = $HOME . "/.pyenv/versions/neovim3/bin/python"

source $HOME/.config/nvim/config/plugins.vim
source $HOME/.config/nvim/config/settings.vim
source $HOME/.config/nvim/config/keys.vim
source $HOME/.config/nvim/config/autocmds.vim

for f in split(glob('~/.config/nvim/config/plugins/*.vim'), '\n')
  exec 'source ' . f
endfor
