nmap <Leader>p :Buffers<CR>
nmap <c-p> :Files<CR>

function! s:ag_in(...)
  let dir = fnamemodify(expand('%'), ':p:h')
  call fzf#vim#ag(join(a:000, ' '), {'dir': dir})
endfunction

command! -nargs=+ -complete=dir AgLocal call s:ag_in(<f-args>)

nnoremap \ :AgLocal<SPACE>
nnoremap <leader>\ :Ag<SPACE>
