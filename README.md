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

This process is designed to be as automated as possible. After a fresh macOS installation, open the Terminal and run the following commands in order.

### Step 1: Install Xcode Command Line Tools
This is the only prerequisite. It will install `git` and other essential tools needed for the next step.

```bash
xcode-select --install
```
Follow the on-screen prompts to complete the installation before proceeding.

### Step 2: Clone the Repository
Now that `git` is installed, you can clone this repository.

```bash
git clone https://github.com/sevmorris/mrk1.git ~/mrk1
```

### Step 3: Run the Bootstrap Installer
This single script will handle the rest, including installing Homebrew, applications, and setting up your shell.

```bash
cd ~/mrk1 && ./install
```

---

## 🤖 What the Installer Does

The `./install` script is **idempotent**, meaning you can run it multiple times without breaking anything. It automates the following tasks:

1.  **Installs Xcode Command Line Tools**: A prerequisite for Homebrew and Git.
2.  **Installs Homebrew**: The package manager for macOS.
3.  **Installs Core Tools**: Uses Homebrew to install `gh`, `zsh`, and other essentials.
4.  **Sets Up Zsh**:
    * Installs Oh My Zsh.
    * Clones your preferred Zsh plugins.
    * Sets Homebrew's `zsh` as your default shell automatically.
5.  **Creates Symlinks**: Symlinks all the configuration files (`.zshrc`, `.aliases`, etc.) from this repository into your home directory.
6.  **Installs Applications**: Prompts you to install all GUI and CLI applications listed in the `Brewfile`.
