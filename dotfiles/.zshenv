# ==============================================================================
# Shell Configuration
# ==============================================================================

# --- Language & Editor ---
# Set locale settings to prevent issues with certain commands.
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

# Set the default command-line editor.
export EDITOR='nano'
export VISUAL="$EDITOR"

# --- PATH Configuration ---
# Start with user-specific bin directories.
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# --- Homebrew Integration ---
# Check if Homebrew is installed and add it to the PATH.
# Using 'command -v' is more robust than hardcoding a path.
if command -v brew &>/dev/null; then
  BREW_PREFIX="$(brew --prefix)"
  # Prepend Homebrew's paths for executables and man pages.
  export PATH="$BREW_PREFIX/bin:$BREW_PREFIX/sbin:$PATH"
  export MANPATH="$BREW_PREFIX/share/man:$MANPATH"
fi

# --- Python Integration ---
# Find and add the latest python.org version to the PATH.
# This avoids hardcoding a specific version like '3.10'.
PYTHON_FRAMEWORK_DIR="/Library/Frameworks/Python.framework/Versions"
if [[ -d "$PYTHON_FRAMEWORK_DIR" ]]; then
  # Find the latest version directory (e.g., 3.12)
  LATEST_PYTHON_VERSION=$(ls "$PYTHON_FRAMEWORK_DIR" | sort -V | tail -n 1)
  LATEST_PYTHON_PATH="$PYTHON_FRAMEWORK_DIR/$LATEST_PYTHON_VERSION"

  # Add its 'bin' directory to the PATH if it exists.
  if [[ -d "$LATEST_PYTHON_PATH/bin" ]]; then
    export PATH="$LATEST_PYTHON_PATH/bin:$PATH"
  fi
fi

# Pro Tip for Zsh users: To remove duplicate entries from your PATH,
# add the following line at the very end of your .zshrc file.
# typeset -U path
