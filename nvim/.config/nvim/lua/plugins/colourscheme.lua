vim.pack.add({ "https://github.com/folke/tokyonight.nvim" })

require("tokyonight").setup({
  styles = {
    comments = { italic = false },
  },
  on_highlights = function(highlights, colours)
    highlights.LineNr = { fg = colours.magenta2 }
    highlights.LineNrAbove = { fg = colours.magenta2 }
    highlights.LineNrBelow = { fg = colours.magenta2 }
  end,
})

vim.cmd.colorscheme("tokyonight-night")
