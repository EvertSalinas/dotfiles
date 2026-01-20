# Dotfiles

A collection of configuration files and setups for my development environment on macOS.

## 🛠 Core Tools & Configuration

### Shell: Zsh
- **Configuration:** `zshrc_backup`
- **Theme:** Powerlevel10k
- **Features:**
  - Instant prompt for speed.
  - Custom aliases for navigation and quick config editing (`zshconfig`, `tmuxconfig`).
  - Integration with standard tools (ls colors, etc.).

### Editor: Neovim
- **Configuration Directory:** `nvim_backup/`
- **Plugin Manager:** lazy.nvim (inferred from `lazy-lock.json`)
- **Key Features:**
  - Lua-based configuration.
  - Organized structure (`autocommands`, `keymaps`, `options`).
  - Custom plugin setups.

### Terminal: Alacritty
- **Configuration Directory:** `alacritty_backup/`
- **Themes:** Extensive collection of themes (Catppuccin, Dracula, Gruvbox, Nord, etc.) located in `themes/`.
- **Main Config:** `alacritty.toml`

### Session Management: Tmux & Tmuxinator
- **Tmux Config:** `tmux.conf_backup`
  - **Prefix:** `C-s` (remapped from `C-b`).
  - **Keybindings:** Vim-like pane navigation (`h`, `j`, `k`, `l`) and resizing.
  - **Reload:** Quick config reload with `r`.
- **Tmuxinator:** `tmuxinator_backup/`
  - Pre-configured layouts for projects:
    - `auth-service`
    - `communications-backend`
    - `navigate-backend`
    - `navigate-frontend`
    - `rooms-backend`
    - `thrillshare`

## 📂 Repository Structure

```
.
├── alacritty_backup/   # Alacritty terminal configuration and themes
├── nvim_backup/        # Neovim lua configuration
├── tmuxinator_backup/  # Tmuxinator project layouts
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

### Alacritty
```bash
mkdir -p ~/.config/alacritty
cp -r alacritty_backup/* ~/.config/alacritty/
```

### Neovim
```bash
mkdir -p ~/.config/nvim
cp -r nvim_backup/* ~/.config/nvim/
```

### Tmuxinator
```bash
mkdir -p ~/.config/tmuxinator
cp tmuxinator_backup/*.yml ~/.config/tmuxinator/
```

## 📦 Additional Tooling
- **Database Client:** DBeaver
- **Productivity:** Todoist, Obsidian
- **CLI Utilities:** bat