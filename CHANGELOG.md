# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- macOS version detection - script now checks if running on macOS before proceeding
- `--dry-run` flag to preview changes without applying them
- `--validate` flag to validate configuration before installing
- `--continue-on-error` flag to continue with remaining phases if one fails
- Installation summary at end of install showing what was done
- Progress indicators for dotfile and tool linking operations
- Log rotation - automatically rotates logs when they exceed 10MB
- `scripts/status` command to check installation status
- Interactive confirmation prompts for external dotfiles script execution
- Improved error recovery with `--continue-on-error` flag

### Changed
- Improved external dotfiles handling with user confirmation
- Better progress feedback during installation
- Enhanced error messages and logging

### Fixed
- Removed Homebrew/Brewfile installation functionality (moved to separate repo)
- Fixed documentation references to removed features

## [1.0.0] - 2024-XX-XX

### Added
- Initial release
- Dotfile management with automatic backups
- Tool/script linking to `~/.local/bin`
- macOS defaults application with rollback support
- Shell configuration (zsh)
- Xcode Command Line Tools detection
- External dotfiles repository support
- Comprehensive error handling
- Security improvements (URL validation, input sanitization)

