vim.pack.add({ "https://github.com/nvim-mini/mini.nvim" })

local mini_icons = require("mini.icons")
mini_icons.setup()
mini_icons.mock_nvim_web_devicons()

-- return {
--   {
--     "nvim-mini/mini.nvim",
--     version = false,
--     lazy = false,
--     priority = 900,
--     config = function()
--       require("mini.ai").setup() -- extend and enhance text object motions
--       require("mini.bufremove").setup() -- sane buffer deletion
--       require("mini.icons").setup() -- icon provider
--       require("mini.statusline").setup({ use_icons = true }) -- simple status line
--       require("mini.surround").setup() -- surround actions
--     end,
--   },
-- }
