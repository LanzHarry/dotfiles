return {
  cmd = { "ruff", "server" },
  filetypes = { "python" },
  root_markers = {
    {
      "Pipfile",
      "pyproject.toml",
      "pyrightconfig.json",
      "requirements.txt",
      "setup.cfg",
      "setup.py",
      "ruff.toml",
      ".ruff.toml",
    },
    ".git",
  },
}
