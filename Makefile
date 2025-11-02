.PHONY: help lint format fix ci test doctor heal \
bootstrap bootstrap-strict bootstrap-lenient \
brew brew-install brew-clean dotfiles tools defaults \
cleanmac uninstall syncall link-tools brew-cleanup postinstall-manifest \
fix-exec install \
bootstrap-brew bootstrap-dotfiles bootstrap-tools bootstrap-defaults bootstrap-doctor bootstrap-help

# --------------------------
# Quality
# --------------------------
lint:
	@shellcheck scripts/* bin/* 2>/dev/null || true

format:
	@shfmt -d -i 2 -bn -ci .

fix:
	@shfmt -w -i 2 -bn -ci .

ci: lint format

# --------------------------
# Health
# --------------------------
test: doctor

heal:
	@if [ -x ./scripts/doctor ]; then ./scripts/doctor --fix; else echo "scripts/doctor not found"; fi

# --------------------------
# Fix executable bits (for README: `make fix-exec`)
# --------------------------
FIXEXEC := $(firstword $(wildcard scripts/fix-exec scripts/fix-exec.sh))

fix-exec:
	@if [ -n "$(FIXEXEC)" ]; then \
		echo "Running $(FIXEXEC)…"; \
		bash "$(FIXEXEC)"; \
	else \
		echo "No fix-exec script found — making repo scripts executable (safe fallback)…"; \
		find scripts -maxdepth 1 -type f -print0 2>/dev/null | xargs -0 chmod +x 2>/dev/null || true; \
	fi

# --------------------------
# Bootstrap
# --------------------------
# Strict: single-call bootstrap (fails on any error).
bootstrap-strict:
	@bash ./scripts/bootstrap bootstrap

# Lenient, step-by-step bootstrap: tolerate defaults/doctor warnings
bootstrap-lenient:
	@bash ./scripts/bootstrap brew
	@bash ./scripts/bootstrap dotfiles
	@bash ./scripts/bootstrap tools
	@bash ./scripts/bootstrap defaults || true
	@PATH="$(HOME)/.local/bin:$$PATH" bash ./scripts/doctor || { echo "doctor reported issues (non-fatal). See above."; exit 0; }

# Primary bootstrap flow (explicit steps + manifest + doctor)
bootstrap:
	@echo "Running bootstrap..."
	@$(MAKE) brew
	@$(MAKE) dotfiles
	@$(MAKE) tools
	@$(MAKE) defaults || true
	@$(MAKE) -s postinstall-manifest || true
	@PATH="$(HOME)/.local/bin:$$PATH" $(MAKE) doctor

# README compatibility: `make install` does the bootstrap flow
install: bootstrap

# Convenience sub-targets (README: "Bootstrap Commands")
bootstrap-brew: brew
bootstrap-dotfiles: dotfiles
bootstrap-tools: tools
bootstrap-defaults: defaults
bootstrap-doctor: doctor
bootstrap-help: help

# --------------------------
# Individual bootstrap steps
# --------------------------
brew:
	@bash ./scripts/bootstrap brew

dotfiles:
	@bash ./scripts/bootstrap dotfiles

tools:
	@bash ./scripts/bootstrap tools

defaults:
	@bash ./scripts/bootstrap defaults

# --------------------------
# Homebrew management
# --------------------------
brew-install:
	@bash ./scripts/bootstrap brew

brew-clean:
	@./scripts/brew-cleanup.sh

brew-cleanup:
	@echo "Running brew-cleanup..."
	@bash ./scripts/brew-cleanup.sh

# --------------------------
# System Maintenance
# --------------------------
cleanmac:
	@echo "Running macOS cleanup (dry-run by default)..."
	@bash ./scripts/clean-mac.sh $(filter-out $@,$(MAKECMDGOALS))

# --------------------------
# Uninstall
# --------------------------
UNINSTALL_SCRIPT := $(firstword $(wildcard scripts/uninstall scripts/uninstall.sh))

uninstall:
	@if [ -z "$(UNINSTALL_SCRIPT)" ]; then \
		echo "❌ No uninstall script found at scripts/uninstall or scripts/uninstall.sh"; \
		exit 1; \
	fi
	@chmod +x "$(UNINSTALL_SCRIPT)"; \
	bash "$(UNINSTALL_SCRIPT)"

# --------------------------
# Post-install manifest
# --------------------------
postinstall-manifest:
	@chmod +x ./scripts/generate-install-manifest || true
	@bash ./scripts/generate-install-manifest

# --------------------------
# Help
# --------------------------
help:
	@echo ""
	@echo "Available targets:"
	@echo " make fix-exec           - set exec bits (or run scripts/fix-exec[.sh] if present)"
	@echo " make install            - brew -> dotfiles -> tools -> defaults -> postinstall-manifest -> doctor"
	@echo " make bootstrap          - same as 'install' (explicit steps)"
	@echo " make bootstrap-strict   - single-call bootstrap (fails on any error)"
	@echo " make bootstrap-lenient  - step-by-step; tolerates doctor warnings"
	@echo " make bootstrap-brew     - Homebrew bundle only"
	@echo " make bootstrap-dotfiles - Link dotfiles into \$$HOME"
	@echo " make bootstrap-tools    - Link repo scripts into \$$HOME/.local/bin"
	@echo " make bootstrap-defaults - Apply macOS defaults"
	@echo " make bootstrap-doctor   - Run doctor"
	@echo " make brew-install       - apply Homebrew Bundle from assets/Brewfile"
	@echo " make brew-clean         - remove extras, autoremove deps, cleanup cache, doctor/missing"
	@echo " make doctor             - run scripts/doctor (PATH is prefixed with ~/.local/bin)"
	@echo " make heal               - run scripts/doctor --fix"
	@echo " make lint               - shellcheck on scripts"
	@echo " make format             - check formatting via shfmt (no writes)"
	@echo " make fix                - format shell scripts in-place (shfmt -w)"
	@echo " make ci                 - lint + format"
	@echo " make dotfiles           - link dotfiles/* into \$$HOME (backs up originals)"
	@echo " make tools              - link scripts/* with shebang into \$$HOME/.local/bin"
	@echo " make defaults           - run scripts/defaults.sh if present"
	@echo " make cleanmac           - run macOS cleanup (live; prompts each step)"
	@echo " make uninstall          - run scripts/uninstall(.sh) via bash"
	@echo ""

# ---- Utility wrappers ----
doctor:
	@echo "Running doctor..."
	@PATH="$(HOME)/.local/bin:$$PATH" bash ./scripts/doctor

syncall:
	@echo "Running syncall..."
	@bash ./scripts/syncall

link-tools:
	@echo "Running link-tools..."
	@bash ./scripts/link-tools

# ---- Generic script runner (fallback) ----
# Usage: `make <scriptname>` runs `scripts/<scriptname>` if it exists and is executable.
%:
	@if echo "$@" | grep -q '^-'; then exit 0; fi
	@if [ -x "scripts/$@" ]; then \
	 echo "Running $@..."; \
	 bash "scripts/$@"; \
	else \
	 echo "make: *** No rule to make target '$@' (and scripts/$@ is not executable). Stop."; \
	 exit 2; \
	fi
