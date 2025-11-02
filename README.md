# mrk1 — macOS bootstrap & dotfiles

Opinionated, idempotent bootstrap for a fresh macOS install: Homebrew + apps, shell setup, dotfiles, and a few sensible defaults. Designed to be readable and auditable.

- **Safe by default.** Every action is logged; dotfile conflicts are backed up first; macOS defaults include a generated rollback script.
- **Idempotent.** Re-running the installer won’t clobber existing state without confirming or backing up.
- **No destructive cleanup tools.** This project **does not** ship a cleanup script.

---

## Quick start

### Option A — Pinned (recommended)
Pin the installer to a known-good commit SHA to reduce supply‑chain risk:

```bash
SHA="660eb1c87074c9046c1843ce1dc219b1ed38fd2b"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/sevmorris/mrk1/$SHA/scripts/install)"
```

### Option B — Latest (advanced)
Use the tip of the default branch:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/sevmorris/mrk1/main/scripts/install)"
```

> **Security note:** Always **read** `scripts/install` before running remote code.

---

## What it sets up
- **Homebrew + Bundle** via `assets/Brewfile` (or root `Brewfile` if present)
- **Zsh** as login shell (if available via Homebrew)
- **Dotfiles** from `dotfiles/` safely linked into `$HOME` with timestamped backups
- **Scripts & tools** from `scripts/` and `bin/` linked into `~/.local/bin`
- **macOS defaults** via `scripts/defaults.sh`, with a generated rollback script at `~/.mrk1/defaults-rollback.sh`

---

## Make targets

```text
make fix-exec        # ensure executability on scripts/* and bin/*
make install         # full bootstrap (brew, dotfiles, tools, defaults)
make bootstrap       # alias of install
make tools           # brew bundle (installs/updates tools)
make dotfiles        # link dotfiles with backups
make defaults        # apply macOS defaults and write rollback script
make brew-install    # brew bundle (explicit)
make brew-clean      # brew cleanup && autoremove
make uninstall       # remove symlinks, optionally rollback defaults
```

> **Removed:** Any "clean mac" functionality. There is no `clean-mac.sh` and no `make cleanmac`.

---

## Uninstall

Run:

```bash
scripts/uninstall
```

What it does:
- Unlinks symlinks the installer created in `~/.local/bin`
- Optionally runs `~/.mrk1/defaults-rollback.sh` if present (created by `make defaults`/installer)
- Does **not** remove Homebrew, apps, or any user data

---

## macOS defaults rollback

When you run `make defaults` or the installer, the script generates a rollback helper at:

```
~/.mrk1/defaults-rollback.sh
```

It captures *only* the changes this project makes, so you can revert cleanly.

---

## Structure

```
assets/
  Brewfile            # primary Homebrew bundle file
bin/                  # small helper tools you want on PATH
scripts/
  install             # main installer (curl | bash safe to audit)
  uninstall           # removes symlinks, optional defaults rollback
  defaults.sh         # apply defaults + author rollback
  ...
dotfiles/             # your shell/editor/git config etc.
Makefile
README.md
```

**PATH policy:** both `scripts/` and `bin/` are linked into `~/.local/bin`. Use `bin/` for user-facing commands; keep bootstrap/one-off helpers in `scripts/`.

---

## Logging

Installer output is tee’d to:

```
~/mrk1-install.log
```

Uninstall also logs its steps to the terminal.

---

## Contributing / safety

- Prefer small, reviewable scripts
- Keep defaults minimal and provide clear comments
- Never add destructive cleanup by default
