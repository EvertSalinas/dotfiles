### Theme
export ZSH="/Users/evertsalinas/.oh-my-zsh"
ZSH_THEME="robbyrussell"
source $ZSH/oh-my-zsh.sh

### Aliases
# rv muse ruby-2.0.0-p353
source ~/.profile
source ~/.nvm/nvm.sh
# Open specified files in atom
# Color LS
colorflag="-G"
alias ls="command ls ${colorflag}"
alias l="ls -lF ${colorflag}" # all files, in long format
alias la="ls -laF ${colorflag}" # all files inc dotfiles, in long format
alias lsd='ls -lF ${colorflag} | grep "^d"' # only directories
# Quicker navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
# Enable aliases to be sudo'ed
alias sudo='sudo '
# Colored up cat!
# You must install Pygments first - "sudo easy_install Pygments"
# alias c='pygmentize -O style=monokai -f console256 -g'
# tmuxinator shorthand
alias mux=tmuxinator

# Git
# You must install Git first
alias gs='git status'
alias ga='git add .'
alias gc='git commit -m' # requires you to type a commit message
alias gp='git push'
alias grm='git rm $(git ls-files --deleted)'
alias gpr='git pull --rebase'
alias gch='git checkout'

# Git Autocomplete
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# Rails
alias rwss='bundle exec rspec --exclude-pattern "**/system/*_spec.rb"'
alias rwvs='bundle exec rspec --exclude-pattern "**/views/*_spec.rb"'
alias encred='EDITOR="vim --wait" rails credentials:edit'

export PATH="$HOME/Code/dotfiles/bin:$PATH";
export PATH=/usr/local/bin:$PATH
export PATH="/usr/local/opt/openssl@1.0/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
export PATH="/usr/local/opt/postgresql@12/bin:$PATH"
export PATH=/opt/homebrew/bin:$PATH
export PATH="/usr.local/bin/python3:$PATH"

export EDITOR='vim'
export DISABLE_SPRING=1

eval "$(rbenv init -)"
eval "$(/opt/homebrew/bin/brew shellenv)"
