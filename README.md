
# macOS Personalization with mrk1

This repository helps me quickly customize a fresh macOS installation with my preferred tools, settings, and configurations.

## Getting Started

**Prerequisites:**

* A fresh macOS installation
* Xcode Command Line Tools (install if needed: `xcode-select --install`)


**Step-by-Step Setup**

1. **Install Homebrew:**
   ```bash
   /bin/bash -c "$(curl -fsSL [https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh](https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh))"
   ```

2. **Install git, GitHub CLI, and Zsh:**
   ```bash
   brew install git gh zsh
   ```

3. **Install oh-my-zsh:**
   ```bash
   sh -c "$(curl -fsSL [https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh](https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh))"  "" --unattended
   ```

4. **Install oh-my-zsh Plugins:**
   ```bash
   plugins_dir="${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins"
   mkdir -p "$plugins_dir"

   git clone [https://github.com/zsh-users/zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) "$plugins_dir"
   git clone [https://github.com/zsh-users/zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) "$plugins_dir"
   git clone [https://github.com/gretzky/auto-color-ls](https://github.com/gretzky/auto-color-ls) "$plugins_dir"
   gh completion --shell zsh > "$plugins_dir/gh.zsh"
   ```

5. **Clone this Repository:**
   ```bash
   gh repo clone sevmorris/mrk1
   ```

6. **Run the Installer:**
   ```bash
   cd mrk1
   ./install
   ```  

**Note:** The installer script provides options to tailor how dotfiles and macOS defaults are applied.


**Additional Instructions**

1. **Restoring Preferences:**

Load environment variables from .zshenv

  ```bash
  source ~/.zshenv
  ```

Run the restore script

  ```bash
  restore
  ```

2. **Switching to Homebrew's Zsh:**

Add Homebrew's Zsh to the list of valid shells


  ```
  sudo sh -c 'echo "${BREW_PREFIX}/bin/zsh" >> /etc/shells'
  ```

Switch to Homebrew's Zsh

  ```
  chsh -s "${BREW_PREFIX}/bin/zsh"
  ```

3. **Removing Dock Icons (Optional):**

Reset the macOS Dock to its default (empty) state

  ```
  defaults write com.apple.dock persistent-apps -array
  killAll Dock
  ```
