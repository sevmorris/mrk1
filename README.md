// macOS Setup & Personalization with mrk1 //

This repository contains my personal configuration for quickly setting up a new **Apple Silicon Mac** with my preferred tools, dotfiles, applications, and macOS defaults.

It is powered by a single **idempotent installer script** — you can run it multiple times without breaking anything.

---

## ⚡ Quick Start

After a fresh macOS installation:

### 1. Clone the Repository
The installer script will automatically prompt you to install Xcode Command Line Tools if they are missing.
```bash
git clone https://github.com/sevmorris/mrk1.git ${HOME}/mrk1
```

### 2. Run the Installer
```bash
cd ${HOME}/mrk1/scripts && ./install
```

---

### 🚀 Alternative One-Line Bootstrap
If you’d like to skip the manual clone step, you can run this **direct installer**:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/sevmorris/mrk1/main/scripts/install)"
```

⚠️ **Note**: Running scripts directly from the internet is inherently risky.  
Review the [`install`](scripts/install) script before using this method.

---

## 🤖 What the Installer Does

The script automates a complete setup:

1.  **Xcode Command Line Tools** – Installs if not already present.
2.  **Homebrew** – Installs if missing and configures your shell to use it immediately.
3.  **Core Tools** – Installs CLI essentials via Homebrew, including:
    - `iterm2`, `pulsar` (apps)
    - `git`, `gh`, `zsh`, `coreutils`, `topgrade`, `bat`, `pwgen` (formulae)
4.  **Oh My Zsh** – Installs and configures your shell.
5.  **Zsh Plugins** – Adds:
    - `zsh-syntax-highlighting`
    - `zsh-autosuggestions`
6.  **Dotfiles Setup**
    - Creates symlinks for `.zshrc`, `.zshenv`, `.zprofile`, `.aliases`.
    - Copies configs like `topgrade.toml`.
8.  **Default Shell** – Switches your login shell to Homebrew Zsh.
9.  **macOS Defaults** – Applies system preferences via `scripts/defaults.sh` (if available).
10. **App Installations via Brewfile** – After a single confirmation prompt, it installs all CLI tools, Mac App Store apps, and GUI apps (casks) listed in your `Brewfile`.

---

## 🛠️ Optional / Customization

You can edit these before or after running the installer:

- `dotfiles/` → Your personal Zsh and shell configs.
- `assets/Brewfile` → Add/remove apps and packages.
- `scripts/defaults.sh` → macOS defaults (trackpad, Dock, Finder, etc).
- `scripts/` → Custom helper scripts (linked into `${HOME}/.local/bin`).

---

## 🔄 Running Again

The installer is **idempotent**. Running it multiple times:
- Won’t reinstall things unnecessarily.
- Will safely re-link configs and re-apply updates.

---

## ❌ Uninstall / Rollback

This script does **not** provide an automatic rollback. If you want to undo:
- Remove symlinks in your home directory (`.zshrc`, `.aliases`, etc).
- Unlink/remove scripts in `${HOME}/.local/bin`.
- Uninstall apps with `brew uninstall` or `brew bundle cleanup`.
- Reset macOS defaults manually or with `defaults delete`.

---

## 📦 Requirements

- macOS 13 Ventura or newer (Apple Silicon).
- Internet connection.
- Basic familiarity with the Terminal.

---

## 🧰 Make Targets

This project uses a Makefile for common workflows. Run:

```bash
make help
```

to see a list. The main targets are:

- `make help` — show this help  
- `make bootstrap` — full bootstrap (brew → dotfiles → tools → defaults → doctor)  
- `make brew-install` — apply Homebrew bundle (`assets/Brewfile`)  
- `make brew-clean` — remove extras, autoremove deps, cleanup cache, doctor/missing  
- `make doctor` — run `scripts/doctor` health check  
- `make lint` — run ShellCheck on scripts  
- `make format` — check formatting with shfmt (no writes)  
- `make fix` — format scripts in-place with shfmt  
- `make ci` — run lint + format (CI checks)  
- `make dotfiles` — link dotfiles/* into `$HOME` (backs up originals)  
- `make tools` — link scripts/* with shebang into `${HOME}/.local/bin`  
- `make defaults` — run `scripts/defaults.sh` if present  


---

## 🧰 Maintenance Tools (`mrk1-maint`)

An Onyx-like toolkit of safe, macOS-focused maintenance commands. It cleans caches, resets indexes/databases, and provides presets for browsers and editing apps. Most tasks are reversible (caches rebuild automatically).

**Location:** `scripts/mrk1-maint`  
**Install to PATH:** either `./scripts/link-tools` or `make tools`  
**Run:** `mrk1-maint --menu` (interactive) or call a task directly.

### Shell function passthrough (recommended)

Add this to your shell aliases (this repo ships it in `dotfiles/.aliases`):

```bash
# Passthrough so you can run: maint clean-caches, maint flush-dns, etc.
maint() {
  command mrk1-maint "$@"
}
```

### Safety & notes
- Close apps first; some tasks briefly restart Finder/Dock/QuickLook/CFPrefs.
- You may be prompted for `sudo` (the script keeps it alive for long runs).
- After cleaning, macOS may feel slower while caches rebuild.

### Quick usage
```bash
# Interactive menu
mrk1-maint --menu

