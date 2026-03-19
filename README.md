# Portable dotfiles repo
Managed with stow (e.g. install with `sudo apt install stow`)

## Install
- `clone` this repo into a local repo e.g. `git clone https://github.com/LanzHarry/dotfiles.git ~/dotfiles`
- `cd` into `~/dotfiles`
- Run `bash install.sh` (add `-n` flag to dry run)

## Packages
- `bash`: .bashrc, .bash_aliases
- `editorconfig`: .editorconfig
- `git`: .gitconfig, .gitignore_global
- `nvim`: .config (dir)
- `tmux`: tmux.conf and tmux.conf.local based on `https://github.com/gpakosz/.tmux`

## Machine-specific config
Create `~/.bashrc.local` for any additional local settings or overrides (.local files are ignored by this repo. and .bashrc.local is automatically sourced by the dotfiles .bashrc)

## Dependencies
### Neovim plugin dependencies
These plugins are manually installed dependencies:
- Ripgrep
- fzf and telescope-fzf-native
- fd (fdfind on linux then symlink with `ln -s $(which fdfind) ~/.local/bin/fd`)
