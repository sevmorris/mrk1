#!/usr/bin/env bash
set -euo pipefail

# mrk1 hardening — opt-in security tweaks with rollback (inspired by Strap)

ROLL_DIR="$HOME/.mrk1"
ROLL="$ROLL_DIR/hardening-rollback.sh"
mkdir -p "$ROLL_DIR"; : > "$ROLL"; chmod +x "$ROLL"

log(){ printf "[hardening] %s\n" "$*"; }
rollback(){ echo "$*" >> "$ROLL"; }

have_sudo=false
if command -v sudo >/dev/null 2>&1; then
  if sudo -n true 2>/dev/null; then have_sudo=true; else have_sudo=true; fi
fi

# 1) Touch ID for sudo (pam_tid)
if $have_sudo; then
  if ! grep -q 'pam_tid.so' /etc/pam.d/sudo; then
    log "Enabling Touch ID for sudo"
    sudo cp /etc/pam.d/sudo /etc/pam.d/sudo.backup.mrk1
    rollback "sudo mv /etc/pam.d/sudo.backup.mrk1 /etc/pam.d/sudo"
    tmpfile="$(mktemp)"
    { echo 'auth       sufficient     pam_tid.so'; cat /etc/pam.d/sudo; } > "$tmpfile"
    sudo cp "$tmpfile" /etc/pam.d/sudo
    rm -f "$tmpfile"
  else
    log "Touch ID for sudo already enabled"
  fi
else
  log "Skipping Touch ID (sudo unavailable)"
fi

# 2) Require password immediately after sleep/screensaver
log "Requiring password immediately on wake"
prev1=$(defaults read com.apple.screensaver askForPassword 2>/dev/null || echo "0")
prev2=$(defaults read com.apple.screensaver askForPasswordDelay 2>/dev/null || echo "0")
rollback "defaults write com.apple.screensaver askForPassword -int ${prev1:-0}"
rollback "defaults write com.apple.screensaver askForPasswordDelay -int ${prev2:-0}"
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# 3) Enable firewall (global + stealth)
if $have_sudo; then
  log "Enabling macOS firewall (global on, stealth on)"
  prev=$(/usr/libexec/ApplicationFirewall/socketfilterfw --getglobalstate | awk '{print $3}')
  rollback "/usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate ${prev:-off}"
  sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on
  sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on
else
  log "Skipping firewall changes (sudo unavailable)"
fi

log "Hardening done. Rollback: $ROLL"
