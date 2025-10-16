#!/usr/bin/env bash
set -Eeuo pipefail

# Generic uninstaller for mrk1.
# If a more specific uninstaller exists, delegate to it.

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if [ -x "${repo_root}/scripts/uninstall-defaults.sh" ]; then
  echo "Running uninstall-defaults.sh..."
  bash "${repo_root}/scripts/uninstall-defaults.sh"
  echo "Uninstall completed via uninstall-defaults.sh."
else
  echo "No specific uninstaller found (scripts/uninstall-defaults.sh)."
  echo "Nothing to uninstall."
fi
