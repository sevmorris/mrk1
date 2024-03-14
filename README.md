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

This repository helps me quickly customize a fresh (Apple Silicone) macOS installation with my preferred tools, settings, and configurations.

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

   git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
   git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
   git clone https://github.com/gretzky/auto-color-ls ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/auto-color-ls
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

**Note:** This repo must remain in place! For simplicty all dotfiles and scripts remain in this project and are symlinked where needed. Changes to the files will not break functionality and are easily synced to Github using the `syncall` command.

## Additional Instructions

**Restoring Preferences and Application Saved States:**

  Load environment variables from .zshenv

  ```
  source ~/.zshenv
  ```

  Run the restore script to move Preferences & Saved Application State files from ~/.backups (pulled from a private repo)

  ```
  restore
  ```

**Switching to Homebrew's Zsh:**

  Add Homebrew's Zsh to the list of valid shells and switch to it.

  ```
  sudo sh -c 'echo "${BREW_PREFIX}/bin/zsh" >> /etc/shells'
  chsh -s "${BREW_PREFIX}/bin/zsh"
  ```

**Removing Dock Icons (Optional):**

  Reset the macOS Dock to its default (empty) state

  ```
  defaults write com.apple.dock persistent-apps -array
  killAll Dock
  ```
