local map = require("core.utils").map

vim.pack.add({ "https://github.com/stevearc/oil.nvim" })

require("oil").setup()

map("n", "-", "<cmd>Oil<CR>", "Open oil file explorer")
