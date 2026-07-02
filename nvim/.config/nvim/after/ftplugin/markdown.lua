-- settings for markdown .md files
local set = vim.opt_local

set.spell = true
set.spelllang = "en_gb"
set.formatoptions:append("n") -- recognise numbered/bulleted lists when wrapping
