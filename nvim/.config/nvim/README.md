# NeoVim config
NeoVim config managed as part of dotfiles repo.

## Notes

### Styling and formatting configs
Formatter configs should be treated as sources of truth (e.g. `\*.toml` files or `.\*rc` files etc.), these files should be in the project root and are committed to any source control along with the code. Formatters are generally configured to run on save and thus affect the file after writes have been performed (e.g. with conform with BufWritePre).

During editing `.editorconfig` should determine the base formatting of the file. `.editorconfig` should also live in the project root and be committed to any source control. Any overlapping settings should match between `.editorconfig` and the formatting config files defined for the formatters.

In the NeoVim config itself are `options.lua` for global settings and file type buffer local settings in `after/ftplugin`. Note that `.editorconfig` will shadow settings in `after/ftplugin` since `.editorconfig` runs last as per nvim's behaviour. The key constraint here is to match all formatting config across each source with the project level config being the ground truth to minimise formatting fighting between all sources.

LSPs often include formatting capabilities, and these should be disabled when explicit formatting is deferred to a separate formatter plugin (e.g. conform). This is done by setting `capabilities.documentFormattingProvider = false` (and `documentRangeFormattingProvider = false`) in the LSP config, which tells the client not to use the server's formatting capability at all. The nvim client here is specifically negotiating what LSP capabilities are desired, the language server also advertises its capabilities to the client when attaching.

In the LSP config the `on_attach` callback can be used to set buffer local keymaps/options/user commands etc.

Using autocommands per-buffer autoformatting can be toggled on and off if legacy files need to be edited without causing massive diffs.

General workflow when adding support for a new language:
- Install the LSP and add it to the config at `lsp/<lsp-name>`
- Install formatter and linter as require
- Configure formatter and linter plugins to use them: e.g. `formatters_by_ft = {...}`
- For a given project set up the formatting and linting config in a project level file (e.g. `pyproject.toml`)
- Make sure that `.editorconfig` and `after/ftplugin` match the settings the project level config where any overlaps occur

### Plugins
Plugins are managed by vim.pack:
- Completion: `blink.cmp` with built from source rust fuzzy finder
- TODO: add rest of plugins once reconfiguration is completed

### Dependencies
These are installed manually for the most part and are external concerns to NeoVim:
Language servers:
- `lua-language-server`
- `basedpyright`

Formatters:
- `stylua`
- `ruff`

Linters:
- `ruff`
