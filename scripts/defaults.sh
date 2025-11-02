#!/usr/bin/env bash
set -euo pipefail

# mrk1 defaults — apply minimal macOS defaults and generate a rollback script
# The goal: Only set a few sensible toggles and emit ~/.mrk1/defaults-rollback.sh
# so changes can be reversed.

ROLL_DIR="$HOME/.mrk1"
ROLLBACK="$ROLL_DIR/defaults-rollback.sh"
mkdir -p "$ROLL_DIR"
: > "$ROLLBACK"
chmod +x "$ROLLBACK"

log(){ printf "\033[1;34m[defaults]\033[0m %s\n" "$*"; }
backup_line(){ echo "$1" >> "$ROLLBACK"; }

# Helper: capture current value (if any) and append the inverse to rollback
# Usage: write_default <domain> <key> <type> <value>
write_default(){
  local domain="$1" key="$2" type="$3" value="$4"
  local current
  if current=$(defaults read "$domain" "$key" 2>/dev/null); then
    # produce a rollback that restores the previous type/value
    # (best effort: string/boolean/integer/float)
    case "$current" in
      true|false) backup_line "defaults write $domain $key -bool $current" ;;
      ''|*[!0-9]*) backup_line "defaults write $domain $key -string \"$current\"" ;;
      *) backup_line "defaults write $domain $key -int $current" ;;
    esac
  else
    # key did not exist; rollback deletes it
    backup_line "defaults delete $domain $key >/dev/null 2>&1 || true"
  fi
  # apply new value
  case "$type" in
    bool)   defaults write "$domain" "$key" -bool "$value" ;;
    int)    defaults write "$domain" "$key" -int "$value" ;;
    float)  defaults write "$domain" "$key" -float "$value" ;;
    string) defaults write "$domain" "$key" -string "$value" ;;
    *) echo "Unknown type: $type" >&2; exit 2 ;;
  esac
}

log "Applying minimal defaults…"

# --- Examples (edit/remove to taste) ---
# Show all filename extensions
write_default NSGlobalDomain AppleShowAllExtensions bool true
# Key repeat speed (lower is faster)
write_default NSGlobalDomain KeyRepeat int 2
write_default NSGlobalDomain InitialKeyRepeat int 15
# Save to disk (not iCloud) by default
write_default NSGlobalDomain NSDocumentSaveNewDocumentsToCloud bool false
# Expand save panel by default
write_default NSGlobalDomain NSNavPanelExpandedStateForSaveMode bool true
write_default NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 bool true

log "Writing rollback helper to $ROLLBACK"
backup_line "killall Finder >/dev/null 2>&1 || true"
backup_line "killall Dock >/dev/null 2>&1 || true"

# Apply immediate effects
killall Finder >/dev/null 2>&1 || true
killall Dock >/dev/null 2>&1 || true

log "Defaults applied. You can revert with: $ROLLBACK"
