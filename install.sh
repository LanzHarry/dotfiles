#!/usr/bin/env bash
set -e  # exit on any error

DOTFILES="$HOME/dotfiles"
EXCLUDE=()
DRY_RUN=""

[[ "$1" == "-n" ]] && DRY_RUN="-n" && echo "Dry run mode"

for dir in "$DOTFILES"/*/; do
    pkg="$(basename "$dir")"
    [[ " ${EXCLUDE[@]} " =~ " $pkg " ]] && continue
    echo "Stowing $pkg..."
    stow $DRY_RUN -v -t ~ -d "$DOTFILES" "$pkg"
done

echo "Done."
