-- import keymap helper function
local map = require("core.utils").map

-- set leader keys and sanitisation mappings
map({ "n", "v" }, "<Space>", "<nop>")
map("n", "Q", "<nop>")

-- custom escape sequence using rare digram
map("i", "jk", "<Esc>", "Alternative to escape for leaving insert mode")
map("i", "kj", "<Esc>", "Alternative to escape for leaving insert mode")

-- save file
map("n", "<leader>w", "<cmd>update<CR>", "Save file")
map("n", "<leader>W", "<cmd>noautocmd update<CR>", "Save file no auto-format")

-- quit file
map("n", "<leader>q", "<cmd>q<CR>", "Quit file")
map("n", "<leader>Q", "<cmd>qa<CR>", "Quit all files and close editor")

-- default line extremity motions:
-- 0 goes to the start of the line including whitespace
-- ^ goes to the start of the line excluding whitespace
-- g_ goes to the end of the line including whitespace
-- $ goes to the end of the line excluding whitespace

-- page down and up with centering
map("n", "<C-d>", "<C-d>zz", "Page down and centre")
map("n", "<C-u>", "<C-u>zz", "Page up and centre")

-- find and centre while searching
map("n", "n", "nzzzv", "Find next and centre")
map("n", "N", "Nzzzv", "Find previous and centre")
map("n", "<leader>nh", "<cmd>nohlsearch<CR>", "Clear search highlights")

-- delete single character without copying into default register
map("n", "x", '"_x', "Delete char with no register copy")

-- keep last yank when pasting over
map("v", "<leader>p", '"_dP', "Paste but do not copy overwritten text to clipboard")

-- delete to void register
map("v", "<leader>d", '"_d', "Delete to void register")

-- stay in visual mode for indenting
map("v", "<", "<gv", "Stay in visual mode post un-indent")
map("v", ">", ">gv", "Stay in visual mode post indent")

-- line moving (slightly buggy at bof and eof but useable - maybe remap away from alt?)
map("x", "<M-j>", ":m '>+1<CR>gv=gv", "Move selection down")
map("x", "<M-k>", ":m '<-2<CR>gv=gv", "Move selection up")

-- append line with j but keep cursor in original position
map("n", "J", "mzJ`z", "Join lines but keep cursor in place")

-- find and replace mappings
map(
  "n",
  "<leader>rr",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/g<Left><Left>]],
  "Find and replace word under cursor",
  { silent = false }
)

-- toggle line wrapping
map("n", "<leader>lw", "<cmd>set wrap!<CR>", "Toggle line wrapping")

-- diagnostic keymaps
map("n", "[d", function()
  vim.diagnostic.jump({
    count = -1,
    float = true,
  })
end, "Go to previous diagnostic message and open floating window")

map("n", "]d", function()
  vim.diagnostic.jump({
    count = 1,
    float = true,
  })
end, "Go to next diagnostic message and open floating window")

map("n", "<leader>do", vim.diagnostic.open_float, "Open diagnostic float for current line")
map("n", "<leader>dl", vim.diagnostic.setloclist, "Open diagnostics in location list")

-- loclist keymaps
map("n", "<leader>lo", "<cmd>lopen<CR>", "Open location list")
map("n", "<leader>lx", "<cmd>lclose<CR>", "Close location list")
map("n", "]l", "<cmd>lnext<CR>", "Next loclist entry")
map("n", "[l", "<cmd>lprev<CR>", "Previous loclist entry")

-- quickfix keymaps
map("n", "<leader>co", "<cmd>copen<CR>", "Open quickfix list")
map("n", "<leader>cx", "<cmd>cclose<CR>", "Close quickfix list")
map("n", "]c", "<cmd>cnext<CR>", "Next quickfix entry")
map("n", "[c", "<cmd>cprev<CR>", "Previous quickfix entry")

-- resize splits with arrows
map("n", "<Up>", "<cmd>resize -2<CR>", "Decrease split height")
map("n", "<Down>", "<cmd>resize +2<CR>", "Increase split height")
map("n", "<Left>", "<cmd>vertical resize -2<CR>", "Decrease split width")
map("n", "<Right>", "<cmd>vertical resize +2<CR>", "Increase split width")

-- split management
map("n", "<leader>sv", "<C-w>v", "Create vertical split")
map("n", "<leader>sh", "<C-w>s", "Create horizontal split")
map("n", "<leader>se", "<C-w>=", "Make splits equal")
map("n", "<leader>sx", "<cmd>close<CR>", "Close split")
map("n", "<leader>sm", "<C-w>|<C-w>_", "Maximise current split")

-- split navigation
map("n", "<C-h>", "<C-w>h", "Navigate to split left")
map("n", "<C-j>", "<C-w>j", "Navigate to split below")
map("n", "<C-k>", "<C-w>k", "Navigate to split above")
map("n", "<C-l>", "<C-w>l", "Navigate to split right")

-- buffer navigation
map("n", "]b", "<cmd>bnext<CR>", "Go to next buffer")
map("n", "[b", "<cmd>bprevious<CR>", "Go to previous buffer")
-- map("n", "<leader>bx", function()
--   MiniBufremove.delete(0, false)
-- end, "Close current buffer") -- sane buffer deletion but relies on mini so don't define here
map("n", "<leader>bo", "<cmd>enew<CR>", "Open new buffer")
map("n", "<leader>bs", function()
  local ft = vim.bo.filetype
  if ft ~= "lua" and ft ~= "vim" then
    vim.notify("Not a Lua or Vimscript file: " .. ft, vim.log.levels.WARN)
    return
  end
  local ok, err = pcall(function()
    vim.cmd("source %")
  end)
  if ok then
    vim.notify("Sourced " .. vim.fn.expand("%:t"))
  else
    vim.notify(err or "Error sourcing file", vim.log.levels.ERROR)
  end
end, "Source current buffer")

-- tabs
map("n", "<leader>to", "<cmd>tabnew<CR>", "Open new tab")
map("n", "<leader>ts", "<cmd>tab split<CR>", "Open new tab by splitting current window")
map("n", "<leader>tx", "<cmd>tabclose<CR>", "Close tab")
map("n", "]t", "<cmd>tabn<CR>", "Next tab")
map("n", "[t", "<cmd>tabp<CR>", "Previous tab")

-- utility keymaps
local function exec_lua(input_code)
  local chunk, load_err = load(input_code)
  if chunk then
    local ok, result = pcall(chunk)
    if not ok then
      vim.notify(result or "Runtime error in selected code", vim.log.levels.ERROR)
    end
  else
    vim.notify(load_err or "Error loading selected code", vim.log.levels.ERROR)
  end
end

local function exec_current_line()
  exec_lua(vim.fn.getline("."))
end

local function exec_current_selection()
  local start_line, end_line = vim.fn.line("'<"), vim.fn.line("'>")
  local selected_lines = vim.fn.getline(start_line, end_line) --[[@as string[] ]]
  exec_lua(table.concat(selected_lines, "\n"))
end

map("n", "<leader>x", exec_current_line, "Execute current line")
map("v", "<leader>x", exec_current_selection, "Execute selected lines")
