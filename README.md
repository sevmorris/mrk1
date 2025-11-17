# mrk1 — macOS bootstrap & dotfiles

A clean, idempotent way to spin up a new Mac with Zsh, dotfiles, and a few sane defaults. Easy to read, easy to trust.

- **Safe by default.** Any conflicting dotfiles get backed up. Defaults come with a rollback script.
- **Idempotent.** Run it again anytime — it won't wreck your setup.

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

- **Zsh** as your login shell
- **Dotfiles** safely linked into `$HOME` with timestamped backups
- **Scripts & tools** from both `scripts/` and `bin/` linked into `~/.local/bin`
- **macOS defaults** applied by `scripts/defaults.sh`, with an automatic rollback script

---

## Common make targets

```text
make fix-exec     # ensure scripts/* and bin/* are executable
make install      # full bootstrap (dotfiles → tools → defaults)
make tools        # link scripts/bin into ~/.local/bin
make dotfiles     # link dotfiles with backups
make defaults     # apply defaults + write rollback script
make uninstall    # unlink scripts and optionally roll back defaults
```

### Installer Options

```bash
# Run specific phase only
./scripts/install --only dotfiles
./scripts/install --only tools
./scripts/install --only defaults

# Skip specific phases
./scripts/install --no-dotfiles --no-defaults

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
