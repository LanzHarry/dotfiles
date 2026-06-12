-- autocommands that fire on specific events happening within nvim

-- local helper definitions
local augroup = vim.api.nvim_create_augroup
local default_group = augroup("BaseAutoCommands", { clear = true })

local function autocmd(event, opts)
  opts.group = opts.group or default_group
  vim.api.nvim_create_autocmd(event, opts)
end

-- turn off auto comment insertion, can be modified per filetype
autocmd("FileType", {
  desc = "Disable auto comment insertion",
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end
})

autocmd("TextYankPost", {
  desc = "Highlight yanked text temporarily",
  callback = vim.highlight.on_yank,
})

-- checktime to make autoread = true (in options) behave reliably
autocmd({ "FocusGained", "BufEnter" }, {
  desc = "Check if file has changed on disk",
  callback = function()
    vim.cmd.checktime()
  end
})

autocmd("BufReadPost", {
  desc = "Restore cursor position on file open",
  callback = function(event)
    local mark = vim.api.nvim_buf_get_mark(event.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(event.buf)
    if mark[1] > 0 and mark[1] <= line_count then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end
})

autocmd("FileType", {
  desc = "Close utility windows with q",
  pattern = { "help", "qf", "man", "notify", "lspinfo" },
  callback = function(event)
    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = event.buf, silent = true })
  end
})

autocmd("VimResized", {
  desc = "Equalise splits on window resize",
  callback = function()
    vim.cmd("tabdo wincmd =")
  end
})
