return {
  {
    "nvim-mini/mini.nvim",
    version = false,
    lazy = false,
    priority = 900,
    config = function()
      require("mini.ai").setup() -- extend and enhance text object motions
      require("mini.bufremove").setup() -- sane buffer deletion
      require("mini.icons").setup() -- icon provider
      require("mini.statusline").setup({ use_icons = true }) -- simple status line
      require("mini.surround").setup() -- surround actions
    end,
  },
}
