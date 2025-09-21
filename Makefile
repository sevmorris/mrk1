.PHONY: help lint format fix ci test doctor heal \
bootstrap bootstrap-strict bootstrap-lenient \
brew brew-install brew-clean dotfiles tools defaults

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

doctor:
	@./scripts/doctor

heal:
	@if [ -x ./scripts/doctor ]; then ./scripts/doctor --fix; else echo "scripts/doctor not found"; fi

# --------------------------
# Bootstrap
# --------------------------
# Lenient: run all steps; don't fail build if doctor warns.
bootstrap:
	@./scripts/bootstrap brew
	@./scripts/bootstrap dotfiles
	@./scripts/bootstrap tools
	@./scripts/bootstrap defaults
	@./scripts/bootstrap doctor || echo "⚠ doctor reported issues; continuing"

# Strict: single-call orchestrator; fails if any step (incl. doctor) fails.
bootstrap-strict:
	@./scripts/bootstrap bootstrap

# --------------------------
# Individual bootstrap steps
# --------------------------
brew:
	@./scripts/bootstrap brew

dotfiles:
	@./scripts/bootstrap dotfiles

tools:
	@./scripts/bootstrap tools

defaults:
	@./scripts/bootstrap defaults

# --------------------------
# Homebrew management
# --------------------------
.PHONY: brew-install brew-clean

# Apply the Brewfile (installs/updates keepers)
brew-install:
	@./scripts/bootstrap brew

# Clean Homebrew tree (removes extras, autoremoves, cleanup)
brew-clean:
	@./scripts/brew-cleanup.sh

# --------------------------
# Help
# --------------------------
help:
	@echo ""
	@echo "Available targets:"
	@echo "  make help              - this help"
	@echo "  make bootstrap         - run steps (brew -> dotfiles -> tools -> defaults -> doctor) [lenient on doctor]"
	@echo "  make bootstrap-strict  - single-call bootstrap (fails on any error)"
	@echo "  make brew-install      - apply Homebrew Bundle from assets/Brewfile"
	@echo "  make brew-clean        - remove extras, autoremove deps, cleanup cache, doctor/missing"
	@echo "  make doctor            - run scripts/doctor"
	@echo "  make heal              - run scripts/doctor --fix"
	@echo "  make lint              - shellcheck on scripts"
	@echo "  make format            - check formatting via shfmt (no writes)"
	@echo "  make fix               - format shell scripts in-place (shfmt -w)"
	@echo "  make ci                - lint + format"
	@echo "  make dotfiles          - link dotfiles/* into $$HOME (backs up originals)"
	@echo "  make tools             - link scripts/* with shebang into $$HOME/.local/bin"
	@echo "  make defaults          - run scripts/defaults.sh if present"
	@echo ""
.PHONY: bootstrap-lenient
bootstrap-lenient:
	@./scripts/bootstrap brew
	@./scripts/bootstrap dotfiles
	@./scripts/bootstrap tools
	@./scripts/bootstrap defaults || true
	@./scripts/bootstrap doctor   || { echo "doctor reported issues (non-fatal). See above."; exit 0; }

