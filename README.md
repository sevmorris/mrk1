# mrk1 — macOS bootstrap & dotfiles

A clean, idempotent way to spin up a new Mac with Zsh, dotfiles, and a few sane defaults. Easy to read, easy to trust.

- **Safe by default.** Any conflicting dotfiles get backed up. Defaults come with a rollback script.
- **Idempotent.** Run it again anytime — it won't wreck your setup.

---

## Quick start

```bash
curl -fsSL https://raw.githubusercontent.com/sevmorris/mrk1/main/scripts/install | bash
```

Or download and run manually:

```bash
curl -fsSL https://raw.githubusercontent.com/sevmorris/mrk1/main/scripts/install -o /tmp/mrk1-install
chmod +x /tmp/mrk1-install
/tmp/mrk1-install
```

The installer will:
1. Clone the repository to `~/.mrk1/repo` (or update if already exists)
2. Copy tools to `~/bin`
3. Symlink `.zsh*` files to your home directory (pointing to `~/.mrk1/repo/dotfiles/`)
4. Apply macOS defaults
5. Keep the clone for symlinks to work (can be updated on next install)

---

## What it sets up

- **Zsh** as your login shell
- **`.zsh*` files** safely symlinked into `$HOME` with timestamped backups
- **Tools** from `scripts/` and `bin/` copied to `~/bin`
- **macOS defaults** applied by `scripts/defaults.sh`, with an automatic rollback script

> **Note:** Only `.zsh*` files are symlinked. Other files in `dotfiles/` are not installed.
> Tools are **copied** (not symlinked) to `~/bin` so they work independently.

---

## Common make targets

```text
make install      # full bootstrap (tools → dotfiles → defaults)
make tools        # copy tools to ~/bin
make dotfiles     # link .zsh* files with backups
make defaults     # apply defaults + write rollback script
make status       # check installation status
make uninstall    # remove tools and unlink .zsh* files
```

> **Note:** When running from a cloned repo, `make install` works directly.  
> For end users, the installer automatically clones the repo temporarily.

### Installer Options

```bash
# Run specific phase only
./scripts/install --only dotfiles
./scripts/install --only tools
./scripts/install --only defaults

# Preview changes without applying
./scripts/install --dry-run

# Validate configuration before installing
./scripts/install --validate

# Continue even if a phase fails
./scripts/install --continue-on-error

# Skip specific phases
./scripts/install --no-dotfiles --no-defaults

# See all options
./scripts/install --help
```

### Check Installation Status

```bash
# Check what's installed and linked
./scripts/status
# or
make status
```

---

## Uninstall

```bash
./scripts/uninstall
```

What it does:

- Removes tools copied to `~/bin`  
- Unlinks `.zsh*` symlinks from home directory
- Optionally runs `~/.mrk1/defaults-rollback.sh`  
- Leaves your personal files and other dotfiles alone

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
bin/                  # small user-facing tools
scripts/
  install             # main installer
  uninstall           # removes symlinks + optional defaults rollback
  defaults.sh         # apply defaults + author rollback
dotfiles/             # shell/editor/git configs, etc.
Makefile
README.md
```

> Tools from `scripts/` and `bin/` are **copied** to `~/bin` (not symlinked).  
> Only `.zsh*` files from `dotfiles/` are symlinked to home directory.  
> Keep "end-user" commands in `bin/`, bootstrap helpers in `scripts/`.

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
