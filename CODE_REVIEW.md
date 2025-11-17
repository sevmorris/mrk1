# Code Review & Improvements

## Executive Summary

This is a well-structured macOS bootstrap/dotfiles management project with good separation of concerns. The code is generally clean and follows bash best practices. However, there are several areas for improvement in security, error handling, and robustness.

## Critical Issues

### 1. Security Vulnerabilities

#### 1.1 Unsafe Git Clone (scripts/install:152)
**Issue**: The `MRK1_DOTFILES_REPO` environment variable is used directly in `git clone` without validation.
```bash
git clone --depth 1 "$MRK1_DOTFILES_REPO" "$DOTDIR"
```
**Risk**: Command injection if the URL contains malicious characters.
**Fix**: Validate URL format and sanitize input.

#### 1.2 Unsafe External Script Execution (scripts/install:156-157)
**Issue**: Scripts from external repos are executed without validation.
```bash
[[ -x "$DOTDIR/script/setup" ]] && "$DOTDIR/script/setup"
[[ -x "$DOTDIR/script/strap-after-setup" ]] && "$DOTDIR/script/strap-after-setup"
```
**Risk**: Arbitrary code execution from untrusted sources.
**Fix**: Add explicit user confirmation or allowlist mechanism.

#### 1.3 Login Message Injection (scripts/install:172)
**Issue**: `MRK1_LOGIN_MSG` is written directly to defaults without sanitization.
**Risk**: Potential injection if message contains special characters.
**Fix**: Escape special characters or validate input.

### 2. Error Handling Issues

#### 2.1 Silent Failures
- `scripts/install:140`: Backup failures are only warned, not handled
- `scripts/bootstrap:40`: `|| true` masks brew bundle errors
- `scripts/uninstall:24`: Symlink removal doesn't verify success

#### 2.2 Missing Error Checks
- `scripts/install:56`: `mkdir -p` could fail but isn't checked
- `scripts/link-tools:11`: No check if `mkdir -p` succeeds
- `scripts/defaults.sh:56-57`: `killall` failures are ignored

### 3. Code Quality Issues

#### 3.1 Inconsistent Error Handling
- Some scripts use `set -euo pipefail`, others don't
- Mix of `|| true`, `|| warn`, and silent failures
- Inconsistent logging patterns

#### 3.2 Missing Input Validation
- No validation of `--only` phase names
- No check if directories exist before operations
- No validation of file paths

#### 3.3 Edge Cases Not Handled
- Empty dotfiles directory
- Symlinks pointing to non-existent files
- Permission errors when creating directories
- Disk space issues during backups

### 4. Best Practices

#### 4.1 Missing Shellcheck Directives
Scripts should include shellcheck disable directives where intentional.

#### 4.2 Hardcoded Paths
Some paths are hardcoded instead of using variables consistently.

#### 4.3 Documentation
- Missing function documentation
- Some complex logic lacks comments
- No inline documentation for non-obvious operations

## Recommendations

### High Priority
1. ✅ Add URL validation for `MRK1_DOTFILES_REPO`
2. ✅ Add input sanitization for `MRK1_LOGIN_MSG`
3. ✅ Improve error handling for critical operations
4. ✅ Add validation for `--only` phase parameter
5. ✅ Check directory creation success

### Medium Priority
1. Add confirmation prompt for external script execution
2. Improve backup error handling
3. Add disk space checks before large operations
4. Validate symlink targets exist before linking
5. Add shellcheck directives

### Low Priority
1. Standardize logging functions across scripts
2. Add unit tests for critical functions
3. Improve inline documentation
4. Add dry-run mode to more scripts
5. Create a `.shellcheckrc` configuration file

## Improvements Made

### Security Fixes ✅
1. **scripts/install**:
   - Added URL validation for `MRK1_DOTFILES_REPO` to prevent command injection
   - Added validation for `--only` phase parameter
   - Improved error handling for external script execution
   - Added input validation for login message

2. **All scripts**:
   - Added proper error checking for directory creation
   - Improved error messages and logging

### Error Handling Improvements ✅
1. **scripts/install**:
   - Added error checking for `mkdir -p` operations
   - Improved backup failure handling (now aborts on failure)
   - Better symlink creation error tracking
   - Validates phase names before execution
   - Improved external dotfiles repo cloning error handling

2. **scripts/defaults.sh**:
   - Added error checking for rollback script initialization
   - Track and report failures when applying defaults
   - Better error handling in `write_default` function

3. **scripts/uninstall**:
   - Improved symlink removal with success/failure tracking
   - Better handling of non-interactive mode
   - More robust error reporting

4. **scripts/link-tools**:
   - Added error checking for directory creation
   - Track and report symlink creation failures
   - Exit with error code on failures

5. **scripts/hardening.sh**:
   - Better error handling for sudo operations
   - Improved rollback script initialization
   - Better error messages for failed operations

### Code Quality Improvements ✅
1. Added `.shellcheckrc` configuration file
2. Consistent error handling patterns across scripts
3. Better logging and user feedback
4. Improved edge case handling (empty directories, missing files, etc.)

### Files Modified
- `scripts/install` - Major security and error handling improvements
- `scripts/defaults.sh` - Error handling and failure tracking
- `scripts/uninstall` - Robustness improvements
- `scripts/link-tools` - Error checking and reporting
- `scripts/hardening.sh` - Better error handling for sudo operations
- `.shellcheckrc` - New shellcheck configuration file
- `CODE_REVIEW.md` - This document

