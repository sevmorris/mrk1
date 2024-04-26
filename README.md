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

This repository helps me quickly customize a fresh (Apple Silicone) macOS installation with my preferred tools, settings, and configurations.

## Getting Started

### Prerequisites

* A fresh macOS installation
* Xcode Command Line Tools (install if needed: `xcode-select --install`)


### Step-by-Step Setup

1. **Install Homebrew:**
   ```
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

2. **Run the following two commands to add Homebrew to PATH**
   ```
   (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/sev/.zprofile
   eval "$(/opt/homebrew/bin/brew shellenv)"
   ```

3. **Install git, GitHub CLI & zsh:**
   ```
   brew install git gh zsh
   ```

4. **Authorize GitHub account for GitHub CLI***
   ```
   gh auth login
   ```

5. **Install oh-my-zsh:**
   ```
   sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
   ```

6. **Install oh-my-zsh Plugins:**
   ```
   plugins_dir="${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins"
   mkdir -p "$plugins_dir"

   git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
   git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
   git clone https://github.com/gretzky/auto-color-ls ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/auto-color-ls
   gh completion --shell zsh > "$plugins_dir/gh.zsh"
   ```

7. **Clone this Repository:**
   ```
   gh repo clone sevmorris/mrk1
   ```

8. **Run the Installer:**
   ```
   cd ~/mrk1
   chmod +x install
   ./install
   ```  

**Note:** This repo must remain in place! For simplicity and convenience all dotfiles and scripts remain in this project and are symlinked where needed. Changes to the files will not break functionality and are easily synced to Github using the `syncall` command.

## Additional Instructions

### Switch to Homebrew's Zsh

  1. **Open /etc/shells**
  ```
  sudo nano /etc/shells
  ```

  2. **Add Homebrew's Zsh to to /etc/shells by pasting the following**
  ```
  /opt/homebrew/bin/zsh
  ```

  3. **And finally, switch to Homebrew's Zsh**
  ```
  chsh -s /opt/homebrew/bin/zsh
  ```

### Remove Default Dock Icons (Optional)
  ```
  defaults write com.apple.dock persistent-apps -array
  killAll Dock
  ```
