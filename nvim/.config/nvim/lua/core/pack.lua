require("plugins.colourscheme")
require("plugins.completion")
require("plugins.format")
require("plugins.lsp_config")
require("plugins.treesitter")

vim.api.nvim_create_autocmd("PackChanged", {
  group = vim.api.nvim_create_augroup("PackChangedGroup", { clear = true }),
  callback = function(ev)
    local name = ev.data.spec.name
    local kind = ev.data.kind

    if kind ~= "install" and kind ~= "update" then
      return
    end

    if name == "nvim-treesitter" then
      if not ev.data.active then
        vim.cmd.packadd("nvim-treesitter")
      end
      vim.cmd("TSUpdate")
      return
    end
  end,
})
