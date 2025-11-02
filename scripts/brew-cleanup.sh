\
#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

err() { printf "\033[31m✗ %s\033[0m\n" "$*" >&2; }
ok() { printf "\033[32m✓ %s\033[0m\n" "$*"; }
warn() { printf "\033[33m⚠ %s\033[0m\n" "$*"; }

BREWFILE="${1:-./assets/Brewfile}"

if ! command -v brew >/dev/null 2>&1; then
  err "Homebrew not installed"
  exit 2
fi

brew cleanup -s || true
brew autoremove || true
ok "Brew cleanup complete"
