# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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

# --- zinit ---
ZINIT_HOME="$HOME/.local/share/zinit/zinit.git"
if [[ -r "$ZINIT_HOME/zinit.zsh" ]]; then
  source "$ZINIT_HOME/zinit.zsh"

  zinit ice depth=1
  zinit light romkatv/powerlevel10k

  zinit light zsh-users/zsh-autosuggestions
  zinit light zsh-users/zsh-completions

  # syntax-highlighting must be loaded last among zle-touching plugins
  zinit light zsh-users/zsh-syntax-highlighting
fi

# --- Completion ---
autoload -Uz compinit
compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
(( $+functions[zinit] )) && zinit cdreplay -q

# fzf (native zsh integration since fzf 0.48+)
(( $+commands[fzf] )) && eval "$(fzf --zsh)"

# Vi mode for editing the command line
bindkey -v
export KEYTIMEOUT=20  # ms to wait for a multi-key sequence (esc -> normal mode) before acting

# Cursor shape reflects vi mode: block = normal, beam = insert
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]]; then
    echo -ne '\e[2 q'  # block
  else
    echo -ne '\e[6 q'  # beam
  fi
}
zle -N zle-keymap-select

function zle-line-init {
  echo -ne '\e[6 q'  # start each new prompt in insert (beam)
}
zle -N zle-line-init

# Let backspace delete past where insert mode started
bindkey -M viins '^?' backward-delete-char

# ctrl-r for history search even in normal mode
bindkey -M vicmd '^r' history-incremental-search-backward

# 'v' in normal mode opens the current command line in $EDITOR
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'v' edit-command-line

alias zshconfig="nvim ~/.zshrc"
alias vimconfig="nvim ~/.vimrc"
alias tmuxconfig="nvim ~/.config/tmux/tmux.conf"
alias ls="eza -l --git --group-directories-first"
alias lt="eza --tree --level=2 --git-ignore"
alias cl="clear"

# Navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

alias mux=tmuxinator

# Git
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

# Rails
alias rwvs='bundle exec rspec --exclude-pattern "**/views/*_spec.rb"'
alias credentials='EDITOR="nvim" rails credentials:edit'

alias vim=nvim

# AWS / k8s
alias awslogin="aws sso login --profile sso"
alias kcontextqa="kubectl config use-context qa-002-cluster"
alias kcontextint="kubectl config use-context integration-002-cluster"
alias kcontextprod="kubectl config use-context prod-use1-001-cluster"
alias kcontextcanprod="kubectl config use-context can-prod-001-cluster"

alias claudio="claude"

# Media
if (( $+commands[ampcli] )); then
  alias qobuz="ampcli -Q"
  alias spotify="ampcli -S"
fi

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

export PATH="$HOME/Code/dotfiles/bin:$PATH"
export PATH=/usr/local/bin:$PATH
export PATH="/usr/local/bin/python3:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# migite vault root (default changed from ~/Documents/MasterVault/dev-log to
# the portable ~/dev-log — this pins it back to the existing Obsidian vault)
export DEV_LOG_BASE="$HOME/Documents/MasterVault/dev-log"

export EDITOR='nvim'
export UID=$(id -u)
export GID=$(id -g)
export GPG_TTY=$(tty)
export TERM=xterm-256color

# NVM
[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

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

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

eval "$(direnv hook zsh)"
