vim.pack.add({
  "https://github.com/folke/tokyonight.nvim",
  "https://github.com/sainnhe/gruvbox-material",
})

-- tokyonight

-- require("tokyonight").setup({
--   styles = {
--     comments = { italic = true },
--   },
--   on_highlights = function(highlights, colours)
--     highlights.LineNr = { fg = colours.magenta2 }
--     highlights.LineNrAbove = { fg = colours.magenta2 }
--     highlights.LineNrBelow = { fg = colours.magenta2 }
--   end,
-- })
--
-- vim.cmd.colorscheme("tokyonight-night")

-- gruvbox
vim.g.gruvbox_material_background = "medium" -- hard, medium, soft, default medium
vim.g.gruvbox_material_foreground = "material" -- material, mix, original, default material
vim.g.gruvbox_enable_italic = 1 -- enable italic but seems to be for fonts with cursive italics?

-- timer to change colourscheme at desired times
-- could be extended using sunrise and sunset calculations from equation of lat and long and utc
local light_start_hour, light_start_min = 7, 30
local dark_start_hour, dark_start_min = 19, 00
local time_polling_interval = 1 * 60 * 1000 -- interval in milliseconds

local function get_light_dark_start_times()
  local now = os.time() -- time in seconds since start epoch
  local t = os.date("*t", now) --[[@as osdate]]

  -- format target start times in seconds since start epoch
  local light_start_time = os.time({
    year = t.year,
    month = t.month,
    day = t.day,
    hour = light_start_hour,
    min = light_start_min,
    sec = 0,
  })

  local dark_start_time = os.time({
    year = t.year,
    month = t.month,
    day = t.day,
    hour = dark_start_hour,
    min = dark_start_min,
    sec = 0,
  })

  return light_start_time, dark_start_time
end

local function set_colourscheme()
  local now = os.time()
  local light_start_time, dark_start_time = get_light_dark_start_times()
  local target_theme

  if now < light_start_time then
    target_theme = "dark"
  elseif now >= light_start_time and now < dark_start_time then
    target_theme = "light"
  else
    target_theme = "dark"
  end

  if vim.o.background == target_theme then
    return -- no change necessary
  end

  vim.opt.background = target_theme
  vim.cmd.colorscheme("gruvbox-material")
end

local function colourscheme_interval(interval_ms)
  local timer = vim.uv.new_timer()
  if not timer then
    vim.notify("Failed to create colourscheme timer", vim.log.levels.ERROR)
    return
  end
  timer:start(0, interval_ms, vim.schedule_wrap(set_colourscheme))
end

colourscheme_interval(time_polling_interval)
