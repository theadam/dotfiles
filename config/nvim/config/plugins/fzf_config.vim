function! s:ag_in(...)
  let dir = fnamemodify(expand('%'), ':p:h')
  call fzf#vim#ag(join(a:000, ' '), {'dir': dir})
endfunction

command! -nargs=+ -complete=dir AgLocal call s:ag_in(<f-args>)

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }


augroup fzfgroup
  autocmd!
  autocmd! FileType fzf
  autocmd  FileType fzf set laststatus=0
    \| autocmd BufLeave <buffer> set laststatus=2
augroup END

nmap <Leader>p :Buffers<CR>
nmap <c-p> :Files<CR>
nnoremap \ :AgLocal<SPACE>
nnoremap <leader>\ :Ag<SPACE>
tnoremap <expr> <esc> &filetype == 'fzf' ? "\<esc>" : "\<c-\>\<c-n>"

