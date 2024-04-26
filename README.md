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


### Step-by-Step Setup

1. Install Homebrew
   ```
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

2. After Homebrew is installed it will prompt you to run the following two commands to add Homebrew to PATH
   ```
   (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/sev/.zprofile
   eval "$(/opt/homebrew/bin/brew shellenv)"
   ```

3. Install git, GitHub CLI & zsh
   ```
   brew install git gh zsh
   ```

4. Authorize your GitHub account to run gh commands
   ```
   gh auth login
   ```

5. Install oh-my-zsh
   ```
   sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
   ```

6. Install a few oh-my-zsh plugins
   ```
   plugins_dir="${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins"
   mkdir -p "$plugins_dir"

   git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
   git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
   git clone https://github.com/gretzky/auto-color-ls ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/auto-color-ls
   gh completion --shell zsh > "$plugins_dir/gh.zsh"
   ```

7. Clone this repo
   ```
   gh repo clone sevmorris/mrk1
   ```

8. Run the Installer
   ```
   cd ~/mrk1
   chmod +x install
   ./install
   ```  

**Note:** This repo must remain in place! The install script creates symlinks to dotfiles and scripts in the correct locations. This way any updates to the dotfiles and Brewfile in the repo will not break functionality and are easily synced to Github using the `syncall` command.

## Additional Instructions

### Switch to Homebrew's Zsh

  1. Open /etc/shells for editing
  ```
  sudo nano /etc/shells
  ```

  2. Add Homebrew's Zsh to to /etc/shells by adding the following line
  ```
  /opt/homebrew/bin/zsh
  ```

  3. And finally, switch to Homebrew's Zsh
  ```
  chsh -s /opt/homebrew/bin/zsh
  ```

### Remove Default Dock Icons (Optional)

  This removes all those Dock icons from a fresh macOS install, leaving only open apps in the Dock
  ```
  defaults write com.apple.dock persistent-apps -array
  killAll Dock
  ```
