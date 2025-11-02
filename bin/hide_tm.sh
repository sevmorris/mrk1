#!/usr/bin/env bash
set -Eeuo pipefail

# Hide one or more Time Machine volume icons from the Desktop.
# Volumes are taken from TM_VOLUMES env (comma-separated), or first CLI arg, default "TimeMachine".

VOLS="${TM_VOLUMES:-${1:-TimeMachine}}"

# Split comma-separated list
IFS=',' read -ra NAMES <<< "$VOLS"

for NAME in "${NAMES[@]}"; do
  NAME="$(echo "$NAME" | sed 's/^ *//; s/ *$//')"  # trim
  [ -n "$NAME" ] || continue
  /usr/bin/osascript -e 'on run argv
    set volName to item 1 of argv
    tell application "Finder"
      repeat with d in disks
        if name of d is volName then
          set desktop visible of d to false
        end if
      end repeat
    end tell
  end run' "$NAME" || true
done
