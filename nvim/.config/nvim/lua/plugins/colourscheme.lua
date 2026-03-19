return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,

  config = function()
    require("catppuccin").setup {
      custom_highlights = function()
        return {
          LineNr = { fg = "#FF00C3" },
        }
      end,
    }
    vim.cmd.colorscheme("catppuccin-mocha")
  end,
}
