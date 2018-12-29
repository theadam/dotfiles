" Map leader to space
let mapleader = "\<Space>"

" Turn off arrow movements
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Clear search and redraw screen
nnoremap <C-L> :nohlsearch<CR><C-L>

" Show invisible characters
nmap <leader>i :set list!<CR>

" Remap number increment and decrement
nnoremap <leader>a <c-a>
nnoremap <leader>x <c-x>
vnoremap <leader>a <c-a>
vnoremap <leader>x <c-x>

" Toggle wrapping
map <leader>w :set wrap!<cr>

" show location window
nnoremap <silent> <leader>l  :lwindow 7<CR>
