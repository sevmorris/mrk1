#!/usr/bin/env bash
# macOS defaults configuration

# Security & System
echo "Configuring security & system..."
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on

# Finder
echo "Configuring Finder..."
defaults write com.apple.finder QuitMenuItem -bool true
defaults write com.apple.finder NewWindowTarget -string "PfDe"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Desktop"
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder _FXSortFoldersFirst -bool true
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
defaults write com.apple.finder QLEnableTextSelection -bool true

# Hide network (remote) Time Machine volumes from the Desktop
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false

# Dock
echo "Configuring Dock..."
defaults write com.apple.dock orientation -string left
defaults write com.apple.dock tilesize -int 36
defaults write com.apple.dock minimize-to-application -bool true
defaults write com.apple.dock show-recents -bool false

# General UI/UX
echo "Configuring general UI/UX..."
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSFullKeyboardAccess -bool true
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Activity Monitor
echo "Configuring Activity Monitor..."
defaults write com.apple.ActivityMonitor ShowCategory -int 0
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

# App Store
echo "Configuring App Store..."
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true
defaults write com.apple.SoftwareUpdate AutomaticDownload -bool true
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -bool true

# Time Machine
echo "Configuring Time Machine..."
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Apply Finder & Dock changes
killall Finder >/dev/null 2>&1
killall Dock >/dev/null 2>&1

echo "✅ Done. Some changes may require a logout or restart."
