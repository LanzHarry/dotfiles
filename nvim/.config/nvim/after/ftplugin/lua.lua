-- Neovim lua filetype settings
-- Controls editor typing behaviour, e.g. what is typed when tab is pressed
-- Settings for language in buffer are local and override defaults
-- Other source of formatting might come from .editorconfig or *.toml files
-- This does not control how formatters work (they will typically run on save for example whereas this affects live editing behaviour)
local set = vim.opt_local

set.expandtab = true -- insert spaces and not tab characters
set.shiftwidth = 2 -- indentation width used by >>, <<, =, and autoindent
set.tabstop = 2 -- how many cols a literal \t displays as
set.softtabstop = 2 -- how many spaces are inserted when tab or backspace are used in insert mode
