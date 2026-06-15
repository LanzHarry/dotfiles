#!/usr/bin/env bash

set -e

DOTFILES="$HOME/dotfiles"
EXCLUDE=("bash")
DRY_RUN=""

[[ "$1" == "-n" ]] && DRY_RUN="-n" && echo "Dry run mode"

for dir in "$DOTFILES"/*/; do
    pkg="$(basename "$dir")"
    [[ " ${EXCLUDE[@]} " =~ " $pkg " ]] && echo "Skipping $pkg..." && continue
    echo "Stowing $pkg..."
    stow $DRY_RUN -v -t ~ -d "$DOTFILES" --ignore='.*\.example' "$pkg"
done

echo "Done stowing."
