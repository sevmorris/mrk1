# ==============================================================================
#  .zshrc — Sourced for INTERACTIVE shells
#  Maintainer: Seven Morris
#  Rev: 2025-10-19
# ==============================================================================

# --- Oh My Zsh (OMZ) Configuration ---
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="bira"
zstyle ':omz:update' mode auto
COMPLETION_WAITING_DOTS="true"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting z colored-man-pages command-not-found gh)

# Load Oh My Zsh
source "$ZSH/oh-my-zsh.sh"

# --- PATH Customization ---
# Add user-specific and Python paths. Homebrew path is set in .zprofile.

path=(
  "$HOME/bin"
  "$HOME/.local/bin"
  $path
)

# Add latest python.org version to PATH, if present
PYTHON_FRAMEWORK_DIR="/Library/Frameworks/Python.framework/Versions"
if [[ -d "$PYTHON_FRAMEWORK_DIR" ]]; then
  LATEST_PYTHON_VERSION=$(ls "$PYTHON_FRAMEWORK_DIR" | sort -V | tail -n 1)
  LATEST_PYTHON_PATH="$PYTHON_FRAMEWORK_DIR/$LATEST_PYTHON_VERSION"
  if [[ -d "$LATEST_PYTHON_PATH/bin" ]]; then
    path=("$LATEST_PYTHON_PATH/bin" $path)
  fi
fi

# Remove duplicate path entries
typeset -U path

# --- Source Personal Aliases ---
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

# --- Homebrew Environment (mrk1 convention) ---
# Ensure Homebrew is on PATH (Apple Silicon first, then Intel)
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# --- PATH Enforcement (mrk1 convention) ---
[ -d "$HOME/.local/bin" ] && case ":$PATH:" in
  *":$HOME/.local/bin:"*) ;;
  *) export PATH="$HOME/.local/bin:$PATH";;
esac
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# --- NVM (lazy load, prefers Homebrew) ---
export NVM_DIR="$HOME/.nvm"

# Choose the cleanest available nvm.sh (Homebrew first)
_nvm_source=""
if [ -s "/opt/homebrew/opt/nvm/nvm.sh" ]; then
  _nvm_source="/opt/homebrew/opt/nvm/nvm.sh"
elif [ -s "$NVM_DIR/nvm.sh" ]; then
  _nvm_source="$NVM_DIR/nvm.sh"
fi
unset NVM_CD_FLAGS 2>/dev/null  # keep env tidy

# Install lightweight shims that load NVM only on demand
if ! typeset -f nvm >/dev/null; then
  _nvm_lazy_load() {
    if [ -z "$_nvm_source" ]; then
      printf "%s\n" "nvm lazy-loader: no valid nvm.sh found. Check Homebrew or ~/.nvm." >&2
      return 1
    fi
    # Load NVM once
    . "$_nvm_source"
    # Optional: completions (Homebrew path only)
    [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \
      . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
    unset -f nvm node npm npx _nvm_lazy_load
    "$@"
  }
  nvm()  { _nvm_lazy_load nvm "$@"; }
  node() { _nvm_lazy_load node "$@"; }
  npm()  { _nvm_lazy_load npm "$@"; }
  npx()  { _nvm_lazy_load npx "$@"; }
fi

# --- Shell Welcome ---
fastfetch

# >>> mrk1 PATH >>>
[ -d "$HOME/.local/bin" ] && case ":$PATH:" in *":$HOME/.local/bin:"*) ;; *) export PATH="$HOME/.local/bin:$PATH";; esac
# <<< mrk1 PATH <<<

# --- mrk1: ensure ~/.local/bin is on PATH (idempotent) ---
if [ -d "$HOME/.local/bin" ]; then
  case ":$PATH:" in
    *":$HOME/.local/bin:"*) ;;
    *) export PATH="$HOME/.local/bin:$PATH" ;;
  esac
fi
