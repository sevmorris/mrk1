#!/usr/bin/env bash

# --- Script Configuration & Safety ---
#
# Exit immediately if a command exits with a non-zero status.
set -e
# Treat unset variables as an error when substituting.
set -u
# Pipes fail if any command in the pipe fails.
set -o pipefail

# --- Functions ---

# Prints a formatted header for each section.
header() {
  echo
  echo "--- $1 ---"
}

# --- Main Script ---

echo "This script will configure macOS with a set of custom defaults."
read -p "Do you want to proceed? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Operation cancelled."
    exit 1
fi

# Ask for the administrator password upfront and keep it alive.
echo "Administrator privileges are required to change some system-wide settings."
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# --- System & Security Settings ---
header "Configuring Security & System"

# Require password immediately after sleep or screen saver begins.
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Enable the system-level firewall.
sudo defaults write /Library/Preferences/com.apple.alf globalstate -int 1
sudo launchctl load /System/Library/LaunchDaemons/com.apple.alf.agent.plist 2>/dev/null || true

# Show the ~/Library directory.
chflags nohidden "${HOME}/Library"

# Show the /Volumes folder.
sudo chflags nohidden /Volumes

# --- Finder ---
header "Configuring Finder"

# Quit Finder via ⌘ + Q.
defaults write com.apple.finder QuitMenuItem -bool true

# Set Desktop as the default location for new Finder windows.
# For other options, see: https://apple.stackexchange.com/a/328479
defaults write com.apple.finder NewWindowTarget -string "PfDe"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Desktop/"

# Show status bar and path bar.
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder ShowPathbar -bool true

# Keep folders on top when sorting by name.
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# When performing a search, search the current folder by default.
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension.
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Avoid creating .DS_Store files on network or USB volumes.
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Use list view in all Finder windows by default (Nlsv=List, icnv=Icon, clmv=Column).
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Show icons for hard drives, servers, and removable media on the desktop.
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Disable the warning before emptying the Trash.
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# --- Dock & Mission Control ---
header "Configuring Dock & Mission Control"

# Position Dock on the left side of the screen.
defaults write com.apple.dock orientation -string left

# Set the icon size of Dock items.
defaults write com.apple.dock tilesize -int 36

# Set minimize/maximize window effect to "scale".
defaults write com.apple.dock mineffect -string "scale"

# Minimize windows into their application’s icon.
defaults write com.apple.dock minimize-to-application -bool true

# Don’t show recent applications in Dock.
defaults write com.apple.dock show-recents -bool false

# --- General UI/UX ---
header "Configuring General UI/UX"

# Save to disk (not to iCloud) by default.
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Always show scrollbars.
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

# Expand save and print panels by default.
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

# Disable press-and-hold for keys in favor of key repeat.
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Set a fast, but standard, keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Disable smart quotes and dashes as they’re annoying when writing code.
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# --- Activity Monitor ---
header "Configuring Activity Monitor"

# Show the main window when launching Activity Monitor.
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Show all processes in Activity Monitor.
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort Activity Monitor results by CPU usage.
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

# --- App Store ---
header "Configuring App Store Updates"

# Enable automatic update check.
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

# Download newly available updates in the background.
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

# Install System data files & security updates.
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

# Turn on app auto-update.
defaults write com.apple.commerce AutoUpdate -bool true

# --- Safari ---
header "Configuring Safari"

# For security, disable Java. Modern web pages do not use Java applets.
sudo defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled -bool false
sudo defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabledForLocalFiles -bool false

# --- Time Machine ---
header "Configuring Time Machine"

# Prevent Time Machine from prompting to use new hard drives as backup volumes.
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# --- Finalizing ---
header "Applying Settings"

# Restart affected applications to apply changes.
for app in "Activity Monitor" "cfprefsd" "Dock" "Finder" "SystemUIServer" "Safari"; do
    killall "${app}" > /dev/null 2>&1 || true
done

echo
echo "✅ Done. Some changes may require a logout or restart to take full effect."
