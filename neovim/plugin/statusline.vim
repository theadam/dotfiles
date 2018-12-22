function! CocStatus()
  let info = get(b:, 'coc_diagnostic_info', {})
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, '%#SLError#✗' . info['error'] . '%*')
  endif
  if get(info, 'warning', 0)
    call add(msgs, '%#SLWarning#⚠' . info['warning'] . '%*')
  endif
  if get(g:, 'coc_status', '') != ''
    call add(msgs, g:coc_status)
  endif
  return join(msgs, ' ')
endfunction

function! LightlineFilename()
  let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  let modified = &modified ? ' +' : ''
  return filename . modified
endfunction

function! ReturnHighlightTerm(group, term)
   " Store output of group to variable
   let output = execute('hi ' . a:group)
   " Find the term we're looking for
   return substitute(matchstr(output, a:term.'=\zs\S*'), '\n*$', '', '')
endfunction

execute('highlight SLError   gui=NONE guifg=#dd7186 guibg=' . ReturnHighlightTerm('StatusLine', 'guibg'))
execute('highlight SLWarning   gui=NONE guifg=#d5b875 guibg=' . ReturnHighlightTerm('StatusLine', 'guibg'))

set noshowmode
set noruler
let g:lightline = {
      \ 'colorscheme': 'quantum',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'cocstatus'] ]
      \ },
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \   'gitbranch': 'fugitive#head'
      \ },
      \ 'component_expand': {
      \   'cocstatus': 'CocStatus',
      \ },
      \ }

	call denite#custom#map(
	      \ 'insert',
	      \ '<Down>',
	      \ '<denite:move_to_next_line>',
	      \ 'noremap'
	      \)
	call denite#custom#map(
	      \ 'insert',
	      \ '<Up>',
	      \ '<denite:move_to_previous_line>',
	      \ 'noremap'
	      \)

autocmd User CocDiagnosticChange call lightline#update()
