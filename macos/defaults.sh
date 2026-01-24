#!/bin/bash

#===============================================================================
# macOS System Defaults
# 
# Apply sensible macOS defaults for developers
# Run: ./macos/defaults.sh
#
# Some changes require a logout/restart to take effect.
# Many settings are applied to com.apple.* domains - be careful!
#===============================================================================

set -euo pipefail

echo "Applying macOS defaults..."

#-------------------------------------------------------------------------------
# Ask for admin password upfront
#-------------------------------------------------------------------------------
sudo -v

# Keep-alive: update existing sudo timestamp until script finishes
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

#===============================================================================
# Keyboard
#===============================================================================
echo "Configuring keyboard..."

# Enable key repeat (disable press-and-hold for special characters)
defaults write -g ApplePressAndHoldEnabled -bool false

# Fast key repeat rate
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Disable automatic capitalization
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Disable smart dashes
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Disable automatic period substitution
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Disable smart quotes
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

#===============================================================================
# Trackpad
#===============================================================================
echo "Configuring trackpad..."

# Enable tap to click
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Natural scrolling (enabled by default, but explicit)
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool true

#===============================================================================
# Finder
#===============================================================================
echo "Configuring Finder..."

# Show hidden files
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Use list view in all Finder windows by default
# Four-letter codes for views: `icnv`, `clmv`, `glyv`, `Nlsv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# New Finder windows open in home directory
defaults write com.apple.finder NewWindowTarget -string "PfHm"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

# Show the ~/Library folder
chflags nohidden ~/Library

# Show the /Volumes folder
sudo chflags nohidden /Volumes

#===============================================================================
# Dock
#===============================================================================
echo "Configuring Dock..."

# Set Dock icon size
defaults write com.apple.dock tilesize -int 36

# Disable Dock auto-hide
defaults write com.apple.dock autohide -bool false

# Speed up Dock reveal (when auto-hide is on)
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.3

# Don't show recent applications in Dock
defaults write com.apple.dock show-recents -bool false

# Minimize windows into their application's icon
defaults write com.apple.dock minimize-to-application -bool true

# Don't animate opening applications from the Dock
defaults write com.apple.dock launchanim -bool false

#===============================================================================
# Screenshots
#===============================================================================
echo "Configuring screenshots..."

# Create screenshots directory if it doesn't exist
mkdir -p "${HOME}/Screenshots"

# Save screenshots to ~/Screenshots
defaults write com.apple.screencapture location -string "${HOME}/Screenshots"

# Save screenshots in PNG format
defaults write com.apple.screencapture type -string "png"

# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true

#===============================================================================
# Activity Monitor
#===============================================================================
echo "Configuring Activity Monitor..."

# Show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

#===============================================================================
# Safari
#===============================================================================
echo "Configuring Safari..."

# Enable Safari's debug menu
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# Enable the Develop menu and Web Inspector
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# Add context menu item for showing Web Inspector in web views
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

#===============================================================================
# Terminal
#===============================================================================
echo "Configuring Terminal..."

# Only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4

#===============================================================================
# Time Machine
#===============================================================================
echo "Configuring Time Machine..."

# Prevent Time Machine from prompting to use new hard drives as backup volume
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

#===============================================================================
# Animations (Disabled for Performance)
#===============================================================================
echo "Disabling animations..."

# Disable window animations
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

# Disable Quick Look animations
defaults write -g QLPanelAnimationDuration -float 0

# Disable Finder animations
defaults write com.apple.finder DisableAllAnimations -bool true

# Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.1

# Disable opening and closing window animations
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

#===============================================================================
# Misc
#===============================================================================
echo "Configuring misc settings..."

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Disable the "Are you sure you want to open this application?" dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

#===============================================================================
# Kill Affected Applications
#===============================================================================
echo "Restarting affected applications..."

for app in "Activity Monitor" \
    "cfprefsd" \
    "Dock" \
    "Finder" \
    "Safari" \
    "SystemUIServer" \
    "Terminal"; do
    killall "${app}" &> /dev/null || true
done

echo ""
echo "✅ macOS defaults applied!"
echo ""
echo "Note: Some of these changes require a logout/restart to take effect."
