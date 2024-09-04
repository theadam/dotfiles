return {
  {
    "https://github.com/stevearc/oil.nvim",
    opts = {},

    config = function()
      local oil = require("oil")
      oil.setup({
        view_options = {
          show_hidden = true,
        },
      })
      vim.keymap.set("n", "-", oil.open, { desc = "Open parent directory" })
    end,
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = { style = "storm" },
  },
  {
    "JoosepAlviste/palenightfall.nvim",
    config = function()
      require("palenightfall").setup({
        transparent = false,
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "palenightfall",
    },
  },
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        basedpyright = {
          settings = {
            python = {
              analysis = {
                reportAny = "none",
              },
            },
          },
        },
      },
    },
  },
  { "tpope/vim-surround" },
}
