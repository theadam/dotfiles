vim.g.lightline = {
  colorscheme = 'quantum',
  active = {
    left = { {'mode', 'paste'},
             {'gitbranch', 'readonly', 'filename'} },
  },
  component_function = {
    filename = 'LightlineFilename',
    gitbranch = 'fugitive#head'
  }
}

vim.api.nvim_exec(
[[
function! LightlineFilename()
  let filename = expand('%:p') !=# '' ? fnamemodify(expand('%:p'), ':.')  : '[No Name]'
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

if exists("*lightline#init")
  call lightline#init()
  call lightline#colorscheme()
  call lightline#update()
endif
]],
false)
