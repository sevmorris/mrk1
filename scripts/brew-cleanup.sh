#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# One-shot Homebrew cleanup aligned to your assets/Brewfile.
# - Applies Brewfile to ensure keepers are pinned first
# - Removes anything not in Brewfile
# - Autoremoves unused dependencies
# - Cleans old downloads/versions
# - Shows doctor/missing status at the end
#
# Usage:
#   ./scripts/brew-cleanup.sh            # uses ./assets/Brewfile
#   ./scripts/brew-cleanup.sh /path/to/Brewfile

BREWFILE="${1:-./assets/Brewfile}"

err()  { printf "\033[31m✗ %s\033[0m\n" "$*" >&2; }
ok()   { printf "\033[32m✓ %s\033[0m\n" "$*"; }
warn() { printf "\033[33m⚠ %s\033[0m\n" "$*"; }

if ! command -v brew >/dev/null 2>&1; then
  err "Homebrew not found on PATH."
  exit 1
fi

if [[ ! -f "$BREWFILE" ]]; then
  err "Brewfile not found at: $BREWFILE"
  exit 1
fi

echo "→ Using Brewfile: $BREWFILE"

# 1) Apply the Brewfile (ensures keepers are present/updated)
ok "Applying Brewfile (this may install or upgrade packages)…"
brew bundle --file "$BREWFILE"

# 2) Preview removals before forcing
ok "Previewing cleanup (packages not in the Brewfile)…"
brew bundle cleanup --file "$BREWFILE" || true

read -r -p "Proceed with removal of the above packages? [y/N] " ans
if [[ "${ans:-N}" =~ ^[Yy]$ ]]; then
  ok "Removing packages not present in Brewfile…"
  brew bundle cleanup --file "$BREWFILE" --force || true
else
  warn "Skipped forced removal step."
fi

# 3) Remove lingering, no-longer-needed dependencies
ok "Autoremoving orphaned dependencies…"
brew autoremove || true

# 4) Remove old downloads, old versions, caches
ok "Running brew cleanup…"
brew cleanup || true

# 5) Show status
echo
ok "Final checks:"
brew doctor || true
brew missing || true

echo
ok "Done. Your Homebrew tree should now match $BREWFILE."
