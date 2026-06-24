-- helper function for keymaps
local map = require("core.utils").map

-- add telescope and its deps
vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-telescope/telescope.nvim",
  "https://github.com/nvim-telescope/telescope-ui-select.nvim",
  "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
})

-- dirs that should always be ignored
local ignore_dirs = {
  ".git",
  "node_modules",
  "__pycache__",
  ".venv",
  "venv",
  "dist",
  "build",
}

local ignore_files = {}

local function fd_excludes(dirs, files)
  local args = {}
  for _, pattern in ipairs(vim.iter({ dirs, files }):flatten():totable()) do
    table.insert(args, "--exclude")
    table.insert(args, pattern)
  end
  return args
end

local function rg_excludes(dirs, files)
  local args = {}
  for _, pattern in ipairs(vim.iter({ dirs, files }):flatten():totable()) do
    table.insert(args, "--glob")
    table.insert(args, "!" .. pattern)
  end
  return args
end

require("telescope").setup({
  defaults = {
    vimgrep_arguments = vim
      .iter({
        {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
        },
        rg_excludes(ignore_dirs, ignore_files),
      })
      :flatten()
      :totable(),
  },
  extensions = {
    ["ui-select"] = { require("telescope.themes").get_dropdown({}) },
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  },
  pickers = {
    find_files = {
      find_command = vim
        .iter({
          { "fd", "--type", "f", "--hidden" },
          fd_excludes(ignore_dirs, ignore_files),
        })
        :flatten()
        :totable(),
    },
  },
})

-- load extensions so they are active within telescope
-- use pcall to safely load them
if not pcall(require("telescope").load_extension, "ui-select") then
  vim.notify("Failed to load ui-select", vim.log.levels.ERROR)
end

if not pcall(require("telescope").load_extension, "fzf") then
  vim.notify("Failed to load fzf-native", vim.log.levels.ERROR)
end

-- custom telescope picker keymaps
local builtin = require("telescope.builtin")

map("n", "<leader>fh", builtin.help_tags, "Find help tags")
map("n", "<leader>fk", builtin.keymaps, "Find keymaps")
map("n", "<leader>ff", builtin.find_files, "Find files")
map("n", "<leader>ft", builtin.builtin, "Find telescope builtins")
map({ "n", "v" }, "<leader>fw", builtin.grep_string, "Find word")
map("n", "<leader>fg", builtin.live_grep, "Find with grep")
map("n", "<leader>fd", builtin.diagnostics, "Find diagnostics")
map("n", "<leader>fr", builtin.resume, "Resume find")
map("n", "<leader>f.", builtin.oldfiles, "Find recent files")
map("n", "<leader>fc", builtin.commands, "Find commands")
map("n", "<leader><leader>", builtin.buffers, "Find open buffers")
map("n", "<leader>/", builtin.current_buffer_fuzzy_find, "Find in current buffer")

-- grep in open files only
map("n", "<leader>s/", function()
  builtin.live_grep({ grep_open_files = true, prompt_title = "Find in open files" })
end, "Find in open files")

-- find neovim files to edit config
map("n", "<leader>fn", function()
  builtin.find_files({ cwd = vim.fn.stdpath("config"), follow = true })
end, "Find NeoVim config files")

-- lsp and telescope crossover keymaps
-- telescope has many functions that supersede the built in nvim functions,
-- for example there are global lsp functions built in to nvim from :h lsp-defaults:
--
-- "gra" (Normal and Visual mode) is mapped to |vim.lsp.buf.code_action()|
-- "gri" is mapped to |vim.lsp.buf.implementation()|
-- "grn" is mapped to |vim.lsp.buf.rename()|
-- "grr" is mapped to |vim.lsp.buf.references()|
-- "grt" is mapped to |vim.lsp.buf.type_definition()|
-- "grx" is mapped to |vim.lsp.codelens.run()|
-- "gO" is mapped to |vim.lsp.buf.document_symbol()|
-- CTRL-S (Insert mode) is mapped to |vim.lsp.buf.signature_help()|
-- |v_an| and |v_in| fall back to LSP |vim.lsp.buf.selection_range()| if
--   treesitter is not active.
-- |gx| handles `textDocument/documentLink`. Example: with gopls, invoking gx
--   on "os" in this Go code will open documentation externally: >
--     package nvim
--     import (
--        "os"
--     )
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("TelescopeLspAttach", { clear = true }),
  callback = function(ev)
    local buf = ev.buf

    map("n", "g0", builtin.lsp_document_symbols, "Open document symbols", { buffer = buf })
    map("n", "grd", builtin.lsp_definitions, "Go to definition", { buffer = buf })
    map("n", "gri", builtin.lsp_implementations, "Go to implementation", { buffer = buf })
    map("n", "grr", builtin.lsp_references, "Go to references", { buffer = buf })
    map("n", "grt", builtin.lsp_type_definitions, "Go to type definition", { buffer = buf })
    map(
      "n",
      "gW",
      builtin.lsp_dynamic_workspace_symbols,
      "Open workspace symbols",
      { buffer = buf }
    )
  end,
})

-- TODO:
-- add git pickers: git_files, git_status, git_branches, git_commits or bcommits
-- add more lsp pickers: incoming_calls, outgoing_calls, definitions jump type never?
-- treesitter: list symbols with treesitter?
