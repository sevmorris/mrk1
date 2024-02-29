
# ========= LANGUAGE & EDITOR CONFIGURATION =========
LANG='en_US.UTF-8'     # Set locale to US English for consistent text handling
LC_ALL='en_US.UTF-8'   # Override locale settings for UTF-8 character encoding
EDITOR='nano'           # Set 'nano' as the default text editor
VISUAL="$EDITOR"        # Use the same editor for visual mode commands

# ========= CUSTOM PATH CONFIGURATION =========
# Add private bin directories to the beginning of the PATH for priority
for dir in "$HOME/bin" "$HOME/.local/bin"; do
  if [ -d "$dir" ]; then  # Check if the directory exists
    PATH="$dir:$PATH"     # Prepend the directory to PATH
  fi
done

# ========= HOMEBREW CONFIGURATION  =========
BREW_BIN="/opt/homebrew/bin/brew"  # Path to the 'brew' command

if type "$BREW_BIN" &>/dev/null; then  # Check if Homebrew is installed
  BREW_PREFIX="$("$BREW_BIN" --prefix)"  # Get Homebrew's installation prefix

  # Prioritize Homebrew binaries in PATH
  PATH="$BREW_PREFIX/sbin:$BREW_PREFIX/bin:$BREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH"

  # Ensure Homebrew manual pages are accessible
  MANPATH="$BREW_PREFIX/share/man:$MANPATH"
fi

# ========= PYTHON-RELATED PATHS =========
PATH="/Library/Frameworks/Python.framework/Versions/3.10/bin:$PATH"  # Add Python 3.10 framework binaries
PATH="/usr/local/opt/python/libexec/bin:$PATH"                     # Add Python installations from /usr/local/optss

# ========= DISPLAY SYSTEM INFORMATION =========
neofetch                                 # Display system information using neofetch
