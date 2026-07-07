-- strip any formatting capabilities from language servers
vim.lsp.config("*", {
  on_init = function(client)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
})

-- enable each lsp explicitly
vim.lsp.enable("basedpyright")
vim.lsp.enable("lua_ls")
vim.lsp.enable("ruff")
vim.lsp.enable("rumdl")
vim.lsp.enable("vtsls")

-- autocommands for lsp related features
local augroup = vim.api.nvim_create_augroup

local function map(mode, lhs, rhs, desc, opts)
  local options = vim.tbl_extend("force", { silent = true, desc = desc }, opts or {})
  vim.keymap.set(mode, lhs, rhs, options)
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup("DefaultLspAttach", { clear = true }),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client:supports_method("textDocument/documentHighlight", ev.buf) then
      local highlight_augroup = augroup("LspHighlightGroup", { clear = false })

      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = ev.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = ev.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })
    end

    if client and client:supports_method("textDocument/inlayHint", ev.buf) then
      -- inlay hints must be enabled in .luarc.json or other settings, can also be configured
      -- to show more or less detail such as types etc.
      vim.lsp.inlay_hint.enable(false, { bufnr = ev.buf })
      map("n", "<leader>th", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }))
      end, "Toggle inlay hints", { buffer = ev.buf })
    end
  end,
})

vim.api.nvim_create_autocmd("LspDetach", {
  group = augroup("DefaultLspDetach", { clear = true }),
  callback = function(ev)
    vim.lsp.buf.clear_references()
    vim.api.nvim_clear_autocmds({ group = "LspHighlightGroup", buffer = ev.buf })
  end,
})

-- could add a go to declaration for more c style workflows where there are headers?
-- vim.lsp.buf.declaration
