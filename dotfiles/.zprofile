# Add Homebrew to your PATH
eval "$(/opt/homebrew/bin/brew shellenv)"

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
