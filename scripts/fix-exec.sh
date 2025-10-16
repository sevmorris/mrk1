#!/usr/bin/env bash
set -Eeuo pipefail

# Normalize executable bits for entrypoints and shell scripts in this repo.
repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
scripts_dir="${repo_root}/scripts"

# Mark primary entrypoints executable if they exist
chmod +x "${scripts_dir}/install" 2>/dev/null || true
chmod +x "${scripts_dir}/defaults.sh" 2>/dev/null || true
chmod +x "${scripts_dir}/uninstall" 2>/dev/null || true
chmod +x "${scripts_dir}/uninstall.sh" 2>/dev/null || true

# Make all *.sh executable
find "${scripts_dir}" -type f -name "*.sh" -exec chmod +x {} \;

# Also make common entrypoints executable even without .sh extension
while IFS= read -r -d '' f; do
  chmod +x "$f"
done < <(find "${scripts_dir}" -type f \
  \( -name install -o -name uninstall -o -name doctor -o -name bootstrap -o -name syncall -o -name mrk1-maint -o -name link-tools \) -print0)

# Finally, make any file with a shebang executable
while IFS= read -r -d '' f; do
  # Check first line for shebang
  if head -n 1 "$f" | grep -q '^#!'; then
    chmod +x "$f"
  fi
done < <(find "${scripts_dir}" -type f -print0)

echo "✅ Executable bits set under ${scripts_dir}"
