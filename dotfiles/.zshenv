#!/usr/bin/env zsh

# ========= LANGUAGE & EDITOR CONFIGURATION =========
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'
export EDITOR='nano'
export VISUAL="$EDITOR"

# ========= PATH CONFIGURATION =========
export BREW_BIN="/opt/homebrew/bin/brew"
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# ========= HOMEBREW CONFIGURATION =========
if type "$BREW_BIN" &>/dev/null; then
    BREW_PREFIX="$("$BREW_BIN" --prefix)"
    export PATH="$BREW_PREFIX/sbin:$BREW_PREFIX/bin:$BREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH"
    export MANPATH="$BREW_PREFIX/share/man:$MANPATH"
fi

# ========= PYTHON =========
add_to_path_if_exists() {
    local dir="$1"
    if [ -d "$dir" ] && [ -x "$dir/bin" ]; then
        PATH="$dir/bin:$PATH"
    fi
}

add_to_path_if_exists "/Library/Frameworks/Python.framework/Versions/3.10"
add_to_path_if_exists "/usr/local/opt/python/libexec"
