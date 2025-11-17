# mrk1 — macOS bootstrap & dotfiles

A clean, idempotent way to spin up a new Mac with all your (my) favorite tools: Homebrew, Zsh, dotfiles, and a few sane defaults. Easy to read, easy to trust.

- **Safe by default.** Any conflicting dotfiles get backed up. Defaults come with a rollback script.
- **Idempotent.** Run it again anytime — it won’t wreck your setup.

---

## Quick start

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

## Interactive Cask & MAS App Installation

By default, **Casks and Mac App Store (MAS) apps are optional and interactive**. The installer will:

1. **Automatically install** all formulas and taps from your Brewfile
2. **Prompt you** for each MAS app individually
3. **Prompt you** for each cask individually

This allows you to choose which applications to install, keeping your system lean.

### Cask Installation Options

```bash
# Interactive mode (default) - prompts for each cask
./scripts/install

# Install all casks without prompting
./scripts/install --yes-casks

# Skip all casks
./scripts/install --no-casks

# Use the interactive bundle script directly
./scripts/bundle-interactive assets/Brewfile
```

The interactive installer shows:
- A summary of total, already-installed, and pending items for both MAS apps and casks
- Progress counter for each item (`[1/25] Install MAS app 'Keynote'? [Y/n]` or `[1/25] Install cask 'iterm2'? [Y/n]`)
- Final summary of installed, skipped, and failed items for both MAS apps and casks

**Note:** In non-interactive mode (no TTY), both MAS apps and casks are skipped by default. Use `--yes-casks` to install all automatically.

---

## Common make targets

```text
make fix-exec     # ensure scripts/* and bin/* are executable
make install      # full bootstrap (brew → dotfiles → tools → defaults)
make tools        # install/update Brewfile packages (interactive for casks)
make dotfiles     # link dotfiles with backups
make defaults     # apply defaults + write rollback script
make brew-clean   # brew cleanup && autoremove
make uninstall    # unlink scripts and optionally roll back defaults
```

### Installer Options

```bash
# Run specific phase only
./scripts/install --only brew
./scripts/install --only dotfiles

# Control cask installation
./scripts/install --yes-casks    # install all casks
./scripts/install --no-casks      # skip all casks

# Skip specific phases
./scripts/install --no-brew --no-defaults

# See all options
./scripts/install --help
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
