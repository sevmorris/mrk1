# ==============================================================================
#  .zshrc: Sourced for INTERACTIVE shells.
# ==============================================================================

# --- PATH Management ---
# The 'path' array is tied to the $PATH variable in Zsh.
# We modify this array, then de-duplicate it at the end.

# Start with user-specific bin directories.
path=(
  "$HOME/bin"
  "$HOME/.local/bin"
  $path
)

# Add Homebrew and its installed packages to the PATH.
if command -v brew &>/dev/null; then
  BREW_PREFIX="$(brew --prefix)"
  path=(
    "$BREW_PREFIX/bin"
    "$BREW_PREFIX/sbin"
    "$BREW_PREFIX/opt/coreutils/libexec/gnubin" # GNU coreutils
    $path
  )
  export MANPATH="$BREW_PREFIX/share/man:$MANPATH"
fi

# Find and add the latest python.org version to the PATH.
PYTHON_FRAMEWORK_DIR="/Library/Frameworks/Python.framework/Versions"
if [[ -d "$PYTHON_FRAMEWORK_DIR" ]]; then
  LATEST_PYTHON_VERSION=$(ls "$PYTHON_FRAMEWORK_DIR" | sort -V | tail -n 1)
  LATEST_PYTHON_PATH="$PYTHON_FRAMEWORK_DIR/$LATEST_PYTHON_VERSION"
  if [[ -d "$LATEST_PYTHON_PATH/bin" ]]; then
    path=("$LATEST_PYTHON_PATH/bin" $path)
  fi
fi

# Use Zsh's built-in 'typeset' to remove duplicate entries from the PATH.
typeset -U path

# --- Oh-My-Zsh (OMZ) Configuration ---
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="bira"
zstyle ':omz:update' mode auto
COMPLETION_WAITING_DOTS="true"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting z colored-man-pages command-not-found gh)

# Load Oh My Zsh. This must come AFTER setting variables and PATH.
source "$ZSH/oh-my-zsh.sh"

# --- Source Personal Aliases ---
if [[ -f "$HOME/.aliases" ]]; then
  source "$HOME/.aliases"
fi

# --- Node Version Manager (NVM) - Lazy Loaded for Speed ---
export NVM_DIR="$HOME/.nvm"
lazy_load_nvm() {
  unset -f nvm node npm npx
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  "$@"
}
nvm()   { lazy_load_nvm nvm "$@"; }
node()  { lazy_load_nvm node "$@"; }
npm()   { lazy_load_nvm npm "$@"; }
npx()   { lazy_load_nvm npx "$@"; }

# --- Shell Welcome Message ---
fastfetch
