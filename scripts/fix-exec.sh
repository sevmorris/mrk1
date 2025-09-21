#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# mrk1: one-shot fixer for "Permission denied" on scripts
# - Removes macOS quarantine xattrs (from downloaded zips)
# - Normalizes line endings to LF for shell scripts
# - Marks all shebang'd files in ./scripts as executable
# - Verifies ./scripts/bootstrap is runnable
#
# Usage: run from repo root:
#   ./scripts/fix-exec.sh

err()  { printf "\033[31m✗ %s\033[0m\n" "$*" >&2; }
ok()   { printf "\033[32m✓ %s\033[0m\n" "$*"; }
warn() { printf "\033[33m⚠ %s\033[0m\n" "$*"; }

REPO_DIR="$(pwd)"
SCRIPTS_DIR="${REPO_DIR}/scripts"

if [[ ! -d "$SCRIPTS_DIR" ]]; then
  err "scripts/ directory not found in: $REPO_DIR"
  exit 1
fi

# 1) Remove macOS Gatekeeper quarantine flags (if present)
if command -v xattr >/dev/null 2>&1; then
  xattr -r -d com.apple.quarantine "$REPO_DIR" 2>/dev/null || true
  ok "Cleared quarantine attributes (if any)"
fi

# 2) Normalize line endings to LF for shell scripts to avoid exec errors
#    (works even without dos2unix)
normalize_crlf() {
  local f="$1"
  # Only touch text files
  if file "$f" | grep -qi 'text'; then
    # Strip CRs; in-place, preserving perms
    perl -i -pe 's/\r$//' "$f" || true
  fi
}

export -f normalize_crlf
find "$SCRIPTS_DIR" -type f -print0 | xargs -0 -I{} bash -lc 'normalize_crlf "$@"' _ {}

ok "Normalized line endings for scripts"

# 3) Mark all shebang'd files in scripts/ as executable
while IFS= read -r -d '' f; do
  if head -n1 "$f" | grep -q '^#!'; then
    chmod +x "$f" || true
  fi
done < <(find "$SCRIPTS_DIR" -type f -print0)

ok "Ensured execute bit on shebang scripts"

# 4) Verify bootstrap is runnable
if [[ -f "${SCRIPTS_DIR}/bootstrap" ]]; then
  if [[ ! -x "${SCRIPTS_DIR}/bootstrap" ]]; then
    chmod +x "${SCRIPTS_DIR}/bootstrap"
  fi
  # Dry-run help to confirm execution path
  if "${SCRIPTS_DIR}/bootstrap" help >/dev/null 2>&1; then
    ok "scripts/bootstrap is runnable"
  else
    warn "scripts/bootstrap exists but failed to run 'help' (check its shebang)"
  fi
else
  warn "scripts/bootstrap not found"
fi

echo
ok "Done. Try:  make bootstrap   or   ./scripts/bootstrap help"
