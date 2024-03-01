#_________________________//Personal zshrc for//_______________________________#
#______      ______                                           _           _____#
#_____      / ____ \________ _   ______ ___  ____  __________(_)____       ____#
#____      / / __ `/ ___/ _ \ | / / __ `__ \/ __ \/ ___/ ___/ / ___/      _____#
#___      / / /_/ (__  )  __/ |/ / / / / / / /_/ / /  / /  / (__  )      ______#
#____     \ \__,_/____/\___/|___/_/ /_/ /_/\____/_/  /_/  /_/____/      _______#
#_____     \____/                                                      ________#
#______________________________________________________________________________#

# Oh-My-Zsh Configuration
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="bira"
zstyle ':omz:update' mode auto  # Automatic updates
COMPLETION_WAITING_DOTS="true"

# Plugins
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Editor Preference (simplified)
export EDITOR=nano  # Default editor, SSH sessions will override if needed

# Path Cleanup
export PATH=$(perl -e 'print join(":", grep { not $seen{$_}++ } split(/:/, $ENV{PATH}))')

# Place Homebrew's bin before user's bin
export PATH="/opt/homebrew/bin:$PATH"

# User Configuration
source ~/.aliases
compctl -K _gh gh
