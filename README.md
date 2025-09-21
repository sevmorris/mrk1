```
          #_______________//macOS Setup & Personalization with mrk1//____________________#
```

This repository contains my personal configuration for quickly setting up a new **Apple Silicon Mac** with my preferred tools, dotfiles, applications, and macOS defaults.

It is powered by a single **idempotent installer script** — you can run it multiple times without breaking anything.


---

## ⚡ Quick Start

After a fresh macOS installation:

### 1. Clone the Repository
The installer script will automatically prompt you to install Xcode Command Line Tools if they are missing.
```bash
git clone https://github.com/sevmorris/mrk1.git ~/mrk1
```

### 2. Run the Installer
```bash
cd ~/mrk1/scripts && ./install
```

---

### 🚀 Alternative One-Line Bootstrap
If you’d like to skip the manual clone step, you can run this **direct installer**:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/sevmorris/mrk1/main/scripts/install)"
```

⚠️ **Note**: Running scripts directly from the internet is inherently risky.
Review the [`install.sh`](scripts/install) script before using this method.

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
7.  **Executable Scripts** – Links helper scripts (`backup`, `restore`, `syncall`) into `~/.local/bin`.
8.  **Default Shell** – Switches your login shell to Homebrew Zsh.
9.  **macOS Defaults** – Applies system preferences via `scripts/defaults.sh` (if available).
10. **App Installations via Brewfile** – After a single confirmation prompt, it installs all CLI tools, Mac App Store apps, and GUI apps (casks) listed in your `Brewfile`.

---

## 🛠️ Optional / Customization

You can edit these before or after running the installer:

- `dotfiles/` → Your personal Zsh and shell configs.
- `assets/Brewfile` → Add/remove apps and packages.
- `scripts/defaults.sh` → macOS defaults (trackpad, Dock, Finder, etc).
- `scripts/` → Custom helper scripts (linked into `~/.local/bin`).

---

## 🔄 Running Again

The installer is **idempotent**. Running it multiple times:
- Won’t reinstall things unnecessarily.
- Will safely re-link configs and re-apply updates.

---

## ❌ Uninstall / Rollback

This script does **not** provide an automatic rollback. If you want to undo:
- Remove symlinks in your home directory (`.zshrc`, `.aliases`, etc).
- Unlink/remove scripts in `~/.local/bin`.
- Uninstall apps with `brew uninstall` or `brew bundle cleanup`.
- Reset macOS defaults manually or with `defaults delete`.

---

## 📦 Requirements

- macOS 13 Ventura or newer (Apple Silicon).
- Internet connection.
- Basic familiarity with the Terminal.

---

## ✨ Example Run

```bash
==> Checking for Xcode Command Line Tools...
✅ Xcode Command Line Tools already installed

==> Checking for Homebrew...
✅ Homebrew already installed

==> Installing core tools via Homebrew Bundle...
✅ zsh already installed
✅ iterm2 already installed
...
```


## Bootstrap commands

Helpers live in `scripts/bootstrap`:

```bash
# One-shot setup (brew -> dotfiles -> tools -> defaults -> doctor)
./scripts/bootstrap bootstrap

# Individual steps
./scripts/bootstrap brew       # Brew Bundle from assets/Brewfile* or ./Brewfile
./scripts/bootstrap dotfiles   # Link dotfiles/* into $HOME (backs up originals)
./scripts/bootstrap tools      # Link shebang'd scripts into ~/.local/bin
./scripts/bootstrap defaults   # Run scripts/defaults.sh if present
./scripts/bootstrap doctor     # Run health checks
./scripts/bootstrap heal       # Attempt automatic fixes (doctor --fix)
```

Using make (same commands under the hood):

```bash
make bootstrap
make brew
make dotfiles
make tools
make defaults
make doctor
make heal
```
