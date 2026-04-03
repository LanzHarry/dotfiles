return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  keys = {
    {
      "<leader>l",
      function()
        require("lint").try_lint()
      end,
      mode = "n",
      desc = "[L]int buffer",
    },
  },
  config = function()
    local lint = require("lint")
    local cppcheck = require("config.cppcheck_config")
    lint.linters_by_ft = {
      c = { "cppcheck" },
      cpp = { "cppcheck" },
      css = { "stylelint" }, -- might need .stylelintrc.json at project level
      dockerfile = { "hadolint" },
      html = { "htmlhint" },
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      -- python = { "ruff" },
    }

    lint.linters.cppcheck.args = cppcheck.args()

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
      group = lint_augroup,
      callback = function()
        if vim.bo.modifiable and vim.bo.buftype == "" then
          lint.try_lint()
        end
      end,
    })
  end,
}
