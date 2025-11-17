#!/usr/bin/env bash
set -euo pipefail

# mrk1 defaults - apply minimal defaults and generate a rollback script

ROLL_DIR="$HOME/.mrk1"
ROLLBACK="$ROLL_DIR/defaults-rollback.sh"

# Create rollback directory and script with error checking
if ! mkdir -p "$ROLL_DIR"; then
  echo "Error: Failed to create rollback directory: $ROLL_DIR" >&2
  exit 1
fi

if ! : > "$ROLLBACK" || ! chmod +x "$ROLLBACK"; then
  echo "Error: Failed to initialize rollback script: $ROLLBACK" >&2
  exit 1
fi

log(){ printf "[defaults] %s\n" "$*"; }
backup_line(){ echo "$1" >> "$ROLLBACK"; }

# Helper: capture current value (if any) and append the inverse to rollback
# Usage: write_default <domain> <key> <type> <value>
write_default(){
  local domain="$1" key="$2" type="$3" value="$4"
  local current
  if current=$(defaults read "$domain" "$key" 2>/dev/null); then
    case "$current" in
      true|false) backup_line "defaults write $domain $key -bool $current" ;;
      ''|*[!0-9]*) backup_line "defaults write $domain $key -string \"$current\"" ;;
      *) backup_line "defaults write $domain $key -int $current" ;;
    esac
  else
    backup_line "defaults delete $domain $key >/dev/null 2>&1 || true"
  fi
  case "$type" in
    bool)   defaults write "$domain" "$key" -bool "$value" || return 1 ;;
    int)    defaults write "$domain" "$key" -int "$value" || return 1 ;;
    float)  defaults write "$domain" "$key" -float "$value" || return 1 ;;
    string) defaults write "$domain" "$key" -string "$value" || return 1 ;;
    *) log "Unknown type: $type" >&2; return 1 ;;
  esac
}

log "Applying minimal defaults..."

# Track failures
failed=0

# Show all filename extensions
write_default NSGlobalDomain AppleShowAllExtensions bool true || ((failed++))
# Key repeat speed (lower is faster)
write_default NSGlobalDomain KeyRepeat int 2 || ((failed++))
write_default NSGlobalDomain InitialKeyRepeat int 15 || ((failed++))
# Save to disk (not iCloud) by default
write_default NSGlobalDomain NSDocumentSaveNewDocumentsToCloud bool false || ((failed++))
# Expand save panel by default
write_default NSGlobalDomain NSNavPanelExpandedStateForSaveMode bool true || ((failed++))
write_default NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 bool true || ((failed++))

if (( failed > 0 )); then
  log "Warning: $failed default(s) failed to apply"
fi

log "Writing rollback helper to $ROLLBACK"
backup_line "killall Finder >/dev/null 2>&1 || true"
backup_line "killall Dock >/dev/null 2>&1 || true"

# Apply immediate effects
killall Finder >/dev/null 2>&1 || true
killall Dock >/dev/null 2>&1 || true

log "Defaults applied. You can revert with: $ROLLBACK"
