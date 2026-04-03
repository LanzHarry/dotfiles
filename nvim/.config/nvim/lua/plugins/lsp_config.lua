return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      { "mason-org/mason-lspconfig.nvim", opts = {} },
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      { "j-hui/fidget.nvim", opts = {} },
    },
    config = function()
      -- following rough structure of kickstart

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach-group", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
          -- map("<C-s>", vim.lsp.buf.signature_help, "Show signature help", "i")
        end,
      })
      -- servers to install using mason
      local servers = {
        clangd = { -- c/c++
          cmd = {
            "clangd",
            "--clang-tidy",
            "--header-insertion=never",
          },
          -- disable formatting capabilities of clangd so proper formatters can work instead
          on_attach = function(client, _)
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
          end,
        },

        cssls = {
          init_options = {
            provideFormatter = false,
          },
        },

        dockerls = {}, -- dockerfile

        html = {
          init_options = {
            provideFormatter = false,
          },
        },

        pyright = {}, -- python

        ruff = {
          on_attach = function(client, _)
            -- disable hover in favour of pyright
            client.server_capabilities.hoverProvider = false
          end,
        },

        sqls = {}, -- unmaintained? check for sqlls

        ts_ls = {},

        yamlls = {
          settings = {
            yaml = {
              schemas = {
                ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose*.yml",
                ["https://json.schemastore.org/github-workflow.json"] = ".github/workflows/*.yml",
              },
            },
          },
        },
      }

      -- ensure servers AND tools are installed here
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        "clang-format", -- c/c++ formatter
        "eslint_d", -- linter for js and ts
        "hadolint", -- linter for dockerfiles
        "htmlhint", -- html linter
        "lua-language-server", -- this is here as the setup is handled manually below
        "prettierd", -- formatter for js and ts (and others...)
        "sql-formatter", -- formatter for sql
        "stylelint", -- css linter
        "stylua", -- lua formatter
      })

      require("mason-tool-installer").setup({
        ensure_installed = ensure_installed,
      })

      for server_name, server_settings in pairs(servers) do
        vim.lsp.config(server_name, server_settings)
        vim.lsp.enable(server_name)
      end

      vim.lsp.config("lua_ls", {
        root_markers = {
          ".luarc.json",
          ".luarc.jsonc",
          ".luacheckrc",
          ".stylua.toml",
          ".git",
        },
      })
      vim.lsp.enable("lua_ls")
    end,
  },
}
