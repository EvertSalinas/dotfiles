# Evert's Dotfiles

A collection of configuration files and setups for my development environment on macOS.

## 🛠 Core Tools & Configuration

### Shell: Zsh
- **Configuration:** `zshrc_backup`
- **Theme:** Powerlevel10k
- **Features:**
  - Instant prompt for speed.
  - Custom aliases for navigation and quick config editing (`zshconfig`, `tmuxconfig`).

### Editor: Neovim
- **Configuration Directory:** `nvim_backup/`
- **Plugin Manager:** lazy.nvim (inferred from `lazy-lock.json`)
- **Key Features:**
  - Lua-based configuration.
  - Organized structure (`autocommands`, `keymaps`, `options`).
  - Custom plugin setups.

### Terminal: Ghostty
- **Configuration Directory:** `ghostty_backup/`
- **Main Config:** `config.ghostty`

### Session Management: Tmux & Tmuxinator
- **Tmux Config:** `tmux.conf_backup`
  - **Prefix:** `C-s` (remapped from `C-b`).
  - **Keybindings:** Vim-like pane navigation (`h`, `j`, `k`, `l`) and resizing.
  - **Reload:** Quick config reload with `r`.
- **Tmuxinator**


## 📂 Repository Structure

```
.
├── ghostty_backup/     # Ghostty terminal configuration
├── nvim_backup/        # Neovim lua configuration
├── tmux.conf_backup    # Tmux configuration file
├── zshrc_backup        # Zsh shell configuration
└── README.md
```

## 🚀 Usage

These files are suffixed with `_backup` to avoid accidental overwrites. To use them, you can symlink or copy them to their respective locations:

### Zsh
```bash
cp zshrc_backup ~/.zshrc
```

### Tmux
```bash
cp tmux.conf_backup ~/.tmux.conf
```

### Ghostty
```bash
mkdir -p "$HOME/Library/Application Support/com.mitchellh.ghostty"
cp ghostty_backup/config.ghostty "$HOME/Library/Application Support/com.mitchellh.ghostty/config.ghostty"
```

### Neovim
```bash
mkdir -p ~/.config/nvim
cp -r nvim_backup/* ~/.config/nvim/
```

## 📦 Additional Tooling
- **Database Client:** DBeaver
- **Productivity:** Todoist, Obsidian
- **CLI Utilities:** bat
