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
