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
	@if [ -x ./scripts/doctor ]; then ./scripts/doctor; else echo "scripts/doctor not found"; fi
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
