return {
  cmd = { "vtsls", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  root_markers = {
    { "package-lock.json", "yarn.lock", "pnpm-lock.yaml" },
    ".git",
  },
  capabilities = {
    documentFormattingProvider = false,
    documentRangeFormattingProvider = false,
  },
}
