# Portable dotfiles repo
Managed with stow (e.g. install with `sudo apt install stow`)

## Install
- `clone` this repo into a local repo e.g. `git clone https://github.com/LanzHarry/dotfiles.git ~/dotfiles`
- `cd` into `~/dotfiles`
- Run `bash install.sh` (add `-n` flag to dry run)

## Packages
- `zsh`: `.zshrc` and aliases
- `editorconfig`: `.editorconfig` in home dir so will be found when looking up the filesystem
- `git`: `.gitconfig`, `.gitignore_global`
- `nvim`: `.config` dir for whole editor
- `tmux`: tmux.conf and tmux.conf.local based on `https://github.com/gpakosz/.tmux`

## Machine-specific config
Create `~/.zshrc.local` for any additional local settings or overrides (`.local` files are ignored by this repo and `.zshrc.local` is automatically sourced by the dotfiles `.zshrc`). There is an example file in the repo.

## Dependencies and tooling
The following tools are QoL improvements over many standard Linux features and some are requirements for full functionality in NeoVim plugins
- `Ripgrep`
- `fzf` and `telescope-fzf-native`
- `fd` (fdfind on linux then symlink with `ln -s $(which fdfind) ~/.local/bin/fd`)
- `zoxide` to replace cd
- `eza` to replace ls
- `starship` for command line customisation

## Todo
General tooling to download and configure:
- `bat` to replace `cat`
- `delta` for git diffs
- `yazi` for in terminal file manager
- `lazygit` / `lazydocker` ?
- `btop` to replace `htop`
- `tldr` for man style cheat sheets
- `broot`
- `jq` and `yq`
- `xargs`
- `procs`
