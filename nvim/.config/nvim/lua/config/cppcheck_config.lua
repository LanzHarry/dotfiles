-- This file is for configuration of cppcheck linting
-- This file was created to add the compile commands to a project flag but for
-- buffer level linting it doesn't work. Perhaps a future project level line
-- command may come in useful?
local M = {}

--[[ local function readable(p)
  return vim.fn.filereadable(p) == 1
end

function M.find_compdb()
  local cwd = vim.fn.getcwd()
  local candidates = {
    cwd .. "/compile_commands.json",
    cwd .. "/build/compile_commands.json",
    cwd .. "/build-debug/compile_commands.json",
    cwd .. "/build-asan/compile_commands.json",
  }
  for _, p in ipairs(candidates) do
    if readable(p) then
      return p
    end
  end
  return nil
end ]]

function M.args()
  local args = {
    "--language=c++",
    "--std=c++17",
    "--enable=warning,performance,portability",
    "--inline-suppr",
    "--quiet",
    "--template=gcc",
    "--suppress=missingIncludeSystem",
  }

  --[[ local compdb = M.find_compdb()
  if compdb then
    table.insert(args, 1, "--project=" .. compdb)
  end ]]

  return args
end

return M
