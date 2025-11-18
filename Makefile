SHELL := /bin/bash

# Directories
REPO_ROOT := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
SCRIPTS   := $(REPO_ROOT)/scripts
BIN_DIR   := $(REPO_ROOT)/bin

.PHONY: all bootstrap install fix-exec tools dotfiles defaults uninstall update updates harden status

all: install
bootstrap: install

fix-exec:
	@echo "Making scripts and bin executables..."
	@find $(SCRIPTS) -type f -maxdepth 1 -not -name "*.md" -exec chmod +x {} + 2>/dev/null || true
	@find $(BIN_DIR) -type f -maxdepth 1 -not -name "*.md" -exec chmod +x {} + 2>/dev/null || true

install: fix-exec
	@"$(SCRIPTS)/install"

tools:
	@"$(SCRIPTS)/install" --only tools

# Safe dotfile linking with backups is performed by scripts/install.
# This target exists for convenience if you only want to (re)link dotfiles.
dotfiles:
	@"$(SCRIPTS)/install" --only dotfiles

# Apply macOS defaults and generate a rollback script under ~/.mrk1
defaults:
	@"$(SCRIPTS)/defaults.sh"

uninstall:
	@"$(SCRIPTS)/uninstall"

update:
	@echo "Updating mrk1..."
	@git pull || { echo "Error: Failed to pull latest changes. Are you in a git repository?"; exit 1; }
	@make fix-exec
	@make install

updates:
	@softwareupdate -ia || true

harden:
	@./scripts/hardening.sh

status:
	@"$(SCRIPTS)/status"
