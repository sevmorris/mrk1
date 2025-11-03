# mrk1 — macOS bootstrap & dotfiles

A clean, idempotent way to spin up a new Mac with all your (my) favorite tools: Homebrew, Zsh, dotfiles, and a few sane defaults. Easy to read, easy to trust.

- **Safe by default.** Any conflicting dotfiles get backed up. Defaults come with a rollback script.
- **Idempotent.** Run it again anytime — it won’t wreck your setup.

---

## Quick start

### One-liner install

```bash
/bin/bash -c 'TMP="$(mktemp -d)" && git clone --depth 1 https://github.com/sevmorris/mrk1 "$TMP/mrk1" && bash "$TMP/mrk1/scripts/install"'
```

That’s the easiest way to bootstrap from scratch. It clones into a temp folder, runs the installer, and leaves no mess behind.  
If you’d rather work from a local copy:

```bash
git clone https://github.com/sevmorris/mrk1.git ~/mrk1
cd ~/mrk1
make fix-exec && make install
```

> `make fix-exec` just makes sure all scripts are executable before install.  
> You can also run `./scripts/install` directly.

---

## What it sets up

- **Homebrew + Bundle** via `assets/Brewfile` (falls back to root `Brewfile` if needed)
- **Zsh** as your login shell (Homebrew version preferred)
- **Dotfiles** safely linked into `$HOME` with timestamped backups
- **Scripts & tools** from both `scripts/` and `bin/` linked into `~/.local/bin`
- **macOS defaults** applied by `scripts/defaults.sh`, with an automatic rollback script

---

## Common make targets

```text
make fix-exec     # ensure scripts/* and bin/* are executable
make install      # full bootstrap (brew → dotfiles → tools → defaults)
make tools        # install/update Brewfile packages
make dotfiles     # link dotfiles with backups
make defaults     # apply defaults + write rollback script
make brew-clean   # brew cleanup && autoremove
make uninstall    # unlink scripts and optionally roll back defaults
```

---

## Uninstall

```bash
./scripts/uninstall
```

What it does:

- Removes symlinks created in `~/.local/bin`  
- Optionally runs `~/.mrk1/defaults-rollback.sh`  
- Leaves your Homebrew setup and personal files alone

---

## Rollback for macOS defaults

Whenever you run `make defaults` or the main installer, a rollback helper is generated:

```
~/.mrk1/defaults-rollback.sh
```

It only records keys changed by mrk1, so you can safely undo tweaks later.

---

## Repo layout

```
assets/
  Brewfile            # main Homebrew bundle
bin/                  # small user-facing tools
scripts/
  install             # main installer
  uninstall           # removes symlinks + optional defaults rollback
  defaults.sh         # apply defaults + author rollback
dotfiles/             # shell/editor/git configs, etc.
Makefile
README.md
```

> Both `scripts/` and `bin/` are linked into `~/.local/bin`.  
> Keep “end-user” commands in `bin/`, bootstrap helpers in `scripts/`.

---

## Logging

Installer output goes to:

```
~/mrk1-install.log
```

Uninstall logs straight to the terminal.

---

## Contributing

- Keep scripts short and clear.  
- Comment every macOS default you touch.  
- Avoid “cleanup” or destructive operations.

---
