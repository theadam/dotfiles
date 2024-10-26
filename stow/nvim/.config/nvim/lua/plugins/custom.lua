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
  { "EdenEast/nightfox.nvim" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "nightfox",
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
                diagnosticMode = "openFilesOnly",
                useLibraryCodeForTypes = false,
              },
            },
          },
        },
      },
    },
  },
  { "tpope/vim-surround" },
  {
    "nvim-telescope/telescope.nvim",
    -- change some options
    opts = {
      defaults = {
        get_selection_window = function()
          return vim.api.nvim_get_current_win()
        end,
      },
    },
  },
}
