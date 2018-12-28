" If not running in TMUX
if !exists('$TMUX')
  augroup tabsgroup
    autocmd BufEnter term://* startinsert
  augroup END

  let s:leader = '<C-a>'
  let s:mappings = ['nnoremap', 'inoremap', 'tnoremap']
  function s:MakeLeaderMapping(binding, result)
    for mapping in s:mappings
      execute mapping . ' ' . s:leader . a:binding . ' ' . a:result
    endfor
  endfunction

  " Closes the terminal immediately
  tnoremap <C-d> <Cmd>q<CR>
  call s:MakeLeaderMapping('c', '<Cmd>$tabnew<CR><Cmd>terminal<CR><Cmd>startinsert<CR>')
  call s:MakeLeaderMapping('p', '<c-\><c-n><esc>:tabprev<CR>')
  call s:MakeLeaderMapping('n', '<c-\><c-n><esc>:tabnext<CR>')
  call s:MakeLeaderMapping('\|', '<Cmd>vsp<CR><Cmd>term<CR>i')
  call s:MakeLeaderMapping('-', '<Cmd>sp<CR><Cmd>term<CR>i')
  for i in range(10)
    call s:MakeLeaderMapping(i, '<Cmd>tabn ' . (i + 1) . '<CR>')
  endfor

  set tabline=%!MyTabLine()

	function MyTabLine()
	  let s = ''
	  for i in range(tabpagenr('$'))
	    " select the highlighting
	    if i + 1 == tabpagenr()
	      let s .= '%#TabLineSel#'
	    else
	      let s .= '%#TabLine#'
	    endif

	    " set the tab page number (for mouse clicks)
	    let s .= '%' . (i + 1) . 'T'

	    " the label is made by MyTabLabel()
	    let s .= ' ' . i . ': %{MyTabLabel(' . (i + 1) . ')} '
	  endfor

	  " after the last tab fill with TabLineFill and reset tab page nr
	  let s .= '%#TabLineFill#%T'

	  " right-align the label to close the current tab page
	  if tabpagenr('$') > 1
	    let s .= '%=%#TabLine#%999Xclose'
	  endif

	  return s
  endfunction

  function MyTabLabel(n)
    let buflist = tabpagebuflist(a:n)
    let winnr = tabpagewinnr(a:n)
    return fnamemodify(bufname(buflist[winnr - 1]), ':t')
  endfunction

  tnoremap <C-w>h <C-\><C-n><C-w>h
  tnoremap <C-w>j <C-\><C-n><C-w>j
  tnoremap <C-w>k <C-\><C-n><C-w>k
  tnoremap <C-w>l <C-\><C-n><C-w>l
endif
