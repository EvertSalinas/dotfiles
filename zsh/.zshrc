# ============================================================
# Shell options
# ============================================================

# --- History ---
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS

# --- Sane defaults oh-my-zsh used to provide ---
setopt AUTO_CD
setopt EXTENDED_GLOB
setopt INTERACTIVE_COMMENTS

# ============================================================
# Environment and PATH
# (kept before plugins/hooks so tools like fzf and direnv are on PATH when they load)
# ============================================================

# --- Variables ---
export EDITOR='nvim'
export UID=$(id -u)
export GID=$(id -g)
export GPG_TTY=$(tty)
export TERM=xterm-256color

# migite vault root (default changed from ~/Documents/MasterVault/dev-log to
# the portable ~/dev-log — this pins it back to the existing Obsidian vault)
export DEV_LOG_BASE="$HOME/Documents/MasterVault/dev-log"

export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git'
# TokyoNight Night (matches ghostty, tmux, starship, nvim). The bat theme lives in the `bat` stow package
# (run `bat cache --build` once after stowing).
export BAT_THEME="tokyonight_night"
export FZF_DEFAULT_OPTS="--color=fg:#c0caf5,bg+:#283457,hl:#2ac3de,hl+:#2ac3de,info:#545c7e,prompt:#2ac3de,pointer:#ff007c,marker:#ff007c,spinner:#ff007c,header:#ff9e64,border:#27a1b9,separator:#ff9e64,scrollbar:#27a1b9"

# --- PATH (base) ---
export PATH="$HOME/Code/dotfiles/bin:$PATH"
export PATH=/usr/local/bin:$PATH
export PATH="/usr/local/bin/python3:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# --- NVM ---
[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# --- Platform specific ---
if [[ "$(uname)" == "Darwin" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  export HOMEBREW_OPT="/opt/homebrew/opt"
  export PATH="/opt/homebrew/opt/openssl@1.1/bin:$PATH"
  export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"
  export PATH="/opt/homebrew/opt/imagemagick@6/bin:$PATH"
  export CFLAGS="-I/opt/homebrew/opt/imagemagick\@6/include/ImageMagick-6:$CFLAGS"
  export CPPFLAGS="-I$(brew --prefix zlib)/include -I/opt/homebrew/opt/imagemagick@6/include:$CPPFLAGS"
  # Don't use $LDFLAGS here: it can contain -L/lib which breaks Ruby's configure (asdf install ruby).
  export LDFLAGS="-L$(brew --prefix zlib)/lib"
  export PKG_CONFIG_PATH="/opt/homebrew/opt/imagemagick@6/lib/pkgconfig:$PKG_CONFIG_PATH"
  export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
  export PATH="$HOME/.asdf/shims:$PATH"
  export MIGITE_PYTHON="$HOME/.venvs/migite/bin/python3"
else
  [[ -s "$HOME/.asdf/asdf.sh" ]] && . "$HOME/.asdf/asdf.sh"
  export MIGITE_PYTHON="$HOME/Code/migite/.venv/bin/python3"
fi

[[ -d "$HOME/.kimi-code/bin" ]] && export PATH="$HOME/.kimi-code/bin:$PATH"

# ============================================================
# Plugins and completion
# ============================================================

# --- zinit ---
# Order matters: completions -> compinit -> fzf-tab -> widget-wrapping plugins
# (fzf-tab needs compinit first, and must load before autosuggestions/syntax-highlighting).
ZINIT_HOME="$HOME/.local/share/zinit/zinit.git"
if [[ -r "$ZINIT_HOME/zinit.zsh" ]]; then
  source "$ZINIT_HOME/zinit.zsh"
  zinit light zsh-users/zsh-completions
fi

# --- Completion ---
autoload -Uz compinit
compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
# fzf-tab: preview directory contents when completing cd/z
zstyle ':fzf-tab:complete:(cd|z|zoxide):*' fzf-preview 'eza -1 --color=always $realpath'

if (( $+functions[zinit] )); then
  zinit light Aloxaf/fzf-tab
  zinit light zsh-users/zsh-autosuggestions
  # syntax-highlighting must be loaded last among zle-touching plugins
  zinit light zsh-users/zsh-syntax-highlighting
  zinit cdreplay -q
fi

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# fzf (native zsh integration since fzf 0.48+)
(( $+commands[fzf] )) && eval "$(fzf --zsh)"

# zoxide: `z` jumps to frecent dirs, `zi` picks with fzf
(( $+commands[zoxide] )) && eval "$(zoxide init zsh)"

# ============================================================
# Prompt
# ============================================================

# Starship (config: ~/.config/starship.toml, from the starship stow package)
(( $+commands[starship] )) && eval "$(starship init zsh)"

# ============================================================
# Aliases
# ============================================================

# --- Editor and config shortcuts ---
alias vim=nvim
alias zshconfig="nvim ~/.zshrc"
alias vimconfig="nvim ~/.vimrc"
alias tmuxconfig="nvim ~/.config/tmux/tmux.conf"
alias mux=tmuxinator

# --- Files and navigation ---
alias ls="eza -l --git --group-directories-first"
alias lt="eza --tree --level=2 --git-ignore"
alias cl="clear"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# --- Git ---
alias gsw='git switch'
alias gs='git status'
alias gc='git commit -m'
alias gp='git push'
alias grm='git rm $(git ls-files --deleted)'
alias gpr='git pull --rebase'
alias gch='git checkout'
alias gph='git push'
alias ga='git add . && git status'
alias gl='git log --oneline'
alias gb='git branch'
alias gk='git checkout'
alias gf='git fetch'
alias gmm='git merge main'
alias gclean='gk main && git pull && git branch | grep -v "main" | xargs git branch -d'
alias gstart='gk main && git pull && gk -b '

# --- Rails ---
alias rwvs='bundle exec rspec --exclude-pattern "**/views/*_spec.rb"'
alias credentials='EDITOR="nvim" rails credentials:edit'

# --- AWS / k8s ---
alias awslogin="aws sso login --profile sso"
alias kcontextqa="kubectl config use-context qa-002-cluster"
alias kcontextint="kubectl config use-context integration-002-cluster"
alias kcontextprod="kubectl config use-context prod-use1-001-cluster"
alias kcontextcanprod="kubectl config use-context can-prod-001-cluster"

# --- AI agents ---
alias claudio="claude"

# --- Media ---
if (( $+commands[ampcli] )); then
  alias qobuz="ampcli -Q"
  alias spotify="ampcli -S"
fi

# ============================================================
# Tool hooks (keep last)
# ============================================================

eval "$(direnv hook zsh)"
