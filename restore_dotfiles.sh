#!/bin/bash

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$DOTFILES/pre_restore_backup/$(date +%Y%m%d_%H%M%S)"

echo "Saving current configs to $BACKUP_DIR before restoring..."
mkdir -p "$BACKUP_DIR/nvim"
mkdir -p "$BACKUP_DIR/tmuxinator"
cp ~/.zshrc "$BACKUP_DIR/zshrc"
if [ -f "$HOME/Library/Application Support/com.mitchellh.ghostty/config.ghostty" ]; then
  cp "$HOME/Library/Application Support/com.mitchellh.ghostty/config.ghostty" "$BACKUP_DIR/config.ghostty"
elif [ -f ~/.config/ghostty/config ]; then
  cp ~/.config/ghostty/config "$BACKUP_DIR/config.ghostty"
fi
[ -f ~/.tmux.conf ] && cp ~/.tmux.conf "$BACKUP_DIR/tmux.conf"
cp -r ~/.config/nvim/. "$BACKUP_DIR/nvim/"
cp ~/.config/tmuxinator/*.yml "$BACKUP_DIR/tmuxinator/" 2>/dev/null
echo "Backup saved."

echo "Restoring zsh..."
cp "$DOTFILES/zshrc_backup" ~/.zshrc

echo "Restoring ghostty..."
if [[ "$OSTYPE" == "darwin"* ]]; then
  mkdir -p "$HOME/Library/Application Support/com.mitchellh.ghostty"
  cp "$DOTFILES/ghostty_backup/config.ghostty" "$HOME/Library/Application Support/com.mitchellh.ghostty/config.ghostty"
else
  mkdir -p ~/.config/ghostty
  cp "$DOTFILES/ghostty_backup/config.ghostty" ~/.config/ghostty/config
fi

echo "Restoring tmux..."
cp "$DOTFILES/tmux.conf_backup" ~/.tmux.conf

echo "Restoring tmuxinator..."
mkdir -p ~/.config/tmuxinator
cp "$DOTFILES/tmuxinator_backup/"*.yml ~/.config/tmuxinator/

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
