
# ========= LANGUAGE & EDITOR CONFIGURATION =========
export LANG='en_US.UTF-8'       # Prefer US English
export LC_ALL='en_US.UTF-8'     # Use UTF-8 encoding
export EDITOR='nano'            # Default text editor
export VISUAL="$EDITOR"          # Align with 'EDITOR'

# ========= PATH CONFIGURATION =========
# Prioritize private bin directories
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# ========= HOMEBREW CONFIGURATION =========
export BREW_BIN="/opt/homebrew/bin/brew"

if type "$BREW_BIN" &>/dev/null; then
  export BREW_PREFIX="$("$BREW_BIN" --prefix)"
  export PATH="$BREW_PREFIX/sbin:$BREW_PREFIX/bin:$BREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH"
  export MANPATH="$BREW_PREFIX/share/man:$MANPATH"
fi

# ========= PYTHON (Consolidate with checks) =========
if [ -d "/Library/Frameworks/Python.framework/Versions/3.10" ] && [ -x "/Library/Frameworks/Python.framework/Versions/3.10/bin" ]; then
  PATH="/Library/Frameworks/Python.framework/Versions/3.10/bin:$PATH"
fi

if [ -d "/usr/local/opt/python/libexec/bin" ] && [ -x "/usr/local/opt/python/libexec/bin" ]; then
  PATH="/usr/local/opt/python/libexec/bin:$PATH"
fi
