let g:endwise_no_mappings = 1
imap <C-X><CR>   <CR><Plug>AlwaysEnd
imap <expr> <CR> (pumvisible() ? "\<C-Y>" : "\<CR>\<Plug>DiscretionaryEnd")
imap <expr> <C-N> (pumvisible() ? "\<C-N>" : coc#refresh())
imap <expr> <C-P> (pumvisible() ? "\<C-P>" : coc#refresh())
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup cocgroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  autocmd CursorHoldI * silent call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
vmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` for fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Shortcuts for denite interface
" Show extension list
nnoremap <silent> <leader>e  :<C-u>Denite coc-extension -winheight=7<cr>
" Show symbols of current buffer
nnoremap <silent> <leader>s  :<C-u>Denite coc-symbols -winheight=7<cr>
" Search symbols of current workspace
nnoremap <silent> <leader><s-s>  :<C-u>Denite coc-workspace -winheight=7<cr>
" Show diagnostics of current workspace
nnoremap <silent> <leader>d  :<C-u>Denite coc-diagnostic -winheight=7<cr>
nnoremap <silent> <leader>l  :lwindow 7<CR>
" Show available commands
nnoremap <silent> <space>c  :<C-u>Denite coc-command -winheight=7<cr>
