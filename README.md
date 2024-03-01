SET UP NEW MAC

Install Homebrew

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Install git, github cli & Zsh

```
brew install git gh zsh
```

Install oh-my-zsh

```
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Add some oh-my-zsh plugins (copy, paste & execute entire block)

```
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
( cd $ZSH_CUSTOM/plugins && git clone https://github.com/gretzky/auto-color-ls )
```

Create the file for gh completion plugin

```
gh completion --shell zsh > $ZSH_CUSTOM/plugins/gh.zsh
```

Clone this repo and run install script (Note: This will replace the .zshrc file created by oh-my-zsh with my modified version)

**Purpose**

The install script automates the setup of a personal development environment along with associated macOS preferences. It achieves this with the following key actions:

**Actions**

1. **Symlinking Dotfiles:** Creates symbolic links in the user's home directory for configuration files like `.zshenv`, `.zshrc`, and `.aliases`.
2. **Symlinking Scripts:** Creates symbolic links in `~/.local/bin` for project-specific scripts (e.g., `backup`, `restore`, `syncall`).
3. **macOS Defaults:**  Applies macOS customizations using a script named `macdefaults.sh`.
4. **Homebrew Setup:** Copies the project's `Brewfile` (`brewfile` in the code) to the home directory and installs dependencies using 'brew bundle'.
5. **Suppressing Login Messages:** Creates the `.hushlogin` file if it doesn't exist.  

**Additional Features**

* **Error Handling:** The script will exit if there are failures during symlinking operations.
* **User Feedback:** Provides output messages indicating the actions being taken.

**In Summary**

This script streamlines the initial setup of a development environment on macOS, ensuring dotfiles, scripts, and software dependencies are in place.
---

```
gh repo clone sevmorris/mrk1
cd ~/mrk1
./install
```

Run restore script to move Preferences to the Mac

```
source ~/.zshenv
restore
```

Switch to Homebrew's Zsh (execute each line separately)

```
sudo -i
echo ${BREW_PREFIX}/bin/zsh >> /etc/shells
exit
chsh -s ${BREW_PREFIX}/bin/zsh
```

Try out one of the new commands to clean up/update Homebrew & packages

```
brewup
```

To remove all Dock icons (starting fresh after a full macOS install)

```
defaults write com.apple.dock persistent-apps -array
killAll Dock
```
