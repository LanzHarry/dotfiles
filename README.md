# Portable dotfiles repo
Managed with stow (e.g. install with `sudo apt install stow`)

## Install
- `clone` this repo into a local repo e.g. `git clone https://github.com/LanzHarry/dotfiles.git ~/dotfiles`
- `cd` into `~/dotfiles`
- Run `bash install.sh`

## Packages
- `bash`: .bashrc, .bash_aliases

## Machine-specific config
Create `~/.bashrc.local` for any additional local settings or overrides. .local files are ignored by this repo.
