vim.pack.add({
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    name = "nvim-treesitter",
    version = "main",
  },
})
-- nvim-treesitter-textobjects can extend nvim-treesitter to add smarter
-- movements, selecitons, and node swapping. Incremental selection is built in
-- to neovim 0.12 in visual mode, mini.ai is also treesitter aware and can help
-- with smarter selections too.

-- ensure basic parsers are installed
local parsers = {
  "bash",
  "c",
  "diff",
  "html",
  "lua",
  "luadoc",
  "markdown",
  "markdown_inline",
  "query",
  "vim",
  "vimdoc",
}
require("nvim-treesitter").install(parsers)

-- attach treesitter and parsers to appropriate file types
---@param buf integer
---@param language string
local function treesitter_try_attach(buf, language)
  -- check if language parser exists and load it, return guards if not
  if not vim.treesitter.language.add(language) then
    return
  end
  -- enable treesitter with default settings if guard passed
  vim.treesitter.start(buf, language)

  -- folds can be enabled here too
  -- vim.wo.foldexpr and foldmethod

  -- so can indents
  -- check if indent query exists and then set indentexpr
end

local available_parsers = require("nvim-treesitter").get_available()

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("TreeSitterAttachGroup", { clear = true }),
  callback = function(ev)
    local buf, filetype = ev.buf, ev.match

    -- don't run treesitter for very large files
    local max_file_size = 200 * 1024 -- 200 KB
    local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
    if ok and stats and stats.size > max_file_size then
      return
    end

    local language = vim.treesitter.language.get_lang(filetype)
    if not language then
      return
    end

    local installed_parsers = require("nvim-treesitter").get_installed("parsers")

    if vim.tbl_contains(installed_parsers, language) then
      -- enable parser if it is already installed
      treesitter_try_attach(buf, language)
    elseif vim.tbl_contains(available_parsers, language) then
      -- if a parser is available in nvim-treesitter then auto install it
      require("nvim-treesitter").install(language):await(function()
        treesitter_try_attach(buf, language)
      end)
    else
      -- try to enable treesitter anyway in case the parser exists outside of nvim-treesitter
      treesitter_try_attach(buf, language)
    end
  end,
})
