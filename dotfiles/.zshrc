
# Oh-My-Zsh Configuration
# ------------------------
# Path to your oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Set the name of the theme to load
ZSH_THEME="bira"

# auto-update behavior
zstyle ':omz:update' mode auto # Update oh-my-zsh automatically

# Display red dots whilst waiting for completion
COMPLETION_WAITING_DOTS="true"

# Plugins
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Editor Preferences
# ------------------
# Preferred editor for local and remote sessions (consolidated)
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nano'
else
  export EDITOR='nano'
fi

# Path Cleanup
# ------------
# Remove duplicate entries from your $PATH
PATH="$(perl -e 'print join(":", grep { not $seen{$_}++ } split(/:/, $ENV{PATH}))')"

export PATH="/opt/homebrew/bin:$PATH"

# User Configuration
# ------------------
# Personal aliases
source ~/.aliases

# GitHub completion
compctl -K _gh gh
