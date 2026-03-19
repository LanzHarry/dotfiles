-- visual options
vim.opt.number = true -- make line numbers visible
vim.opt.relativenumber = true -- set line numbers to be relative to current line
vim.opt.colorcolumn = "80,100" -- column to show where 80 character limit is
vim.opt.cursorline = true -- highlight line the cursor is on
vim.opt.hlsearch = false -- show search results as highlighted
vim.opt.showmode = false -- show what interaction mode vim is in (set to false if statusline plugin installed)
vim.opt.ruler = false -- disable line and col number as statusline will show this
vim.opt.laststatus = 3 -- show statusline globally rather than per window
vim.opt.numberwidth = 4 -- width of number column
vim.opt.showtabline = 1 -- 0 never show, 1 show when multiple tabs, 2 always show
vim.opt.signcolumn = "yes:1" -- keep sign column
vim.opt.conceallevel = 0 -- make markdown text symbols visible
vim.opt.cmdheight = 1 -- height of command line in editor
vim.opt.pumheight = 10 -- set popup menu height
vim.opt.pumblend = 0 -- no transparancy for popup menus
vim.opt.winblend = 0 -- no transparency for floating windows
vim.opt.completeopt = "menuone,noselect" -- show completion even for one item, don't auto insert
vim.opt.shortmess:append("c") -- suppress completion messages for quieter UI
vim.opt.list = true -- visualise whitespace
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.winborder = "rounded"

-- text editing behavioural options
vim.opt.wrap = false -- prevent line wrapping
vim.opt.autoindent = true -- indent new line same as current line
vim.opt.smartindent = false -- inbuilt smart indent control
vim.opt.breakindent = true -- wrapped lines will match indent of original line
vim.opt.linebreak = false -- soft linewrapping (only relevant when wrap is true)
vim.opt.shiftwidth = 4 -- number of spaces for an indentation
vim.opt.tabstop = 4 -- number of spaces for a tab
vim.opt.softtabstop = 4 -- number of spaces a tab counts for whilst editing
vim.opt.expandtab = true -- turn tab into spaces
vim.opt.smarttab = true -- tab line at start uses shiftwidth to correctly indent
vim.opt.shiftround = true -- restrict to multiples of shiftwidth
vim.opt.whichwrap = "bs<>[]hl" -- which cursor keys can move cursor across lines at start/end
vim.opt.backspace = "indent,eol,start" -- allow backspace for indents and start/end of lines

-- interaction behavioural settings
vim.opt.mouse = "a" -- enable mouse mode in all modes
vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end) -- sync clipboard between OS clipboard and neovim registers
vim.opt.ignorecase = true -- ignore case in search unless \C or capital in search
vim.opt.smartcase = true -- paired with ignorecase to give correct functionality as described above
vim.opt.scrolloff = 8 -- keep this many lines above and below cursor vertically
vim.opt.sidescrolloff = 8 -- keep this many columns visible either side of cursor horizontally
vim.opt.termguicolors = true -- enable 24 bit colour
vim.opt.splitbelow = true -- horizontal splits are placed below by default
vim.opt.splitright = true -- vertical splits are placed right by default
vim.opt.equalalways = true -- keep splits balanced when opening and closing
vim.opt.hidden = true -- allow buffer switching without saving
vim.opt.confirm = true -- ask what to do instead of erroring when closing with unsaved changes
vim.opt.incsearch = true -- show matches as search is typed
vim.opt.inccommand = "split" -- live preview for :substitute

-- backend settings
vim.opt.swapfile = false -- whether to create a swapfile
vim.opt.backup = false -- whether to create backups
vim.opt.writebackup = false -- whether to write directly to disk
vim.opt.undofile = true -- save undo history
-- vim.opt.undodir = nil -- uses default in state dir
vim.opt.undolevels = 10000 -- max undo steps
vim.opt.undoreload = 10000 -- lines to save for reload
vim.opt.fileencoding = "utf-8" -- default file encoding
vim.opt.updatetime = 250 -- wait time for neovim to fire certain events
vim.opt.timeoutlen = 300 -- wait time to complete mapped sequence
vim.opt.iskeyword:append("-") -- treat hyphenated words as one word
vim.opt.runtimepath:remove("/usr/share/vim/vimfiles") -- remove vim plugins from neovim path
vim.opt.autoread = true -- auto-reload files changed on disk (works with checktime)
vim.opt.smoothscroll = true -- smooth scolling if version supports it
vim.opt.laststatus = 2 -- always show statusline (maybe not useful if lualine for example)

-- diagnostic settings
vim.diagnostic.config({
  virtual_text = {
    severity = { min = vim.diagnostic.severity.WARN },
  },
  virtual_lines = false,
  signs = true,
  underline = true,
  severity_sort = true,
  update_in_insert = false,
  float = { border = "rounded", source = true },
  jump = { float = true },
})

vim.api.nvim_set_hl(0, "DiagnosticDeprecated", {
  underline = true,
  sp = "Gray",
  strikethrough = false,
})
