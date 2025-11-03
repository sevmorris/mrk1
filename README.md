# mrk1 — macOS bootstrap & dotfiles (simplified)

A tidy, idempotent bootstrap for a fresh macOS setup: Homebrew + apps, shell, dotfiles, and a few sane defaults. Designed to be readable and auditable.

- **Safe by default.** Dotfile conflicts are backed up; defaults have a rollback helper.
- **Idempotent.** Re-run anytime without clobbering your system.
- **No cleanup script.** This project does **not** ship a system “cleaner.”

---

## Quick start

```bash
# 1) Clone
git clone https://github.com/sevmorris/mrk1.git ~/mrk1

# 2) Install
cd ~/mrk1
make fix-exec && make install
```

> `make fix-exec` ensures scripts are executable after a fresh clone.
> You can also run the installer directly with `./scripts/install`.

---

## What it sets up

- **Homebrew + Bundle** using `assets/Brewfile` (falls back to root `Brewfile` if present)
- **Zsh** as login shell (if available via Homebrew)
- **Dotfiles** from `dotfiles/` safely linked into `$HOME` with timestamped backups
- **Scripts & tools** from `scripts/` **and** `bin/` linked into `~/.local/bin`
- **macOS defaults** via `scripts/defaults.sh`, plus an auto-generated rollback script

---

## Common make targets

```text
make fix-exec     # ensure executability on scripts/* and bin/*
make install      # full bootstrap (brew → dotfiles → tools → defaults)
make tools        # brew bundle (installs/updates from Brewfile)
make dotfiles     # link dotfiles with backups
make defaults     # apply macOS defaults and write rollback script
make brew-install # alias of 'make tools'
make brew-clean   # brew cleanup && autoremove
make uninstall    # unlink PATH tools, optionally run defaults rollback
```

> **Removed:** any “clean mac” functionality. No `make cleanmac`. No `scripts/clean-mac.sh`.

---

## Uninstall

```bash
./scripts/uninstall
```

This will:

- Unlink symlinks the installer created in `~/.local/bin`
- Optionally run `~/.mrk1/defaults-rollback.sh` (created by `make defaults`)
- **Won’t** remove Homebrew, apps, or your data

---

## Rollback for macOS defaults

When you run `make defaults` or `./scripts/install`, a rollback helper is created at:

```
~/.mrk1/defaults-rollback.sh
```

It captures only the keys changed by this project so you can revert cleanly.

---

## Repo layout

```
assets/
  Brewfile            # primary Homebrew bundle file
bin/                  # small helper tools to expose on PATH
scripts/
  install             # main installer (run from a local clone)
  uninstall           # removes symlinks, optional defaults rollback
  defaults.sh         # apply defaults + author rollback
dotfiles/             # your shell/editor/git config, etc.
Makefile
README.md
```

**PATH policy:** both `scripts/` and `bin/` are linked into `~/.local/bin`. Use `bin/` for user-facing commands; keep bootstrap helpers in `scripts/`.

---

## Logging

Installer output is tee’d to:

```
~/mrk1-install.log
```

Uninstall also logs its steps to the terminal.

---

## Contributing

- Keep scripts small and reviewable.
- Be conservative with macOS defaults; always comment them and ensure rollback.
- Prefer durable, idempotent steps; avoid destructive “cleanup” features.
