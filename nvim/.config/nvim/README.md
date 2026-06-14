# NeoVim config
NeoVim config managed as part of dotfiles repo.

## Notes

### Styling and formatting configs
Formatter configs should be treated as sources of truth (e.g. \*.toml files or .\*rc files etc.), these files should be in the project root and are committed to any source control along with the code. Formatters are generally configured to run on save and thus affect the file after writes have been performed (e.g. with conform with BufWritePre).

During editing .editorconfig should determine the base formatting of the file. .editorconfig should also live in the project root and be committed to any source control. Any overlapping settings should match between .editorconfig and the formatting config files defined for the formatters.

In the NeoVim config itself are `options.lua` for global settings and file type buffer local settings in `after/ftplugin`. Some settings are shadowed by .editorconfig settings but can be more extensive or act as fallback options.

LSPs often include formatting capabilities and these should be disabled when explicit formatting capabilities are deferred to plugins/formatters like conform. This is done with the `on_attach` callback in LSP configuration.

Using autocommands per-buffer autoformatting can be toggled on and off if legacy files need to be edited without causing massive diffs.

### Plugins
Plugins are managed by vim.pack