# Dry-run any task (prints commands, executes nothing)
mrk1-maint --dry-run full-tuneup

# Run a specific task
mrk1-maint clean-caches
```

### Commands

**Core**
- `verify-disk` — Disk Utility-style verification (read-only) on all volumes  
- `run-periodic` — Run macOS daily/weekly/monthly maintenance scripts  
- `rebuild-spotlight` — Erase & rebuild Spotlight index on all volumes  
- `flush-dns` — Flush DNS & directory caches  
- `reset-launchservices` — Rebuild Launch Services (Open With…)  
- `clear-user-caches` — Remove `${HOME}/Library/Caches/*`  
- `clear-system-caches` — Remove `/Library/Caches/*` (sudo)  
- `clear-font-caches` — Reset ATS/font caches (sudo)  
- `reset-quicklook` — Reset Quick Look cache  
- `rebuild-iconservices` — Rebuild Finder icon caches  
- `repair-permissions-user` — Reset Home directory permissions/ACLs (sudo)  
- `vacuum-logs` — Trim unified logging live store (sudo)  
- `safari-cleanup` — Clear Safari caches  
- `mail-reindex` — Remove Mail envelope index (rebuilds on launch)  
- `rebuild-spelling` — Clear spelling caches  
- `purge-memory` — Attempt memory purge (limited on modern macOS)

**App-specific**
- `chrome-cleanup` — Clear Chrome caches (safe dirs only)  
- `firefox-cleanup` — Clear Firefox caches  
- `logic-au-reset` — Reset Audio Unit cache (forces rescan)  
- `logic-cleanup` — Clear Logic Pro caches + AU reset  
- `finalcut-cleanup` — Clear Final Cut Pro user caches  
- `adobe-premiere-cleanup` — Clear Premiere media caches  
- `adobe-aftereffects-cleanup` — Clear After Effects caches  
- `fcpx-purge-library-renders` — Delete FCPX Render Files/Peaks (per-library confirm)

**Presets**
- `clean-caches` — Consolidated cache cleanup (user/system/font/Quick Look, etc.)  
- `preset-browsers` — Safari + Chrome + Firefox cleanup + DNS flush  
- `preset-editing` — Logic AU reset/cleanup, FCP, Premiere, After Effects caches  
- `full-tuneup` — A sensible sequence (verify, periodic, spotlight, cache resets, etc.)

## Portability
- No hardcoded usernames — paths use `${HOME}`.
- Scripts aim to be idempotent and safe if re-run.
- This repo intentionally does **not** include any features that hide network or Time Machine volumes from the Desktop.

## CI
[![CI](https://github.com/USER/REPO/actions/workflows/ci.yml/badge.svg)](https://github.com/USER/REPO/actions/workflows/ci.yml)
