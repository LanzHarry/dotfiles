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

## Todo
General tooling to download and configure:
- `zsh` to replace `bash` (then `.bashrc` and local version need to be converted)
- `starship` for command line customisation
- `bat` to replace `cat`
- `eza` to replace `ls` (maybe `lsd` is also fine?)
- `delta` for git diffs
- `yazi` for in terminal file manager
- `lazygit` / `lazydocker` ?
- `btop` to replace `htop`
- `zoxide` to replace `cd`
- `tldr` for man style cheat sheets
