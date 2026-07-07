vim.pack.add({
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") },
  "https://github.com/rafamadriz/friendly-snippets",
})

require("blink.cmp").setup({
  keymap = {
    preset = "default",
    ["<C-space>"] = false,
    ["<C-d>"] = { "show", "show_documentation", "hide_documentation" },
  },
  sources = {
    default = { "lsp", "path", "snippets" },
  },
  snippets = { preset = "default" },
  fuzzy = {
    implementation = "rust",
    prebuilt_binaries = {
      download = false,
    },
  },
  signature = { enabled = true, trigger = { enabled = false } },
  completion = {
    documentation = { auto_show = false },
    menu = {
      draw = {
        columns = {
          { "label", "label_description", gap = 1 },
          { "kind_icon", "kind", gap = 1 },
          { "source_name" },
        },
      },
    },
  },
})
