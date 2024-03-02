#!/usr/bin/env zsh

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

source "$ZSH/oh-my-zsh.sh"

# Editor Preference (simplified)
export EDITOR=nano  # Default editor; SSH sessions will override if needed

# Path Cleanup
export PATH=$(perl -e 'print join(":", grep { not $seen{$_}++ } split(/:/, $ENV{PATH}))')

# Place Homebrew's bin before the user's bin
export PATH="/opt/homebrew/bin:$PATH"

# User Configuration
source "$HOME/.aliases"
compctl -K _gh gh  # Assuming `_gh` is a completion function for the `gh` command
