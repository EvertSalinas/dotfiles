#!/usr/bin/env bash
# Copies live configs into this repo, then commits and pushes.
# Usage: ./backup_dotfiles.sh [--no-push]
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PUSH=1
[ "${1:-}" = "--no-push" ] && PUSH=0

echo "Syncing nvim..."
rsync -a --delete ~/.config/nvim/ "$DOTFILES/nvim_backup/"

echo "Syncing zsh..."
cp ~/.zshrc "$DOTFILES/zshrc_backup"

if [ -f ~/.tmux.conf ]; then
  echo "Syncing tmux..."
  cp ~/.tmux.conf "$DOTFILES/tmux.conf_backup"
fi

GHOSTTY_MAC="$HOME/Library/Application Support/com.mitchellh.ghostty/config.ghostty"
GHOSTTY_LINUX="$HOME/.config/ghostty/config"
if [ -f "$GHOSTTY_MAC" ]; then
  echo "Syncing ghostty (macOS path)..."
  cp "$GHOSTTY_MAC" "$DOTFILES/ghostty_backup/config.ghostty"
elif [ -f "$GHOSTTY_LINUX" ]; then
  echo "Syncing ghostty (Linux path)..."
  cp "$GHOSTTY_LINUX" "$DOTFILES/ghostty_backup/config.ghostty"
fi

if ls ~/.config/tmuxinator/*.yml >/dev/null 2>&1; then
  echo "Syncing tmuxinator..."
  mkdir -p "$DOTFILES/tmuxinator_backup"
  cp ~/.config/tmuxinator/*.yml "$DOTFILES/tmuxinator_backup/"
fi

cd "$DOTFILES"
git add nvim_backup zshrc_backup ghostty_backup tmuxinator_backup backup_dotfiles.sh
[ -f tmux.conf_backup ] && git add tmux.conf_backup

if git diff --cached --quiet; then
  echo "No changes to sync."
  exit 0
fi

git commit -m "Sync dotfiles from $(hostname) ($(date +%Y-%m-%d))"

if [ "$PUSH" -eq 1 ]; then
  git push
  echo "Pushed to origin."
else
  echo "Committed locally, not pushed (--no-push)."
fi
