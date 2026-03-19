return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "bash",
      "c",
      "lua",
      "python",
      "vim",
      "vimdoc",
      "query",
      "markdown",
      "markdown_inline",
    },
    auto_install = true,
    prefer_git = true,
    highlight = {
      enable = true,
      -- Disable for large files (performance safeguard)
      disable = function(_, buf)
        local max_filesize = 200 * 1024 -- 200 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        return ok and stats and stats.size > max_filesize
      end,
      additional_vim_regex_highlighting = false,
    },
    textobjects = {
      select = {
        enable = false,
      },
    },
    indent = { enable = true },
  },
}
