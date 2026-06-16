vim.pack.add({
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    name = "nvim-treesitter",
    version = "main",
  },
})

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

-- no setup call needed to run treesitter with default values

-- return {
--   "nvim-treesitter/nvim-treesitter",
--   event = { "BufReadPre", "BufNewFile" },
--   build = ":TSUpdate",
--   opts = {
--     ensure_installed = {
--       "bash",
--       "c",
--       "lua",
--       "python",
--       "vim",
--       "vimdoc",
--       "query",
--       "markdown",
--       "markdown_inline",
--     },
--     auto_install = true,
--     prefer_git = true,
--     highlight = {
--       enable = true,
--       -- Disable for large files (performance safeguard)
--       disable = function(_, buf)
--         local max_filesize = 200 * 1024 -- 200 KB
--         local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
--         return ok and stats and stats.size > max_filesize
--       end,
--       additional_vim_regex_highlighting = false,
--     },
--     textobjects = {
--       select = {
--         enable = false,
--       },
--     },
--     indent = { enable = true },
--   },
-- }
