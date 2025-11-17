# Contributing to mrk1

Thank you for your interest in contributing to mrk1! This document provides guidelines and instructions for contributing.

## Code Style

### Bash Scripts

- Use `#!/usr/bin/env bash` as the shebang
- Always use `set -euo pipefail` for error handling
- Use meaningful variable names
- Add comments for complex logic
- Follow existing code patterns

### Function Documentation

Each function should have a brief comment explaining:
- What it does
- Parameters (if any)
- Return values or side effects

Example:
```bash
# Validate git URL format (basic check)
# Returns 0 if valid, 1 otherwise
is_valid_git_url() {
  local url="$1"
  # ...
}
```

## Adding macOS Defaults

When adding new defaults to `scripts/defaults.sh`:

1. **Add a comment** explaining what the default does and why
2. **Use the `write_default` helper** function
3. **Test the change** on your system first
4. **Document any side effects** in the comment

Example:
```bash
# Show all filename extensions in Finder
# Makes it easier to see file types at a glance
write_default NSGlobalDomain AppleShowAllExtensions bool true
```

## Adding New Scripts

### Scripts in `scripts/`

- Bootstrap/installation helpers
- System configuration scripts
- Should be idempotent (safe to run multiple times)

### Scripts in `bin/`

- End-user tools/utilities
- Should be standalone and useful on their own

### Requirements

- Must have a shebang (`#!/usr/bin/env bash`)
- Must be executable
- Should handle errors gracefully
- Should provide helpful error messages

## Testing

Before submitting changes:

1. Test on a clean macOS system (or VM) if possible
2. Test with `--dry-run` flag
3. Test with `--validate` flag
4. Test error cases (missing files, permissions, etc.)
5. Verify idempotency (run twice, should be safe)

## Pull Request Process

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Update documentation if needed
6. Submit a pull request with a clear description

### PR Description Should Include

- What changes were made
- Why the changes were needed
- How to test the changes
- Any breaking changes (if applicable)

## Reporting Issues

When reporting issues, please include:

- macOS version
- What you were trying to do
- Expected behavior
- Actual behavior
- Error messages (if any)
- Steps to reproduce

## Questions?

If you have questions about contributing, feel free to open an issue for discussion.

