vim.g.loaded_netrwPlugin = 1
local cmd = vim.cmd
local home = vim.env.HOME

cmd 'colorscheme quantum'

vim.o.background = 'dark'

-- Turn on line numbers
vim.o.number = true
vim.o.compatible = false

-- This allows buffers to be hidden if you've modified a buffer.
-- This is almost a must if you wish to use buffers in this way.
vim.o.hidden = true

-- remember more commands and search history
vim.o.history = 10000
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.autoindent = true
vim.o.laststatus = 2
vim.o.incsearch = true
vim.o.hlsearch = true

-- Natural split changes
vim.o.splitbelow = true
vim.o.splitright = true

-- make searches case-sensitive only if they contain upper-case characters
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.cmdheight = 1
vim.o.switchbuf = 'useopen'
vim.o.showtabline = 1
vim.o.winwidth = 79

-- Smaller updatetime for CursorHold & CursorHoldI
vim.o.updatetime = 750

-- keep more context when scrolling off the end of a buffer
vim.o.scrolloff = 3

-- Don't make backups at all
vim.o.backup = false
vim.o.writebackup = false

vim.o.backspace = 'indent,eol,start'

-- display incomplete commands
vim.o.showcmd = true

-- Enable file type detection.
-- Use the default filetype settings, so that mail gets 'tw' vim.o.to 72,
-- 'cindent' is on in C files, etc.
-- Also load indent files, to automatically do language-dependent indenting.
cmd 'filetype plugin indent on'

-- use emacs-style tab completion when selecting files, etc
vim.o.wildmode = 'longest,list,full'

-- make tab completion for files/buffers act like bash
vim.o.wildmenu = true

-- Enable syntax folding
vim.o.foldmethod = 'manual'
vim.o.foldenable = false

-- Fix slow O inserts
vim.o.timeout = true
vim.o.timeoutlen = 1000
vim.o.ttimeoutlen = 0

-- Normally, Vim messes with iskeyword when you open a shell file. This can
-- leak out, polluting other file types even after a 'vim.o.ft = ' change. This
-- variable prevents the iskeyword change so it can't hurt anyone.
vim.g.sh_noisk = 1

-- Modelines (comments that vim.o.vim options on a per-file basis)
vim.o.modeline = true
vim.o.modelines = 3

-- Insert only one space when joining lines that contain sentence-terminating
-- punctuation like `.`.
vim.o.joinspaces = false

-- If a file is changed outside of vim, automatically reload it without asking
vim.o.autoread = true

vim.o.swapfile = false

vim.o.backupdir = home .. '/.config/nvim/backup'
vim.o.directory = home .. '/.config/nvim/tmp'

-------------------------------------------------------------------------------
-- Undo folder. undo changes after closing and opening files
-------------------------------------------------------------------------------
vim.o.undofile = true
vim.o.undodir = home .. '/.config/nvim/undodir'

-- Turn off mouse
vim.o.mouse = ''

-- Use the same symbols as TextMate for tabstops and EOLs
vim.o.listchars = 'tab:▸ ,eol:¬,trail:·'

-- Live substitute
vim.o.inccommand = 'split'

-- Highlight the cursor line
vim.o.cul = true

-- vim.o.guicursor
vim.o.guicursor = 'n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20'

vim.o.termguicolors = true

vim.o.signcolumn = 'yes'

vim.o.completeopt = 'menuone,noselect'

-- Enable highlighting for syntax
cmd 'syntax on'

vim.opt.shortmess:remove('F')
