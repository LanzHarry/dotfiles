return {
  -- command and arguments to start the server
  cmd = { "lua-language-server" },

  -- filetypes for server to attach to
  filetypes = { "lua" },

  -- detection of root directory for a project
  -- files that share a root directory will share a connection to the LSP server
  -- nested tables indicate equal priority
  root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },

  -- disable formatting capabilities of language server in favour of actual
  -- formatter such as stylua
  capabilities = {
    documentFormattingProvider = false,
    documentRangeFormattingProvider = false,
  },
}
