vim.pack.add({ "https://github.com/lukas-reineke/indent-blankline.nvim" })

require("ibl").setup({
  indent = { char = "▏" },
})

-- other misc plugins to consider:
-- Colourising plugins:
-- - mini: https://github.com/nvim-mini/mini.hipatterns
-- - colorizer: https://github.com/catgoose/nvim-colorizer.lua
-- - Native lsp colourisation
