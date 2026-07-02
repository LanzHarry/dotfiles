-- import map helper function
local map = require("core.utils").map

vim.pack.add({ "https://github.com/stevearc/conform.nvim" })

require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "ruff_format" },
    markdown = { "rumdl" },
  },
  formatters = {
    rumdl = {
      command = "rumdl",
      args = { "fmt", "--silent", "-" },
      cwd = require("conform.util").root_file({ ".rumdl.toml", "rumdl.toml", ".git" }),
    },
  },
})

vim.api.nvim_create_user_command("FormatToggle", function()
  vim.b.disable_autoformat = not vim.b.disable_autoformat
  vim.notify("Autoformat on save: " .. (vim.b.disable_autoformat and "disabled" or "enabled"))
end, { desc = "Toggle autoformat on save for this buffer" })

map("n", "<leader>af", "<cmd>FormatToggle<CR>", "Toggle autoformat on save")

local augroup = vim.api.nvim_create_augroup
local format_group = augroup("FormatGroup", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
  group = format_group,
  callback = function(args)
    if vim.b.disable_autoformat or vim.bo[args.buf].buftype ~= "" then
      return
    end
    require("conform").format({
      bufnr = args.buf,
      timeout_ms = 500,
      lsp_format = "never",
    })
  end,
})
