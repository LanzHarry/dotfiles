return {
  cmd = { "basedpyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = {
    {
      "Pipfile",
      "pyproject.toml",
      "pyrightconfig.json",
      "requirements.txt",
      "setup.cfg",
      "setup.py",
    },
    ".git",
  },
  settings = {
    basedpyright = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "openFilesOnly",
      },
    },
  },
  capabilities = {
    general = { positionEncodings = { "utf-16" } },
  },
}
