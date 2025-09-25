# Add Homebrew to your PATH
eval "$(/opt/homebrew/bin/brew shellenv)"

# >>> mrk1 PATH >>>
[ -d "$HOME/.local/bin" ] && case ":$PATH:" in *":$HOME/.local/bin:"*) ;; *) export PATH="$HOME/.local/bin:$PATH";; esac
# <<< mrk1 PATH <<<
