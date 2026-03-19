return {
  "nvim-telescope/telescope.nvim",
  event = "VimEnter",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release --target install",
    },
  },
  config = function()
    require("telescope").setup({
      defaults = {
        file_ignore_patterns = {
          "^%.git/",
          "node_modules/",
          "%.cache/",
          "^%.cargo/",
          "^%.rustup/",
          "^%.nvm/",
          "^%.local/share/",
          "^%.dotnet/",
        },
      },
      pickers = {
        find_files = {
          find_command = { "fd", "--type", "f", "--hidden", "--exclude", ".git" },
        },
        live_grep = {
          additional_args = { "--hidden", "--glob", "!.git", "--glob", "!node_modules" },
        },
      },
      extensions = {
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = "smart_case", -- or "ignore_case" or "respect_case" the default case_mode is "smart_case"
        },
      },
    })
    require("telescope").load_extension("fzf")

    -- KEYMAPS
    local builtin = require("telescope.builtin")
    -- leader f keymaps for FIND style search
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [H]elp" })
    vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[F]ind [K]eymaps" })
    vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
    vim.keymap.set("n", "<leader>fs", builtin.builtin, { desc = "[F]ind [S]elect Telescope" })
    vim.keymap.set(
      { "n", "v" },
      "<leader>fw",
      builtin.grep_string,
      { desc = "[F]ind current [W]ord" }
    )
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[F]ind by [G]rep" })
    vim.keymap.set(
      "n",
      "<leader>fb",
      builtin.current_buffer_fuzzy_find,
      { desc = "[F]ind in current [B]uffer" }
    )
    vim.keymap.set("n", "<leader>fd", function()
      builtin.diagnostics({ bufnr = 0 })
    end, { desc = "[F]ind [D]iagnostics" })
    vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "[F]ind [R]esume" })
    vim.keymap.set(
      "n",
      "<leader>f.",
      builtin.oldfiles,
      { desc = '[F]ind Recent Files ("." for repeat)' }
    )
    vim.keymap.set("n", "<leader>fc", builtin.commands, { desc = "[F]ind [C]ommands" })
    vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

    -- misc leader keymaps (couldn't lead with f due to clashes)
    vim.keymap.set(
      "n",
      "<leader>ds",
      builtin.lsp_document_symbols,
      { desc = "[D]ocument [S]ymbols" }
    )
    vim.keymap.set(
      "n",
      "<leader>ws",
      builtin.lsp_dynamic_workspace_symbols,
      { desc = "[W]orkspace [S]ymbols" }
    )

    -- g keymaps for lsp powered searches
    vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "[G]oto [D]efinition" })
    vim.keymap.set("n", "grr", builtin.lsp_references, { desc = "[G]oto [R]eferences" })
    vim.keymap.set("n", "gri", builtin.lsp_implementations, { desc = "[G]oto [I]mplementation" })
  end,
}
