# ==============================================================================
#  .zshrc: Sourced for INTERACTIVE shells.
# ==============================================================================

# --- Oh-My-Zsh (OMZ) Configuration ---
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="bira"
zstyle ':omz:update' mode auto
COMPLETION_WAITING_DOTS="true"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting z colored-man-pages command-not-found gh)

# Load Oh My Zsh.
source "$ZSH/oh-my-zsh.sh"

# --- PATH Customization ---
# Add user-specific and Python paths. Assumes Homebrew path is set in .zprofile.

# Add user-local binaries
path=(
  "$HOME/bin"
  "$HOME/.local/bin"
  $path
)

# Find and add the latest python.org version
PYTHON_FRAMEWORK_DIR="/Library/Frameworks/Python.framework/Versions"
if [[ -d "$PYTHON_FRAMEWORK_DIR" ]]; then
  LATEST_PYTHON_VERSION=$(ls "$PYTHON_FRAMEWORK_DIR" | sort -V | tail -n 1)
  LATEST_PYTHON_PATH="$PYTHON_FRAMEWORK_DIR/$LATEST_PYTHON_VERSION"
  if [[ -d "$LATEST_PYTHON_PATH/bin" ]]; then
    path=("$LATEST_PYTHON_PATH/bin" $path)
  fi
fi

# Use Zsh's built-in 'typeset' to remove any duplicate entries.
typeset -U path

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
# >>> mrk1 brew shellenv >>>
# Ensure Homebrew is on PATH (Apple Silicon first, then Intel)
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi
# <<< mrk1 brew shellenv <<<

# >>> mrk1 PATH >>>
[ -d "$HOME/.local/bin" ] && case ":$PATH:" in *":$HOME/.local/bin:"*) ;; *) export PATH="$HOME/.local/bin:$PATH";; esac
# <<< mrk1 PATH <<<
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
