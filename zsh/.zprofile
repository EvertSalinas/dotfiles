if [[ -r ~/.profile ]]; then
  emulate sh
  source ~/.profile
  emulate zsh
fi

if [[ "$OSTYPE" == darwin* ]]; then
  # Setting PATH for Python 3.11
  # The original version is saved in .zprofile.pysave
  PATH="/Library/Frameworks/Python.framework/Versions/3.11/bin:${PATH}"
  export PATH

  # Setting PATH for Python 2.7
  # The original version is saved in .zprofile.pysave
  PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
  export PATH

  # Added by OrbStack: command-line tools and integration
  source ~/.orbstack/shell/init.zsh 2>/dev/null || :

  # Added by Obsidian
  export PATH="$PATH:/Applications/Obsidian.app/Contents/MacOS"
fi
