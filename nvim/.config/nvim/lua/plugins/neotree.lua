return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = { "Neotree" }, -- load when neotree command is run
    keys = { -- load only when specific keypresses happen
      { "<leader>e", "<cmd>Neotree toggle<cr>", mode = "n", desc = "Toggle neotree" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },
  },
}
