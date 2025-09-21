.PHONY: lint format fix ci test doctor heal bootstrap brew dotfiles tools defaults

lint:
	@shellcheck install.sh scripts/* bin/* 2>/dev/null || true

format:
	@shfmt -d -i 2 -bn -ci .

fix:
	@shfmt -w -i 2 -bn -ci .

ci: lint format

test: doctor
doctor:
	@./scripts/doctor
heal:
	@if [ -x ./scripts/doctor ]; then ./scripts/doctor --fix; else echo "scripts/doctor not found"; fi

bootstrap:
	@./scripts/bootstrap bootstrap
brew:
	@./scripts/bootstrap brew
dotfiles:
	@./scripts/bootstrap dotfiles
tools:
	@./scripts/bootstrap tools
defaults:
	@./scripts/bootstrap defaults
# --- Homebrew Management ---

.PHONY: brew-install brew-clean

# Apply the Brewfile (installs/updates keepers)
brew-install:
	@./scripts/bootstrap brew

# Clean Homebrew tree (removes extras, autoremoves, cleanup)
brew-clean:
	@./scripts/brew-cleanup.sh
# --- Self-documenting help ---
.PHONY: help
help:
	@echo ""
	@echo "Available targets:"
	@echo "  make help          - this help"
	@echo "  make bootstrap     - run full bootstrap (brew -> dotfiles -> tools -> defaults -> doctor)"
	@echo "  make brew-install  - apply Homebrew Bundle from assets/Brewfile"
	@echo "  make brew-clean    - remove extras, autoremove deps, cleanup cache, doctor/missing"
	@echo "  make doctor        - run scripts/doctor"
	@echo "  make lint          - shellcheck on scripts"
	@echo "  make format        - check formatting via shfmt (no writes)"
	@echo "  make fix           - format shell scripts in-place (shfmt -w)"
	@echo "  make ci            - lint + format"
	@echo "  make dotfiles      - link dotfiles/* into \$${HOME} (backs up originals)"
	@echo "  make tools         - link scripts/* with shebang into \$${HOME}/.local/bin"
	@echo "  make defaults      - run scripts/defaults.sh if present"
	@echo ""
