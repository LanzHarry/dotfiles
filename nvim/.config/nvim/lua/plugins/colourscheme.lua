vim.pack.add({
  "https://github.com/folke/tokyonight.nvim",
  "https://github.com/sainnhe/gruvbox-material",
})

-- tokyonight

-- require("tokyonight").setup({
--   styles = {
--     comments = { italic = true },
--   },
--   on_highlights = function(highlights, colours)
--     highlights.LineNr = { fg = colours.magenta2 }
--     highlights.LineNrAbove = { fg = colours.magenta2 }
--     highlights.LineNrBelow = { fg = colours.magenta2 }
--   end,
-- })
--
-- vim.cmd.colorscheme("tokyonight-night")

-- gruvbox

vim.opt.background = "dark" -- dark and light
vim.g.gruvbox_material_background = "medium" -- hard, medium, soft, default medium
vim.g.gruvbox_material_foreground = "material" -- material, mix, original, default material
vim.g.gruvbox_enable_italic = 1 -- enable italic but seems to be for fonts with cursive italics?

vim.cmd.colorscheme("gruvbox-material")
