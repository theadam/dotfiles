require 'vimp'
vim.g.mapleader = ' '

-- Turn off arrow keys
vimp.rbind('nvo', '<up>', '<nop>')
vimp.rbind('nvo', '<down>', '<nop>')
vimp.rbind('nvo', '<left>', '<nop>')
vimp.rbind('nvo', '<right>', '<nop>')

vimp.nnoremap('<c-l>', [[:nohlsearch<cr><c-l>]])
vimp.nmap('<leader>i', [[:set list!<cr>]])

vimp.rbind('vn', '<leader>a', [[<c-a>]])
vimp.rbind('vn', '<leader>x', [[<c-x>]])

vimp.bind('nvo', '<leader>w', [[:set wrap!<cr>]])
vimp.nnoremap('<leader>vs', [[:e ~/.config/nvim/lua/<CR>]])
