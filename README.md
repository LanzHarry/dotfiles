# Portable dotfiles repo

Managed with stow:

- Install with `sudo apt install stow` on distros with `apt`

## Install

- `clone` this repo into a local repo e.g.
  `git clone https://github.com/LanzHarry/dotfiles.git ~/dotfiles`
- `cd` into `~/dotfiles`
- Run `bash install.sh` (add `-n` flag to dry run)

## Packages

- `zsh`
- `editorconfig`
- `git`
- `mise`
- `nvim`
- `starship`
- `tmux`

## Machine-specific config

Create `~/.zshrc.local` for any additional local settings or overrides (`.local`
files are ignored by this repo and `.zshrc.local` is automatically sourced by
the dotfiles `.zshrc`). There is an example file in the repo. Local files are
also used for things such as git.

## Dependencies and tooling

The following tools are QoL improvements over many standard Linux features and
some are requirements for full functionality in NeoVim plugins. Currently these
are installed manually but I am moving over to management with `mise` to ensure
portability and consistency.

- `Ripgrep`
- `fzf` and `telescope-fzf-native`
- `fd` (fdfind on linux then symlink with
  `ln -s $(which fdfind) ~/.local/bin/fd`)
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
