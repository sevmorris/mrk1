\
#!/usr/bin/env bash
# clean-mac.sh — unified macOS cleanup (interactive, live by default)
set -euo pipefail
IFS=$'\n\t'

# Colors
if command -v tput >/dev/null 2>&1 && [[ -t 1 ]]; then
  green=$(tput setaf 2); yellow=$(tput setaf 3); red=$(tput setaf 1); bold=$(tput bold); reset=$(tput sgr0)
else
  green=""; yellow=""; red=""; bold=""; reset=""
fi
ok()   { printf "%s✓ %s%s\n" "$green" "$*" "$reset"; }
warn() { printf "%s⚠ %s%s\n" "$yellow" "$*" "$reset"; }
err()  { printf "%s✗ %s%s\n" "$red" "$*" "$reset" >&2; }

confirm() {
  local prompt="${1:-Proceed?} [y/N] "
  read -r -p "$prompt" ans || ans=""
  case "$ans" in
    y|Y|yes|YES) return 0 ;;
    *) return 1 ;;
  endesac
}

# Root password only when needed
need_sudo() {
  if [[ "${1:-}" == "--check" ]]; then
    sudo -n true 2>/dev/null || return 1
  else
    sudo -v
  fi
}

# --- Actions ---
brew_cleanup() {
  if command -v brew >/dev/null 2>&1; then
    if confirm "Run brew cleanup & autoremove?"; then
      brew cleanup -s || true
      brew autoremove || true
      ok "Brew cleanup done"
    else
      warn "Skipped brew cleanup"
    fi
  else
    warn "Homebrew not found; skipping"
  fi
}

purge_caches() {
  if confirm "Purge user caches under ~/Library/Caches?"; then
    rm -rf "${HOME}/Library/Caches/"* 2>/dev/null || true
    ok "Cleared user caches"
  else
    warn "Skipped cache purge"
  fi
}

purge_logs() {
  if confirm "Purge user logs under ~/Library/Logs?"; then
    rm -rf "${HOME}/Library/Logs/"* 2>/dev/null || true
    ok "Cleared user logs"
  else
    warn "Skipped log purge"
  fi
}

purge_venvs() {
  if confirm "Remove Python virtualenvs under ~/.venvs?"; then
    rm -rf "${HOME}/.venvs" 2>/dev/null || true
    ok "Removed ~/.venvs"
  else
    warn "Skipped virtualenv removal"
  fi
}

purge_node_pip() {
  if confirm "Clear pip and Corepack/Node caches?"; then
    pip cache purge 2>/dev/null || true
    rm -rf "${HOME}/Library/Caches/Corepack" "${HOME}/Library/Caches/npm" 2>/dev/null || true
    ok "Cleared pip and Node/Corepack caches"
  else
    warn "Skipped pip/Node cache purge"
  fi
}

box_legacy() {
  local BASE="${HOME}"
  if confirm "Remove legacy .Box_* folders in $BASE?"; then
    # find legacy folders
    mapfile -t BOX_LEGACY < <(find "$BASE" -maxdepth 2 -type d -name ".Box_*" 2>/dev/null || true)
    if [ -n "${BOX_LEGACY[*]-}" ] && [ "${#BOX_LEGACY[@]}" -gt 0 ]; then
      for d in "${BOX_LEGACY[@]}"; do
        echo "  - $d"
      done
      if confirm "Delete the folders above?"; then
        for d in "${BOX_LEGACY[@]}"; do rm -rf "$d"; done
        ok "Removed legacy Box folders"
      else
        warn "Skipped Box legacy removal"
      fi
    else
      ok "No legacy .Box_* folders found"
    fi
  else
    warn "Skipped Box legacy check"
  fi
}

main() {
  echo "${bold}macOS cleanup (interactive)${reset}"
  need_sudo || true

  brew_cleanup
  purge_caches
  purge_logs
  purge_venvs
  purge_node_pip
  box_legacy

  ok "Cleanup sequence finished"
}

main "$@"
