```
          #_______________//macOS Setup & Personalization with mrk1//____________________#
          #______      ______                                           _           _____#
          #_____      / ____ \________ _   ______ ___  ____  __________(_)____       ____#
          #____      / / __ `/ ___/ _ \ | / / __ `__ \/ __ \/ ___/ ___/ / ___/      _____#
          #___      / / /_/ (__  )  __/ |/ / / / / / / /_/ / /  / /  / (__  )      ______#
          #____     \ \__,_/____/\___/|___/_/ /_/ /_/\____/_/  /_/  /_/____/      _______#
          #_____     \____/                                                      ________#
          #______________________________________________________________________________#
```

This repository contains my personal configuration for quickly setting up a new Apple Silicon Mac with all my preferred tools and settings.

---

## 🚀 Quick Start: One-Step Install

After a fresh macOS installation, open the Terminal and run these commands.

1.  **Clone the Repository:**
    ```bash
    git clone [https://github.com/sevmorris/mrk1.git](https://github.com/sevmorris/mrk1.git) ~/mrk1
    ```
2.  **Run the Bootstrap Installer:**
    ```bash
    cd ~/mrk1 && ./install
    ```
The installer script will guide you through the rest of the process, including installing required tools and applications.

---

## 🤖 What the Installer Does

The `./install` script is **idempotent**, meaning you can run it multiple times without breaking anything. It automates the following tasks:

1.  **Installs Xcode Command Line Tools**: A prerequisite for Homebrew and Git.
2.  **Installs Homebrew**: The package manager for macOS.
3.  **Installs Core Tools**: Uses Homebrew to install `git`, `gh`, `zsh`, and other essentials.
4.  **Sets Up Zsh**:
    * Installs Oh My Zsh.
    * Clones your preferred Zsh plugins (`zsh-syntax-highlighting`, etc.).
    * Sets Homebrew's `zsh` as your default shell automatically.
5.  **Creates Symlinks**: Symlinks all the configuration files (`.zshrc`, `.aliases`, etc.) from this repository into your home directory.
6.  **Installs Applications**: Prompts you to install all GUI and CLI applications listed in the `Brewfile`.

---

## 💡 How It Works

This repository must remain at `~/mrk1`. The installer creates symbolic links (symlinks) from the dotfiles in this repo to their correct locations in your home directory (e.g., `~/.zshrc`).

This allows you to edit the files in the `~/mrk1` repo, commit the changes, and use the `syncall` command to push your updated configuration to GitHub.
