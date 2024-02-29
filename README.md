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

```
gh repo clone sevmorris/mrk1
cd ~/mrk1
./install
```

Run restore script to move Preferences to the Mac

```
source .zshenv
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
