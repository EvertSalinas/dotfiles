# Evert's Dotfiles

A collection of configuration files and setups for my development environment, supporting both macOS and Linux (Omarchy).

Configs are managed with [GNU Stow](https://www.gnu.org/software/stow/): each top-level folder is a *package* that mirrors the layout of `$HOME`, and `stow` symlinks it into place. Editing a file in `~` edits the repo, so `git` is the only sync mechanism between machines.

## 📂 Packages

| Package | Links to | Notes |
|---|---|---|
| `zsh` | `~/.zshrc`, `~/.zshenv`, `~/.zprofile` | OS-guarded (`$OSTYPE` / `uname`); needs zinit installed |
| `tmux` | `~/.tmux.conf` | Prefix `C-s`, plugins via tpm |
| `nvim` | `~/.config/nvim` | lazy.nvim; `lazy-lock.json` is shared across machines |
| `ghostty-mac` | `~/.config/ghostty/config` | macOS only |
| `ghostty-linux` | `~/.config/ghostty/config` | Omarchy only (theme is managed by Omarchy) |
| `git` | `~/.gitconfig`, `~/.gitignore` | Machine-specific includes live outside the repo |
| `tmuxinator` | `~/.config/tmuxinator/*.yml` | Personal projects only |
| `btop` | `~/.config/btop/btop.conf` | |

Stow only the packages that apply to the machine. `ghostty-mac` and `ghostty-linux` both target the same file, so never stow both.

## 🚀 Usage

This repo does not live directly under `~`, so stow needs `-t ~`.

```bash
# macOS
brew install stow
cd ~/Code/Evert/dotfiles
stow -t ~ zsh tmux nvim ghostty-mac git tmuxinator btop

# Linux (Omarchy)
sudo pacman -S stow
cd ~/Code/Evert/dotfiles
stow -t ~ zsh tmux nvim ghostty-linux git tmuxinator btop
```

Existing real files at the target paths make stow abort with a conflict. Move them aside first (for example into `~/dotfiles-backup/`), then re-run.

Preview without changing anything:

```bash
stow -n -v -t ~ <package>
```

Remove a package's links:

```bash
stow -D -t ~ <package>
```

### Things to know
- **Zsh:** the plugin block is skipped until zinit exists at `~/.local/share/zinit/zinit.git`, so a fresh machine still gets a working shell, just without the prompt and plugins.
- **Git package:** it has a `.stow-local-ignore` because stow skips `.gitignore` by default. `commit.gpgsign` is on, so the signing key must exist on the machine.
- **Tmuxinator:** only personal projects are tracked here (the repo is public). Other project files can sit next to the symlinks in `~/.config/tmuxinator/` and stay untracked.
- **Neovim:** the folder is linked as a whole, so new files under `~/.config/nvim` appear in the repo as untracked. `nvim/.config/nvim/pack/` is gitignored.

## 🛠 Core Tools & Configuration

### Shell: Zsh
- **Plugin manager:** zinit (Powerlevel10k, autosuggestions, completions, syntax highlighting)
- **Features:**
  - Instant prompt for speed.
  - Vi mode for command-line editing, with cursor shape reflecting the current mode.
  - OS detection (`Darwin` vs. Linux) to load the right Homebrew/asdf paths on each platform.
  - Custom aliases for navigation, git, Rails, AWS/k8s, and quick config editing (`zshconfig`, `tmuxconfig`).

### Editor: Neovim
- **Plugin Manager:** lazy.nvim
- **Key Features:**
  - Lua-based configuration.
  - Organized structure (`autocommands`, `keymaps`, `options`).
  - Custom plugin setups, including LSP, Treesitter, Telescope, nvim-tree, vim-fugitive, and Rails/Ruby tooling.

### Terminal: Ghostty
- Separate per-OS packages: the Mac config is minimal, the Linux one includes Omarchy's theme and Hyprland tweaks.

### Session Management: Tmux & Tmuxinator
- **Tmux:**
  - **Prefix:** `C-s` (remapped from `C-b`).
  - **Keybindings:** Vim-like pane navigation (`h`, `j`, `k`, `l`) and resizing.
  - **Reload:** Quick config reload with `r`.
  - **Plugins:** tpm, tmux-yank, tmux-plugin-sysstat, vim-tmux-navigator, tmux-themepack, tmux-resurrect, tmux-continuum (session persistence/restore).
- **Tmuxinator:** per-project session layouts (editor/server/lazygit windows, etc.).

## 📦 Additional Tooling
- **Database Client:** DBeaver
- **Productivity:** Todoist, Obsidian
- **CLI Utilities:** bat
