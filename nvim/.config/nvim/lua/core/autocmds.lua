local augroup = vim.api.nvim_create_augroup
local g_opts = { clear = true }

local filetype_config_group = augroup("FiletypeConfig", g_opts)
local ux_config_group = augroup("UXConfig", g_opts)

-- turn off auto comment insertion, can be modified per filetype
vim.api.nvim_create_autocmd("FileType", {
  desc = "Disable auto comment insertion",
  group = filetype_config_group,
  callback = function() vim.opt_local.formatoptions:remove { "c", "r", "o" } end,
})

-- highlight text when yanking
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  group = ux_config_group,
  callback = function() vim.highlight.on_yank() end,
})
