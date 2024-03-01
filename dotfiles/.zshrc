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
new_path=""
IFS=":"
for dir in $PATH; do
  if [[ ! "${seen[$dir]}" ]]; then
    new_path="$new_path:$dir"
    seen[$dir]=true
  fi
done
export PATH="${new_path#:}"

# Place Homebrew's bin before user's bin
export PATH="/opt/homebrew/bin:$PATH"

# User Configuration
source ~/.aliases
compctl -K _gh gh
