#!/bin/bash

#===============================================================================
# Backup Existing Dotfiles
# 
# Creates a timestamped backup of existing dotfiles before stowing.
# Run this before running install.sh if you want to preserve your current setup.
#===============================================================================

set -euo pipefail

BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d_%H%M%S)"

echo "Creating backup in $BACKUP_DIR"
mkdir -p "$BACKUP_DIR"

# Files to backup
FILES=(
    "$HOME/.zshrc"
    "$HOME/.zshenv"
    "$HOME/.zsh"
    "$HOME/.gitconfig"
    "$HOME/.gitconfig-work"
    "$HOME/.gitconfig-personal"
    "$HOME/.gitignore_global"
    "$HOME/.vimrc"
    "$HOME/.p10k.zsh"
)

for file in "${FILES[@]}"; do
    if [[ -e "$file" && ! -L "$file" ]]; then
        echo "Backing up: $file"
        cp -r "$file" "$BACKUP_DIR/"
    fi
done

echo ""
echo "✅ Backup complete: $BACKUP_DIR"
echo ""
echo "To restore:"
echo "  cp -r $BACKUP_DIR/.* ~/"
