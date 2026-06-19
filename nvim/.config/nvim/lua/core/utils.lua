-- lua file for utility funcs used throughout config
local M = {}

---@param mode string|string[]
---@param lhs string
---@param rhs string|function
---@param desc? string
---@param opts? vim.keymap.set.Opts
function M.map(mode, lhs, rhs, desc, opts)
  local options = vim.tbl_extend("force", { silent = true, desc = desc }, opts or {})
  vim.keymap.set(mode, lhs, rhs, options)
end

return M
