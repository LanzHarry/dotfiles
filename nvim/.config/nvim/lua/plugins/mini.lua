-- helper function for keymaps
local map = require("core.utils").map

vim.pack.add({ "https://github.com/nvim-mini/mini.nvim" })

local mini_icons = require("mini.icons")
mini_icons.setup()
mini_icons.mock_nvim_web_devicons()

local mini_bufremove = require("mini.bufremove")
mini_bufremove.setup()
map("n", "<leader>bx", function()
  mini_bufremove.delete(0, false)
end, "Close buffer")

local mini_statusline = require("mini.statusline")
mini_statusline.setup({
  use_icons = true,
})

mini_statusline.section_filename = function()
  local filename = vim.fn.expand("%:t")
  if filename == "" then
    return "[No Name]"
  end
  return filename
end

local mini_ai = require("mini.ai")
mini_ai.setup()

local mini_pairs = require("mini.pairs")
mini_pairs.setup()

local mini_surround = require("mini.surround")
mini_surround.setup()
