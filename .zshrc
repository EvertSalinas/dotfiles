# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Example aliases
alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias vimconfig="nvim ~/.vimrc"
alias ls="command ls ${colorflag}"

# Quicker navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# tmuxinator shorthand
alias mux=tmuxinator

# Git aliases
# You must install Git first
alias gsw='git switch'
alias gs='git status'
alias gc='git commit -m' # requires you to type a commit message
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

# Vim
alias vim=nvim

# Git Autocomplete
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

export PATH="$HOME/Code/dotfiles/bin:$PATH";
export PATH=/usr/local/bin:$PATH
export PATH="/usr.local/bin/python3:$PATH"
export PATH="/opt/homebrew/opt/openssl@1.1/bin:$PATH"

export EDITOR='nvim'
export UID=$(id -u)
export GID=$(id -g)

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh  # This loads NVM
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export GPG_TTY=$(tty)

# Homebrew
export HOMEBREW_OPT="/opt/homebrew/opt"
export CFLAGS="-I/opt/homebrew/opt/imagemagick\@6/include/ImageMagick-6:$CFLAGS"
export CPPFLAGS="-I/opt/homebrew/opt/imagemagick@6/include:$CPPFLAGS"
export PKG_CONFIG_PATH="/opt/homebrew/opt/imagemagick@6/lib/pkgconfig:$PKG_CONFIG_PATH"
export PATH="/opt/homebrew/opt/imagemagick@6/bin:$PATH"
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# asdf
. "/opt/homebrew/opt/asdf/libexec/asdf.sh"
. "/opt/homebrew/opt/asdf/etc/bash_completion.d/asdf.bash"

eval "$(/opt/homebrew/bin/brew shellenv)"
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# Plugins
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
