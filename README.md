# macOS Setup & Personalization with **mrk1**

A personal configuration toolkit for quickly provisioning a new **Apple Silicon Mac** with preferred tools, dotfiles, apps, and macOS defaults.

Everything runs through a single **idempotent installer script** — safe to re-run anytime.

---

## Quick Start

### 1) Clone
```bash
git clone https://github.com/sevmorris/mrk1.git ~/mrk1
```
If the Xcode Command Line Tools are missing, the installer will prompt to install them.

### 2) Fix permissions & install (recommended)
```bash
cd ~/mrk1
make fix-exec && make install
```
> `make fix-exec` ensures `scripts/install` (and other helpers) are executable after a fresh clone.

### (Alternative) Manual install
```bash
chmod +x ~/mrk1/scripts/install
cd ~/mrk1/scripts && ./install
```

### (Optional) One-line bootstrap
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/sevmorris/mrk1/main/scripts/install)"
```
> ⚠️ Review [`scripts/install`](scripts/install) before running remote code.

---

## What It Does

1. **Xcode Tools** – Ensures CLI developer tools are present.  
2. **Homebrew** – Installs if missing and updates shell paths.  
3. **Core Tools** – Installs essentials via Brewfile:  
   `iterm2`, `pulsar`, `git`, `gh`, `zsh`, `coreutils`, `topgrade`, `bat`, `pwgen`, etc.  
4. **Oh My Zsh** – Installs and configures shell environment.  
5. **Zsh Plugins** – Adds `zsh-syntax-highlighting` and `zsh-autosuggestions`.  
6. **Dotfiles** – Links `.zshrc`, `.zshenv`, `.zprofile`, `.aliases`, and configs (e.g. `topgrade.toml`).  
7. **Default Shell** – Sets Homebrew Zsh as login shell.  
8. **macOS Defaults** – Applies custom system settings via `scripts/defaults.sh`.  
9. **Apps** – Installs all CLI, cask, and Mac App Store apps from your Brewfile (one confirmation prompt).

---

## Customize

Edit these before or after running:

- `dotfiles/` — Shell and Zsh configuration  
- `assets/Brewfile` — Packages and apps  
- `scripts/defaults.sh` — macOS preference tweaks  
- `scripts/` — Helper scripts linked into `~/.local/bin`

---

## Make Targets

Use `make help` for all targets.  
Key ones:

| Command | Description |
|----------|-------------|
| `make bootstrap` | Run full setup (brew → dotfiles → tools → defaults → doctor) |
| `make doctor` | Run health checks |
| `make dotfiles` | Link dotfiles into `$HOME` |
| `make tools` | Link executables into `~/.local/bin` |
| `make defaults` | Apply macOS defaults |
| `make brew-install` | Apply Brewfile installs |
| `make brew-clean` | Cleanup and autoremove |
| `make lint` / `make format` / `make fix` | ShellCheck + shfmt validation |
| `make ci` | Combined lint/format check |
| `make cleanmac` | Run interactive system cleanup (live by default; prompts each step) |

---

## Cleanup Tool: `clean-mac.sh`

A unified macOS cleanup and hygiene script for the user environment (`$HOME`).

**Mode:**

- **Live by default**, with an interactive prompt before each step.
- No dry-run flag. You decide per-step at runtime.

**Includes:**
- Removal of user/application caches and logs  
- Deletion of all virtual environments (`~/.venvs`)  
- Cleaning of Apple resource fork files (preserves `.DS_Store` to keep Desktop/Finder layouts)  
- Pruning old files in `~/Library/Caches`  
- Running `brew cleanup` and `brew autoremove`  
- Clearing `pip` and Node/Corepack caches  
- Optional guidance for Spotlight and Finder rebuilds

**Usage:**
```bash
make cleanmac            # live, prompts before each step
```

Run directly:
```bash
scripts/clean-mac.sh     # live, prompts before each step
```
Color-coded output shows what ran and what was skipped.

## Quick Maintenance Start
```bash
make fix-exec && make install
make defaults
make cleanmac            # interactive prompts, live by default
```

## Built-in Utilities

Run via `make` or directly from `scripts/`:

| Command | Description |
|----------|-------------|
| `make fix-exec` | Ensure all scripts are executable |
| `make install` | Run main installer |
| `make defaults` | Apply macOS defaults |
| `make cleanmac` | Run cleanup and hygiene tasks |
| `make uninstall` | Run uninstaller if present |

You can also run any executable under `scripts/` directly:
```bash
make doctor
make syncall
make bootstrap
make brew-cleanup
```

---

## Uninstall

```bash
make uninstall
```

---

## Bootstrap Commands

Run the full flow or specific steps:
```bash
make bootstrap-brew       # Homebrew bundle only
make bootstrap-dotfiles   # Link dotfiles
make bootstrap-tools      # Link scripts
make bootstrap-defaults   # Apply macOS defaults
make bootstrap-doctor     # Run doctor
make bootstrap-help       # Show help
```
