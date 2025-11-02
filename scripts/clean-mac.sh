#!/usr/bin/env bash
# ==============================================================================
# clean-mac.sh v1.6 — System Hygiene Cleanup (interactive, live-by-default)
# Uses $HOME (user-agnostic)
# Uses $HOME (user-agnostic)
# Live mode by default; prompts before each step.
# Color-coded, no timestamps or emojis.
# ==============================================================================

set -euo pipefail

BASE="${HOME}"

# --- ANSI Colors ---------------------------------------------------------------
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
RESET="\033[0m"

header() { echo -e "\n${BLUE}== $1 ==${RESET}"; }
ok() { echo -e "  ${GREEN}$1${RESET}"; }
warn() { echo -e "  ${YELLOW}$1${RESET}"; }

confirm() {
  # confirm "Message"
  local prompt="${1:-Proceed?}"
  local ans
  read -r -p "$prompt [Y/n] " ans || ans="y"
  case "${ans:-y}" in
    Y|y|yes|YES) return 0 ;;
    *)           return 1 ;;
  esac
}

echo -e "${RED}LIVE mode — actions will modify files on disk.${RESET}"

# ------------------------------------------------------------------------------
header "Checking cache directories"
if confirm "Remove common caches under $BASE?"; then
  CACHES=(
    "$BASE/.npm/_cacache"
    "$BASE/.dropbox/Crashpad"
    "$BASE/.dropbox/logs"
    "$BASE/.oh-my-zsh/cache"
    "$BASE/.cache/huggingface"
    "$BASE/.cache/node"
    "$BASE/Library/Caches/pip"
  )
  for c in "${CACHES[@]}"; do
      if [ -d "$c" ]; then
          size=$(du -sh "$c" 2>/dev/null | awk '{print $1}')
          warn "Cache: $c [$size]"
          rm -rf "$c" && ok "Removed: $c"
      else
          ok "Clean: $c"
      fi
  done
else
  warn "Skipped cache removal"
fi

# ------------------------------------------------------------------------------
header "Checking log directories"
if confirm "Prune logs older than 30 days?"; then
  LOGS=(
    "$BASE/.mrk1/logs"
    "$BASE/.npm/_logs"
    "$BASE/Library/Logs"
  )
  for l in "${LOGS[@]}"; do
      if [ -d "$l" ]; then
          size=$(du -sh "$l" 2>/dev/null | awk '{print $1}')
          warn "Logs present: $l [$size]"
          find "$l" -type f -mtime +30 -delete && ok "Pruned old logs in: $l"
      else
          ok "No logs: $l"
      fi
  done
else
  warn "Skipped log pruning"
fi

# ------------------------------------------------------------------------------
header "Obsolete Box / Dropbox engine folders"
if confirm "Remove legacy .Box_* folders in $BASE?"; then
  BOX_LEGACY_LIST=$(find "$BASE" -maxdepth 1 -type d -name ".Box_*" 2>/dev/null || true)
if [ -n "$BOX_LEGACY_LIST" ]; then
    IFS=$'
'
    for d in $BOX_LEGACY_LIST; do
        warn "Legacy Box folder: $d"
        rm -rf "$d" && ok "Removed: $d"
    done
    unset IFS
else
    ok "No legacy Box folders found"
fiif [ "${#BOX_LEGACY[@]}" -gt 0 ]; then
      for d in "${BOX_LEGACY[@]}"; do
          warn "Legacy Box folder: $d"
          rm -rf "$d" && ok "Removed: $d"
      done
  else
      ok "No legacy Box folders found"
  fi
else
  warn "Skipped Box cleanup"
fi

# ------------------------------------------------------------------------------
header "Python virtual environments"
if confirm "Remove all virtual environments under $BASE/.venvs?"; then
  if [ -d "$BASE/.venvs" ]; then
      count=$(find "$BASE/.venvs" -mindepth 1 -maxdepth 1 -type d | wc -l | tr -d ' ')
      warn "Found $count virtual environment(s)"
      rm -rf "$BASE/.venvs" && ok "Removed $BASE/.venvs"
  else
      ok "No virtual environments found"
  fi
else
  warn "Skipped venv removal"
fi

# ------------------------------------------------------------------------------
header "Homebrew maintenance"
if confirm "Run brew cleanup/autoremove?"; then
  if command -v brew >/dev/null 2>&1; then
      brew cleanup --prune=all -q || true
      brew autoremove -q || true
      ok "Homebrew cleanup completed"
  else
      ok "Homebrew not found; skipping"
  fi
else
  warn "Skipped Homebrew maintenance"
fi

# ------------------------------------------------------------------------------
header "Library cache and log pruning (>30 days)"
if confirm "Prune old files in $BASE/Library/Caches?"; then
  if [ -d "$BASE/Library/Caches" ]; then
      find "$BASE/Library/Caches" -type f -mtime +30 -delete
      ok "Pruned files in $BASE/Library/Caches"
  else
      ok "No Library Caches directory"
  fi
else
  warn "Skipped Library cache pruning"
fi

# ------------------------------------------------------------------------------
header "Temporary and metadata cleanup"
if confirm "Remove Apple resource forks only (.AppleDouble, ._) across $BASE? (.DS_Store preserved)"; then
  if command -v dot_clean >/dev/null 2>&1; then
      dot_clean -m "$BASE" >/dev/null 2>&1 || true
      ok "Removed resource forks (.AppleDouble, ._ files)"
  fi
else
  warn "Skipped metadata cleanup"
fi

# ------------------------------------------------------------------------------
header "Python and Node cache cleanup"
if confirm "Clear pip and node/corepack caches?"; then
  rm -rf "$BASE/Library/Caches/pip" "$BASE/.cache/node/corepack" 2>/dev/null || true
  ok "Cleared pip and node/corepack caches"
else
  warn "Skipped pip/node cache cleanup"
fi

# ------------------------------------------------------------------------------
header "Spotlight and Finder (informational)"
warn "If search or Finder performance degrades, consider:"
warn "  mdutil -E /             # Reindex Spotlight"
warn "  killall Finder          # Restart Finder"

# ------------------------------------------------------------------------------
header "Cleanup complete"
ok "System hygiene tasks completed (interactive run)"