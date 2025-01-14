-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<leader>\\", function(...)
  LazyVim.pick("live_grep", { cwd = vim.fn.expand("%:p:h"):gsub("oil://", ""), root = false })(...)
end, { desc = "Grep (Relative)" })
