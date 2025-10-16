#!/usr/bin/env bash
set -Eeuo pipefail

# Normalize executable bits for entrypoints and shell scripts in this repo.
repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Mark primary entrypoints executable if they exist
chmod +x "${repo_root}/scripts/install" 2>/dev/null || true
chmod +x "${repo_root}/scripts/defaults.sh" 2>/dev/null || true

# All shell scripts under scripts/
find "${repo_root}/scripts" -type f -name "*.sh" -exec chmod +x {} \;

echo "✅ Executable bits set under ${repo_root}/scripts"
