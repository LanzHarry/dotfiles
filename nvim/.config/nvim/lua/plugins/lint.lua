vim.pack.add({ "https://github.com/mfussenegger/nvim-lint" })

local lint = require("lint")

lint.linters_by_ft = {
  -- python = { "ruff" }, -- running as LSP now instead
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  group = vim.api.nvim_create_augroup("lint", { clear = true }),
  callback = function()
    if vim.bo.modifiable and vim.bo.buftype == "" then
      lint.try_lint()
    end
  end,
})
