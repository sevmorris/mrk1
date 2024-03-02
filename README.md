```
          #__________________//macOS Personalization with mrk1//_________________________#
          #______      ______                                           _           _____#
          #_____      / ____ \________ _   ______ ___  ____  __________(_)____       ____#
          #____      / / __ `/ ___/ _ \ | / / __ `__ \/ __ \/ ___/ ___/ / ___/      _____#
          #___      / / /_/ (__  )  __/ |/ / / / / / / /_/ / /  / /  / (__  )      ______#
          #____     \ \__,_/____/\___/|___/_/ /_/ /_/\____/_/  /_/  /_/____/      _______#
          #_____     \____/                                                      ________#
          #______________________________________________________________________________#
```

This repository helps me quickly customize a fresh macOS installation with my preferred tools, settings, and configurations.

## Getting Started

**Prerequisites:**

* A fresh macOS installation
* Xcode Command Line Tools (install if needed: `xcode-select --install`)


**Step-by-Step Setup**

1. **Install Homebrew:**
   ```
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

2. **Install git & GitHub CLI:**
   ```
   brew install git gh
   ```

3. **Install oh-my-zsh:**
   ```
   sh -c "$(curl -fsSL [https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh](https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh))"  "" --unattended
   ```

4. **Install oh-my-zsh Plugins:**
   ```
   plugins_dir="${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins"
   mkdir -p "$plugins_dir"

   git clone [https://github.com/zsh-users/zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) "$plugins_dir"
   git clone [https://github.com/zsh-users/zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) "$plugins_dir"
   git clone [https://github.com/gretzky/auto-color-ls](https://github.com/gretzky/auto-color-ls) "$plugins_dir"
   gh completion --shell zsh > "$plugins_dir/gh.zsh"
   ```

5. **Clone this Repository:**
   ```
   gh repo clone sevmorris/mrk1
   ```

6. **Run the Installer:**
   ```
   cd ~/mrk1
   chmod +x install
   ./install
   ```  


## Additional Instructions

1. **Restoring Preferences and Application Saved States:**

  Load environment variables from .zshenv

  ```
  source ~/.zshenv
  ```

  Run the restore script to move Preferences & Saved Application State files from ~/.backups (pulled from a private repo)

  ```
  restore
  ```

2. **Switching to Homebrew's Zsh:**

  Add Homebrew's Zsh to the list of valid shells and switch to it.

  ```
  sudo sh -c 'echo "${BREW_PREFIX}/bin/zsh" >> /etc/shells'
  chsh -s "${BREW_PREFIX}/bin/zsh"
  ```

3. **Removing Dock Icons (Optional):**

  Reset the macOS Dock to its default (empty) state

  ```
  defaults write com.apple.dock persistent-apps -array
  killAll Dock
  ```
___

  This script is designed to set up and configure various aspects of a user's macOS environment. Let's break down its logical flow:

  1. **Setting up Initial Configuration:**
     - The script starts with the shebang (`#!/usr/bin/env bash`) to specify that it's a Bash script.
     - `set -e` is used to exit the script immediately if any command within it fails.

  2. **Defining Path Variables:**
     - Variables are set to define the base directory for the "mrk1" project (`mrk1_dir`), locations of dotfiles (`dotfiles`), project-specific scripts (`scripts`), and a script for macOS default tweaks (`mac_defaults`).
     - Variables are set for user-specific binaries (`bin`) and Oh My Zsh customizations (`OMZ_CUSTOM`).

  3. **Copying Configuration Files:**
     - Copies a custom config file for the `topgrade` tool to `~/.config`.
     - Copies an up-to-date `Brewfile` to the home directory.

  4. **Creating Backups Directory:**
     - Checks if a directory for Preferences & Saved Application State backups (`backups_dir`) exists. If not, it creates one.

  5. **Creating Symbolic Links for Dotfiles:**
     - Creates symbolic links in the home directory for specific dotfiles related to aliases and Zsh configuration.

  6. **Creating Symbolic Links for Scripts:**
     - Creates symbolic links in `~/.local/bin` for project-specific scripts (backup, restore, syncall).

  7. **Creating Symbolic Link for .aliases in Oh My Zsh Custom Directory:**
     - Creates a symbolic link for the `.aliases` file in the Oh My Zsh custom directory (`OMZ_CUSTOM`).

  8. **Applying macOS Default Tweaks:**
     - Executes a script (`mac_defaults.sh`) to apply various macOS default tweaks.

  9. **Creating .hushlogin:**
     - Checks if `.hushlogin` exists in the home directory. If not, it creates an empty file to suppress login messages.

  10. **Running Brew Bundle:**

     - Changes to the home directory (`cd "$HOME"`) and runs `brew bundle install` to install Homebrew packages and applications based on the provided `Brewfile`.

  This script is intended to streamline the setup process for a user's macOS environment, ensuring that configurations, dotfiles, and applications are in the desired state. The use of symbolic links allows for easy synchronization of configuration files across different machines. The script also includes steps to create backups and suppress login messages.
