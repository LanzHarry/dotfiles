vim.pack.add({ "https://github.com/stevearc/conform.nvim" })

require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
  },
})

local augroup = vim.api.nvim_create_augroup
local format_group = augroup("FormatGroup", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
  group = format_group,
  callback = function(args)
    require("conform").format({
      bufnr = args.buf,
      timeout_ms = 500,
      lsp_format = "never",
    })
  end,
})

-- -- filetypes to disable formatting for
-- local disable_filetypes = {}
--
-- return {
--   "stevearc/conform.nvim",
--   event = { "BufReadPre", "BufNewFile" },
--   opts = {
--     notify_on_error = false,
--     formatters_by_ft = {
--       c = { "clang_format" },
--       cpp = { "clang_format" },
--       css = { "prettierd" },
--       h = { "clang_format" },
--       html = { "prettierd" },
--       javascript = { "prettierd" },
--       json = { "prettierd" },
--       lua = { "stylua" },
--       python = { "ruff_format" },
--       sql = { "sql_formatter" },
--       typescript = { "prettierd" },
--       typescriptreact = { "prettierd" },
--       yaml = { "prettierd" },
--     },
--     format_on_save = function(bufnr)
--       if disable_filetypes[vim.bo[bufnr].filetype] then
--         return nil
--       else
--         return {
--           timeout_ms = 2000,
--           lsp_format = "never",
--         }
--       end
--     end,
--   },
--   keys = {
--     {
--       "<leader>f",
--       function()
--         require("conform").format({
--           async = true,
--           lsp_format = "never",
--           timeout_ms = 2000,
--         })
--       end,
--       mode = { "n", "v" },
--       desc = "[F]ormat buffer",
--     },
--   },
-- }
