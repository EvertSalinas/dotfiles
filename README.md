# Evert's Dotfiles

A collection of configuration files and setups for my development environment, supporting both macOS and Linux (Omarchy).

Configs are managed with [GNU Stow](https://www.gnu.org/software/stow/): each top-level folder is a *package* that mirrors the layout of `$HOME`, and `stow` symlinks it into place. Editing a file in `~` edits the repo, so `git` is the only sync mechanism between machines.

## 📂 Packages

| Package | Links to | Notes |
|---|---|---|
| `zsh` | `~/.zshrc`, `~/.zshenv`, `~/.zprofile` | OS-guarded (`$OSTYPE` / `uname`); needs zinit installed for plugins |
| `starship` | `~/.config/starship.toml` | Prompt; switch colors via `palette` (`monokai_remastered` is active; also `monokai_pro`, `catppuccin_mocha`, `catppuccin_macchiato`, `tokyo_night`, `rose_pine`, `gruvbox_dark`) |
| `tmux` | `~/.tmux.conf` | Prefix `C-s`, plugins via tpm |
| `nvim` | `~/.config/nvim` | lazy.nvim; `lazy-lock.json` is shared across machines |
| `ghostty-mac` | `~/.config/ghostty/config` | macOS only; font and theme only |
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
stow -t ~ zsh starship tmux nvim ghostty-mac git tmuxinator btop

# Linux (Omarchy)
sudo pacman -S stow
cd ~/Code/Evert/dotfiles
stow -t ~ zsh starship tmux nvim ghostty-linux git tmuxinator btop
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
- **Zsh:** the plugin block is skipped until zinit exists at `~/.local/share/zinit/zinit.git`, so a fresh machine still gets a working shell, just without the plugins. The prompt, fzf and zoxide each load only if their binary is installed (`brew bundle` or `packages-arch.txt`).
- **Git package:** it has a `.stow-local-ignore` because stow skips `.gitignore` by default. `commit.gpgsign` is on, so the signing key must exist on the machine.
- **Tmuxinator:** only personal projects are tracked here (the repo is public). Other project files can sit next to the symlinks in `~/.config/tmuxinator/` and stay untracked.
- **Neovim:** the folder is linked as a whole, so new files under `~/.config/nvim` appear in the repo as untracked. `nvim/.config/nvim/pack/` is gitignored.

## 🛠 Core Tools & Configuration

### Shell: Zsh
- **Prompt:** [Starship](https://starship.rs) (`starship` package). Shows directory, git branch/status, Ruby/Node/Python versions, kubectl context, AWS profile and slow-command duration. Needs a Nerd Font for the icons (FiraCode Nerd Font Mono in Ghostty).
- **Plugin manager:** zinit (zsh-completions, fzf-tab, zsh-autosuggestions, zsh-syntax-highlighting).
  - Load order matters: completions, then `compinit`, then fzf-tab, then the plugins that wrap widgets (autosuggestions, syntax highlighting last).
  - fzf-tab replaces the Tab menu with fzf and previews directories with `eza` when completing `cd` / `z`.
- **Features:**
  - fzf key bindings (`fd` as the file source) and zoxide (`z`, `zi`).
  - OS detection (`Darwin` vs. Linux) to load the right Homebrew/asdf paths on each platform.
  - Custom aliases for navigation, git, Rails, AWS/k8s, and quick config editing (`zshconfig`, `tmuxconfig`).

### Editor: Neovim
- **Plugin Manager:** lazy.nvim
- **Key Features:**
  - Lua-based configuration.
  - Organized structure (`autocommands`, `keymaps`, `options`).
  - Custom plugin setups, including LSP, Treesitter, Telescope, nvim-tree, vim-fugitive, and Rails/Ruby tooling.
  - Colorscheme: `monokai.nvim` with a Monokai Remastered palette (`lua/plugins/monokai.lua`), plus a matching hand-written lualine theme.

### Terminal: Ghostty
- Separate per-OS packages: the Mac config is minimal (FiraCode Nerd Font Mono, `Monokai Remastered` theme), the Linux one includes Omarchy's theme and Hyprland tweaks.
- Browse built-in themes with `ghostty +list-themes`, then set `theme = <name>` in `ghostty-mac/.config/ghostty/config`.

### Session Management: Tmux & Tmuxinator
- **Tmux:**
  - **Prefix:** `C-s` (remapped from `C-b`).
  - **Keybindings:** Vim-like pane navigation (`h`, `j`, `k`, `l`) and resizing.
  - **Reload:** Quick config reload with `r`.
  - **Theme:** Monokai Remastered, set by hand in `.tmux.conf` (status bar, pane borders, messages).
  - **Plugins:** tpm, tmux-yank, tmux-plugin-sysstat, vim-tmux-navigator, tmux-resurrect, tmux-continuum (session persistence/restore).
- **Tmuxinator:** per-project session layouts (editor/server/lazygit windows, etc.).

## 🎨 Theme: Monokai Remastered

One palette across the terminal so everything matches. Remastered has a near-black `#0c0c0c` background, which is where the contrast comes from.

| Tool | Where | How |
|---|---|---|
| Ghostty | `ghostty-mac/.config/ghostty/config` | `theme = Monokai Remastered` (built in) |
| Starship | `starship/.config/starship.toml` | `palette = 'monokai_remastered'` |
| tmux | `tmux/.tmux.conf` | hex colors in the `# Theme` block |
| Neovim | `nvim/.config/nvim/lua/plugins/monokai.lua`, `lualine.lua` | custom palette passed to `monokai.nvim` |
| bat | `zsh/.zshrc` | `BAT_THEME="Monokai Extended"` (closest built-in; there is no Remastered) |
| fzf / fzf-tab | `zsh/.zshrc` | `FZF_DEFAULT_OPTS` colors |

Palette: pink `#f4005f`, green `#98e024`, yellow `#e0d561`, orange `#fd971f`, purple `#9d65ff`, cyan `#58d1eb`, grey `#625e4c`, foreground `#d9d9d9`.

To switch themes, change the Ghostty `theme` line and the Starship `palette` line (other palettes are already in `starship.toml`), then update the hex values in tmux, `monokai.lua`, `lualine.lua` and `FZF_DEFAULT_OPTS`.

## 📦 Additional Tooling
- **Database Client:** DBeaver
- **Productivity:** Todoist, Obsidian
- **CLI Utilities:** bat, eza, fd, fzf, zoxide, yazi, starship
