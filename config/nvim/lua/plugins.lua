local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

return require('packer').startup(function()
  use_rocks 'penlight'

  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Core
  use {'cohama/lexima.vim', config = function() require('plugins.lexima') end}
  use {'itchyny/lightline.vim', config = function() require('plugins.statusline') end}
  use {'neovim/nvim-lspconfig', config = function() require('plugins.lsp') end}
  use {'hrsh7th/nvim-compe', config = function() require('plugins.compe') end}
  use {
    'nvim-telescope/telescope.nvim',
    config = function() require('plugins.telescope') end
  }
  use 'nvim-lua/popup.nvim'
  use {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require 'colorizer'.setup()
    end
  }
  --use {
  --  'nvim-treesitter/nvim-treesitter',
  --  run = ':TSUpdate',
  --  config = function()
  --    require 'plugins.treesitter'
  --  end
  --}


  -- Lua helpers
  use 'nvim-lua/plenary.nvim'
  use 'svermeulen/vimpeccable'

  -- Color scheme
  use 'tyrannicaltoucan/vim-quantum'

  -- Utilities
  use 'tpope/vim-abolish'
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'tpope/vim-fugitive'
  use {'justinmk/vim-dirvish', config = function() require('plugins.dirvish') end}

  -- JS
  use 'pangloss/vim-javascript'
  use 'mxw/vim-jsx'

  -- TypeScript
  use 'leafgarland/typescript-vim'
  use 'ianks/vim-tsx'

  -- Other Languages
  use 'elixir-editors/vim-elixir'
  use 'udalov/kotlin-vim'
  use 'derekwyatt/vim-scala'
  use 'scalameta/nvim-metals'
  use 'pantharshit00/vim-prisma'
end)
