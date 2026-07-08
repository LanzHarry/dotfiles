#!/usr/bin/env bash
# using bash like this ignore settings so shopt -s dotglob is not used by default
# therefore dot prefixed files and dirs are ignored

# abort immediately if any command exits non-zero
set -e

DOTFILES="$HOME/dotfiles"
EXCLUDE=("bash")
DRY_RUN=""

[[ "$1" == "-n" ]] && DRY_RUN="-n" && echo "Dry run mode"

# using /*/ means that only dirs are looped over due to the trailing /
for dir in "$DOTFILES"/*/; do
    pkg="$(basename "$dir")"
    [[ " ${EXCLUDE[@]} " =~ " $pkg " ]] && echo "Skipping $pkg..." && continue
    echo "Stowing $pkg..."
    stow $DRY_RUN -v -t ~ -d "$DOTFILES" --ignore='.*\.example' "$pkg"
done

echo "Done stowing."
