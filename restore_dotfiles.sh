#!/bin/bash

DOTFILES=~/Code/Evert/dotfiles
BACKUP_DIR="$DOTFILES/pre_restore_backup/$(date +%Y%m%d_%H%M%S)"

echo "Saving current configs to $BACKUP_DIR before restoring..."
mkdir -p "$BACKUP_DIR/nvim"
cp ~/.zshrc "$BACKUP_DIR/zshrc"
cp ~/.config/alacritty/alacritty.toml "$BACKUP_DIR/alacritty.toml"
cp ~/.tmux.conf "$BACKUP_DIR/tmux.conf"
cp -r ~/.config/nvim/. "$BACKUP_DIR/nvim/"
echo "Backup saved."

echo "Restoring zsh..."
cp "$DOTFILES/zshrc_backup" ~/.zshrc

echo "Restoring alacritty..."
cp "$DOTFILES/alacritty_backup/alacritty.toml" ~/.config/alacritty/alacritty.toml
cp "$DOTFILES/alacritty_backup/alacritty.macos.toml" ~/.config/alacritty/platform.toml

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
