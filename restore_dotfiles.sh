#!/bin/bash

DOTFILES=~/Code/Evert/dotfiles
BACKUP_DIR="$DOTFILES/pre_restore_backup/$(date +%Y%m%d_%H%M%S)"

echo "Saving current configs to $BACKUP_DIR before restoring..."
mkdir -p "$BACKUP_DIR/nvim"
cp ~/.zshrc "$BACKUP_DIR/zshrc"
cp "$HOME/Library/Application Support/com.mitchellh.ghostty/config.ghostty" "$BACKUP_DIR/config.ghostty"
cp ~/.tmux.conf "$BACKUP_DIR/tmux.conf"
cp -r ~/.config/nvim/. "$BACKUP_DIR/nvim/"
echo "Backup saved."

echo "Restoring zsh..."
cp "$DOTFILES/zshrc_backup" ~/.zshrc

echo "Restoring ghostty..."
mkdir -p "$HOME/Library/Application Support/com.mitchellh.ghostty"
cp "$DOTFILES/ghostty_backup/config.ghostty" "$HOME/Library/Application Support/com.mitchellh.ghostty/config.ghostty"

echo "Restoring tmux..."
cp "$DOTFILES/tmux.conf_backup" ~/.tmux.conf

echo "Restoring nvim..."
FUGITIVE_TMP=""
LOCK_TMP=""

if [ -f ~/.config/nvim/lua/plugins/vim-fugitive.lua ]; then
  FUGITIVE_TMP=$(mktemp)
  cp ~/.config/nvim/lua/plugins/vim-fugitive.lua "$FUGITIVE_TMP"
fi
if [ -f ~/.config/nvim/lazy-lock.json ]; then
  LOCK_TMP=$(mktemp)
  cp ~/.config/nvim/lazy-lock.json "$LOCK_TMP"
fi

cp -r "$DOTFILES/nvim_backup/." ~/.config/nvim/

[ -n "$FUGITIVE_TMP" ] && cp "$FUGITIVE_TMP" ~/.config/nvim/lua/plugins/vim-fugitive.lua && rm "$FUGITIVE_TMP"
[ -n "$LOCK_TMP" ] && cp "$LOCK_TMP" ~/.config/nvim/lazy-lock.json && rm "$LOCK_TMP"

echo "Done. Run 'source ~/.zshrc' to reload your shell."
