SHELL := /bin/bash

# Directories
REPO_ROOT := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
SCRIPTS   := $(REPO_ROOT)/scripts
BIN_DIR   := $(REPO_ROOT)/bin
ASSETS    := $(REPO_ROOT)/assets

# Brewfile: prefer assets/Brewfile but allow root Brewfile fallback
BREWFILE  := $(if $(wildcard $(ASSETS)/Brewfile),$(ASSETS)/Brewfile,$(REPO_ROOT)/Brewfile)

.PHONY: all bootstrap install fix-exec tools dotfiles defaults brew-install brew-clean uninstall updates harden

all: install
bootstrap: install

fix-exec:
	@echo "Making scripts and bin executables..."
	@find $(SCRIPTS) -type f -maxdepth 1 -not -name "*.md" -exec chmod +x {} + 2>/dev/null || true
	@find $(BIN_DIR) -type f -maxdepth 1 -not -name "*.md" -exec chmod +x {} + 2>/dev/null || true

install: fix-exec
	@"$(SCRIPTS)/install"

# Interactive cask install:
# - If scripts/bundle-interactive exists, use it to install formulas/taps automatically
#   and prompt per-cask.
# - Otherwise, fall back to plain brew bundle.
brew-install tools:
	@if [ -f "$(BREWFILE)" ]; then \
		if [ -x "$(SCRIPTS)/bundle-interactive" ]; then \
			"$(SCRIPTS)/bundle-interactive" "$(BREWFILE)"; \
		else \
			echo "Note: scripts/bundle-interactive not found; falling back to 'brew bundle'."; \
			brew bundle --file="$(BREWFILE)"; \
		fi \
	else \
		echo "No Brewfile found at $(BREWFILE). Skipping."; \
	fi

brew-clean:
	@brew cleanup -s || true
	@brew autoremove || true

# Safe dotfile linking with backups is performed by scripts/install.
# This target exists for convenience if you only want to (re)link dotfiles.
dotfiles:
	@"$(SCRIPTS)/install" --only dotfiles

# Apply macOS defaults and generate a rollback script under ~/.mrk1
defaults:
	@"$(SCRIPTS)/defaults.sh"

uninstall:
	@"$(SCRIPTS)/uninstall"

updates:
	@softwareupdate -ia || true

harden:
	@./scripts/hardening.sh
