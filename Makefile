# mrk1 Makefile — convenience tasks

.PHONY: install defaults fix-exec

# Run main installer
install:
	@echo "Running installer..."
	@bash scripts/install

# Apply macOS defaults configuration
defaults:
	@echo "Applying macOS defaults..."
	@bash scripts/defaults.sh

# Normalize executable bits for scripts
fix-exec:
	@echo "Fixing executable permissions..."
	@bash scripts/fix-exec.sh


.PHONY: uninstall
uninstall:
	@echo "Uninstalling..."
	@bash scripts/uninstall.sh

# ---- Utility wrappers ----
.PHONY: doctor syncall link-tools bootstrap mrk1-maint brew-cleanup

doctor:
	@echo "Running doctor..."
	@bash scripts/doctor

syncall:
	@echo "Running syncall..."
	@bash scripts/syncall

link-tools:
	@echo "Running link-tools..."
	@bash scripts/link-tools

bootstrap:
	@echo "Running bootstrap..."
	@bash scripts/bootstrap

mrk1-maint:
	@echo "Running mrk1-maint..."
	@bash scripts/mrk1-maint

brew-cleanup:
	@echo "Running brew-cleanup..."
	@bash scripts/brew-cleanup.sh

# ---- Generic script runner (fallback) ----
# Usage: `make <scriptname>` runs `scripts/<scriptname>` if it exists and is executable.
# Keeps explicit targets above; this only fires if no named rule matched.
%:
	@if [ -x "scripts/$@" ]; then \
	  echo "Running $@..."; \
	  bash "scripts/$@"; \
	else \
	  echo "make: *** No rule to make target '$@' (and scripts/$@ is not executable). Stop."; \
	  exit 2; \
	fi
