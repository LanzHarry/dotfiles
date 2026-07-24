local map = require("core.utils").map

vim.pack.add({ "https://github.com/lukas-reineke/indent-blankline.nvim" })
vim.pack.add({ "https://github.com/shortcuts/no-neck-pain.nvim" })

require("ibl").setup({
  indent = { char = "▏" },
})

require("no-neck-pain").setup({
  width = 100,
})

map(
  "n",
  "<leader>z",
  "<cmd>NoNeckPain<CR>",
  "Centre buffer on screen by adding windows either side"
)

-- other misc plugins to consider:
-- Colourising plugins:
-- - mini: https://github.com/nvim-mini/mini.hipatterns
-- - colorizer: https://github.com/catgoose/nvim-colorizer.lua
-- - Native lsp colourisation
