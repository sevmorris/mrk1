# ------------------------------------------------------------------------------
# Oh-My-Zsh (OMZ) Configuration
# ------------------------------------------------------------------------------
# This must be defined before OMZ is sourced.
export ZSH="$HOME/.oh-my-zsh"

# Theme and update settings.
ZSH_THEME="bira"
zstyle ':omz:update' mode auto      # Automatically update without prompting.
COMPLETION_WAITING_DOTS="true"     # Show dots while waiting for completions.

# Enabled OMZ plugins.
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  z
  colored-man-pages
  command-not-found
  gh # The 'gh' plugin handles completions automatically.
)

# Load Oh My Zsh.
source "$ZSH/oh-my-zsh.sh"

# ------------------------------------------------------------------------------
# PATH Management
# ------------------------------------------------------------------------------
# The 'path' array is tied to the $PATH variable in Zsh.
# Prepending to the array adds the entry to the beginning of $PATH.

# Add Homebrew and its installed packages to the PATH.
path=(
  /opt/homebrew/bin
  /opt/homebrew/opt/coreutils/libexec/gnubin
  $path
)

# Use Zsh's built-in 'typeset' to remove duplicate entries from the PATH.
# This is faster and more reliable than external tools like perl or awk.
typeset -U path

# ------------------------------------------------------------------------------
# Aliases and Editor
# ------------------------------------------------------------------------------
# Source personal aliases.
if [[ -f "$HOME/.aliases" ]]; then
  source "$HOME/.aliases"
fi

# Set the default command-line editor.
export EDITOR=nano

# ------------------------------------------------------------------------------
# Node Version Manager (NVM) - Lazy Loaded for Speed
# ------------------------------------------------------------------------------
# Avoid loading NVM on every shell startup. Instead, load it the first
# time you call 'nvm', 'node', 'npm', etc.
export NVM_DIR="$HOME/.nvm"

lazy_load_nvm() {
  # Unset the function and aliases to prevent this from running again.
  unset -f nvm node npm npx
  # Source the real NVM script.
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  # Call the command that was originally intended.
  "$@"
}

# Create functions that will trigger the lazy load.
nvm()   { lazy_load_nvm nvm "$@"; }
node()  { lazy_load_nvm node "$@"; }
npm()   { lazy_load_nvm npm "$@"; }
npx()   { lazy_load_nvm npx "$@"; }

# ------------------------------------------------------------------------------
# Shell Welcome Message
# ------------------------------------------------------------------------------
# Note: Running commands here will slow down every new terminal window.
fastfetch
