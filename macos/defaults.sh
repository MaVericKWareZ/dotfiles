#!/usr/bin/env bash

#===============================================================================
# macOS Defaults (2026-safe, developer-friendly)
#===============================================================================

set -euo pipefail

echo "Applying macOS defaults..."

#-------------------------------------------------------------------------------
# Sudo keep-alive
#-------------------------------------------------------------------------------
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

#===============================================================================
# Keyboard (Dev-friendly)
#===============================================================================
echo "Configuring keyboard..."

defaults write -g ApplePressAndHoldEnabled -bool false
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

#===============================================================================
# Trackpad
#===============================================================================
echo "Configuring trackpad..."

defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

#===============================================================================
# Finder
#===============================================================================
echo "Configuring Finder..."

defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder ShowPathbar -bool true

defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
defaults write com.apple.finder _FXSortFoldersFirst -bool true

defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Safer new window target
defaults write com.apple.finder NewWindowTarget -string "PfHm"

# Show useful hidden folders
chflags nohidden ~/Library || true
sudo chflags nohidden /Volumes || true

#===============================================================================
# Dock (Modern + balanced)
#===============================================================================
echo "Configuring Dock..."

# Balanced size + magnification (better than tiny icons)
defaults write com.apple.dock tilesize -int 48
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock largesize -int 72

# Auto-hide ON (fixed comment)
defaults write com.apple.dock autohide -bool true

# Faster reveal
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.25

# Cleaner dock
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock launchanim -bool false

# NOTE: macOS ignores this sometimes now → keep optional
# defaults write com.apple.dock minimize-to-application -bool true

#===============================================================================
# Screenshots
#===============================================================================
echo "Configuring screenshots..."

mkdir -p "${HOME}/Screenshots"
defaults write com.apple.screencapture location -string "${HOME}/Screenshots"
defaults write com.apple.screencapture type -string "png"
defaults write com.apple.screencapture disable-shadow -bool true

#===============================================================================
# Activity Monitor
#===============================================================================
echo "Configuring Activity Monitor..."

defaults write com.apple.ActivityMonitor OpenMainWindow -bool true
defaults write com.apple.ActivityMonitor ShowCategory -int 0
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

#===============================================================================
# Terminal
#===============================================================================
echo "Configuring Terminal..."

defaults write com.apple.terminal StringEncodings -array 4

#===============================================================================
# Time Machine
#===============================================================================
echo "Configuring Time Machine..."

defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

#===============================================================================
# Performance (safe tweaks only)
#===============================================================================
echo "Optimizing animations..."

# Still respected in modern macOS
defaults write com.apple.dock expose-animation-duration -float 0.1

# Some older animation toggles removed (no longer reliable)
# Keeping only safe ones

#===============================================================================
# Misc
#===============================================================================
echo "Configuring misc settings..."

defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Gatekeeper tweak (optional — can be controversial)
# defaults write com.apple.LaunchServices LSQuarantine -bool false

defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# do not open previous previewed files (e.g. PDFs) when opening a new one
defaults write com.apple.Preview ApplePersistenceIgnoreState YES

#===============================================================================
# Apply changes
#===============================================================================
echo "Restarting affected services..."

for app in "Dock" "Finder" "SystemUIServer"; do
    killall "${app}" &> /dev/null || true
done

echo ""
echo "✅ macOS defaults applied (2026 safe)"
echo "ℹ️ Some changes may require logout/restart"