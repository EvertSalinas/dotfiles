# Evert's Dotfiles

A collection of configuration files and setups for my development environment, supporting both macOS and Linux.

## 🛠 Core Tools & Configuration

### Shell: Zsh
- **Configuration:** `zshrc_backup`
- **Theme:** Powerlevel10k
- **Features:**
  - Instant prompt for speed.
  - Vi mode for command-line editing, with cursor shape reflecting the current mode.
  - OS detection (`Darwin` vs. Linux) to load the right Homebrew/asdf/plugin paths on each platform.
  - Custom aliases for navigation, git, Rails, AWS/k8s, and quick config editing (`zshconfig`, `tmuxconfig`).

### Editor: Neovim
- **Configuration Directory:** `nvim_backup/`
- **Plugin Manager:** lazy.nvim (inferred from `lazy-lock.json`)
- **Key Features:**
  - Lua-based configuration.
  - Organized structure (`autocommands`, `keymaps`, `options`).
  - Custom plugin setups, including LSP, Treesitter, Telescope, nvim-tree, vim-fugitive, and Rails/Ruby tooling.

### Terminal: Ghostty
- **Configuration Directory:** `ghostty_backup/`
- **Main Config:** `config.ghostty`

### Session Management: Tmux & Tmuxinator
- **Tmux Config:** `tmux.conf_backup`
  - **Prefix:** `C-s` (remapped from `C-b`).
  - **Keybindings:** Vim-like pane navigation (`h`, `j`, `k`, `l`) and resizing.
  - **Reload:** Quick config reload with `r`.
  - **Plugins:** tpm, tmux-yank, tmux-plugin-sysstat, vim-tmux-navigator, tmux-themepack, tmux-resurrect, tmux-continuum (session persistence/restore).
- **Tmuxinator Config:** `tmuxinator_backup/`
  - Per-project session layouts (editor/server/lazygit windows, etc.) for each active project.

## 📂 Repository Structure

```
.
├── ghostty_backup/       # Ghostty terminal configuration
├── nvim_backup/          # Neovim lua configuration
├── pre_restore_backup/   # Snapshots of your existing configs, saved automatically before a restore
├── tmux.conf_backup      # Tmux configuration file
├── tmuxinator_backup/    # Tmuxinator per-project session configs
├── zshrc_backup          # Zsh shell configuration
├── backup_dotfiles.sh    # Copies your live configs into this repo
├── restore_dotfiles.sh   # Applies this repo's configs to your machine
└── README.md
```

## 🚀 Usage

These files are suffixed with `_backup` to avoid accidental overwrites. Two scripts automate moving files in each direction:

### Backing up
Copies your current `~/.zshrc`, Ghostty config, Neovim config, and `~/.tmux.conf` into this repo:
```bash
./backup_dotfiles.sh
```

### Restoring
Saves a timestamped snapshot of your current configs to `pre_restore_backup/`, then applies the configs from this repo to your machine:
```bash
./restore_dotfiles.sh
```

You can also copy individual files manually:

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

### Tmuxinator
```bash
mkdir -p ~/.config/tmuxinator
cp tmuxinator_backup/*.yml ~/.config/tmuxinator/
```

## 📦 Additional Tooling
- **Database Client:** DBeaver
- **Productivity:** Todoist, Obsidian
- **CLI Utilities:** bat
</content>
