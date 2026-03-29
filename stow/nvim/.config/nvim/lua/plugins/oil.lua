return {
  -- Disable snacks explorer
  {
    "folke/snacks.nvim",
    opts = {
      explorer = { enabled = false },
    },
  },

  -- Add oil.nvim as file explorer
  {
    "stevearc/oil.nvim",
    dependencies = { "echasnovski/mini.icons" },
    lazy = false,
    keys = {
      { "<leader>e", function() require("oil").open() end, desc = "Open file explorer (Oil)" },
      { "-", function() require("oil").open() end, desc = "Open parent directory" },
    },
    opts = {
      default_file_explorer = true,
      view_options = {
        show_hidden = true,
      },
    },
  },
}
