# macOS Setup & Personalization with **mrk1**

A personal configuration toolkit for quickly provisioning a new **Apple Silicon Mac** with preferred tools, dotfiles, apps, and macOS defaults.

Everything runs through a single **idempotent installer script** — safe to re-run anytime.

---

## Quick Start

### 1. Clone
```bash
git clone https://github.com/sevmorris/mrk1.git ~/mrk1
```
The installer will prompt to install Xcode Command Line Tools if needed.

### 2. Install
```bash
cd ~/mrk1/scripts && ./install
```

### 3. (Optional) One-Line Bootstrap
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

## �Customize

Edit these before or after running:

- `dotfiles/` — Shell and Zsh configuration  
- `assets/Brewfile` — Packages and apps  
- `scripts/defaults.sh` — macOS preference tweaks  
- `scripts/` — Helper scripts linked into `~/.local/bin`

---

## Re-Running

The installer is **idempotent**: safe to run anytime.  
Existing components are updated, not reinstalled.

---

## Uninstall Manually

To revert:
- Delete linked dotfiles (`.zshrc`, `.aliases`, etc.)  
- Remove symlinks from `~/.local/bin`  
- Uninstall apps with `brew uninstall` or `brew bundle cleanup`  
- Reset macOS defaults with `defaults delete`

---

## Requirements

- macOS 13 (Ventura) or newer  
- Apple Silicon Mac  
- Internet access  
- Basic Terminal familiarity

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

---

## Maintenance Tool: `mrk1-maint`

A safe macOS maintenance utility (similar to Onyx).  
Cleans caches, resets indexes, and can run full “tune-ups.”

**Run:** `mrk1-maint --menu` or call a task directly (e.g. `mrk1-maint clean-caches`)

Add this shell function for convenience:
```bash
maint() { command mrk1-maint "$@"; }
```

### Notes
- Close apps first; some tasks restart Finder/Dock.  
- May prompt for `sudo`.  
- System may rebuild caches afterward (temporary slowdown).

---

## Example Tasks

**Core:** disk verify, periodic scripts, Spotlight rebuild, DNS flush, Launch Services reset, cache clears, log trimming, permissions repair.

**App-Specific:** cache cleanup for Chrome, Firefox, Logic Pro, Final Cut Pro, Premiere, After Effects, etc.

**Presets:**  
- `clean-caches` — full cache cleanup  
- `preset-browsers` — browsers + DNS  
- `preset-editing` — DAW/video cache reset  
- `full-tuneup` — comprehensive maintenance flow

---

## Quick Maintenance Start
```bash
make fix-exec && make install
make defaults
```

---

## Built-in Utilities

Run via `make` or directly from `scripts/`:

| Command | Description |
|----------|-------------|
| `make fix-exec` | Ensure all scripts are executable |
| `make install` | Run main installer |
| `make defaults` | Apply macOS defaults |
| `make uninstall` | Run uninstaller if present |

You can also run any executable under `scripts/` directly:
```bash
make doctor
make syncall
make bootstrap
make mrk1-maint
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
