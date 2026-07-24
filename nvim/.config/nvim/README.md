# NeoVim config

NeoVim config managed as part of dotfiles repo.

## Notes

### Styling and formatting configs

Formatter configs should be treated as sources of truth (e.g. `\*.toml` files or
`.\*rc` files etc.), these files should be in the project root and are committed
to any source control along with the code. Formatters are generally configured
to run on save and thus affect the file after writes have been performed (e.g.
with conform with BufWritePre).

In the NeoVim config itself are `options.lua` for global settings and file type
buffer local settings in `after/ftplugin`. Note that `.editorconfig` will shadow
settings in `after/ftplugin` since `.editorconfig` runs last as per nvim's
behaviour. The key constraint here is to match all formatting config across each
source with the project level config being the ground truth to minimise
formatting fighting between all sources.

During editing `.editorconfig` should determine the base formatting of the file.
Such as adding a blank newline to the end of the file which is not a setting
that exists in nvim otherwise. `.editorconfig` should also live in the project
root and be committed to any source control. The general approach to
`.editorconfig` I have taken in this repo is to only put settings in there that
are not handled already by nvim or `options.lua` or file specific options in
`after/ftplugin` and is thus a very sparse file.

LSPs often include formatting capabilities, and these should be disabled when
explicit formatting is deferred to a separate formatter plugin (e.g. conform).
This is done by disabling these capabilites in the lsp config stage using the
`on_init` function.

In the LSP config the `on_attach` callback can be used to set buffer local
keymaps/options/user commands etc.

Using autocommands per-buffer autoformatting can be toggled on and off if legacy
files need to be edited without causing massive diffs.

General workflow when adding support for a new language:

- Install the LSP and add it to the config at `lsp/<lsp-name>`
- Install formatter and linter as required
- Configure formatter and linter plugins to use them: e.g.
  `formatters_by_ft = {...}`
- For a given project set up the formatting and linting config in a project
  level file (e.g. `pyproject.toml`)
- Make sure that `.editorconfig` and `after/ftplugin` match the settings the
  project level config where any overlaps occur

### Plugins

Plugins are managed by vim.pack

### Dependencies

These are installed manually for the most part and are external concerns to
NeoVim such as:

- Language servers
- Formatters
- Linters
