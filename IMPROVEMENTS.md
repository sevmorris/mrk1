# Suggested Improvements for mrk1

## High Priority

### 1. Add `.gitignore`
Create a `.gitignore` file to exclude:
- `*.log` files
- Backup directories
- OS-specific files (`.DS_Store`, `Thumbs.db`)
- Editor files (`.swp`, `.swo`, `*~`)

### 2. Add Installation Summary
At the end of `scripts/install`, show a summary:
- What was installed/linked
- What was skipped
- Where backups are located
- Next steps or recommendations

### 3. Add `--dry-run` Flag
Allow users to preview what would happen without making changes:
```bash
./scripts/install --dry-run
```

### 4. Improve macOS Version Detection
Add a check to ensure the script is running on macOS:
```bash
if [[ "$(uname -s)" != "Darwin" ]]; then
  err "This script is designed for macOS only"
  exit 1
fi
```

### 5. Add Status/Check Command
Create a `scripts/status` or enhance `doctor` to show:
- Which dotfiles are linked
- Which tools are linked
- Which defaults have been applied
- Backup locations

## Medium Priority

### 6. Add Version/Update Check
- Add a version number to the project
- Optionally check for updates from GitHub
- Show version in `--help` output

### 7. Improve Error Recovery
- If a phase fails, offer to continue with remaining phases
- Better error messages with suggested fixes
- Log errors to a separate error log file

### 8. Add Backup Management
- List backups: `scripts/list-backups`
- Restore from backup: `scripts/restore-backup <timestamp>`
- Clean old backups: `scripts/clean-backups [--keep-days=30]`

### 9. Add Validation Mode
- Validate dotfiles exist before linking
- Check symlink targets are valid
- Verify defaults can be applied

### 10. Improve External Dotfiles Handling
- Add confirmation prompt before cloning external repos
- Show what scripts will be executed
- Allow skipping external script execution

### 11. Add Log Rotation
- Rotate logs when they get too large
- Keep last N log files
- Compress old logs

### 12. Add Progress Indicators
For long operations, show progress:
- Dotfile linking progress
- Tool linking progress
- Defaults application progress

## Low Priority

### 13. Add Changelog
Create `CHANGELOG.md` to track changes and versions

### 14. Add Contributing Guide
Create `CONTRIBUTING.md` with:
- Code style guidelines
- How to add new defaults
- Testing procedures

### 15. Add Example Dotfiles
Add example dotfiles in `dotfiles/` directory or document expected structure

### 16. Improve Help Text
- Better formatting for `--help` output
- Add examples to help text
- Link to documentation

### 17. Add Log Levels
Support different verbosity levels:
- `--quiet`: Minimal output
- `--verbose`: Detailed output
- `--debug`: Debug mode (already exists)

### 18. Add Configuration File
Support a config file (`~/.mrk1/config`) for:
- Custom paths
- Default options
- Feature flags

### 19. Add Uninstall Verification
After uninstall, verify what was removed and what remains

### 20. Add Health Check
Periodic health check to ensure:
- Symlinks are still valid
- Dotfiles haven't been modified
- Defaults are still applied

## Code Quality

### 21. Add Shellcheck to CI
If you set up CI, add shellcheck validation

### 22. Standardize Error Codes
Use consistent exit codes:
- 0: Success
- 1: General error
- 2: Invalid arguments
- 3: Missing dependencies

### 23. Add Function Documentation
Add brief doc comments to all functions explaining:
- What they do
- Parameters
- Return values

### 24. Extract Common Functions
Create a `scripts/lib/common.sh` for shared functions:
- Logging functions
- Validation functions
- Path resolution

## User Experience

### 25. Add Color Output
Use colors for better readability (already partially done in some scripts)

### 26. Add Spinner for Long Operations
Show a spinner during long operations

### 27. Add Estimated Time
Show estimated time remaining for operations

### 28. Add Interactive Mode
Ask user before making changes (with `--interactive` flag)

### 29. Improve Defaults Documentation
Add comments in `defaults.sh` explaining what each default does and why

### 30. Add Quick Start Examples
Add more examples in README for common use cases

