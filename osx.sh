#! /bin/bash
# Shamelessly stolen from https://github.com/mathiasbynens/dotfiles/blob/master/.osx

# Show the ~/Library folder
chflags nohidden ~/Library

# Enable the 2D Dock
defaults write com.apple.dock no-glass -bool true

# Disable menu bar transparency
defaults write NSGlobalDomain AppleEnableMenuBarTransparency -bool false

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Enable snap-to-grid for desktop icons
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Enable tap to click (Trackpad)
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

# Disable all the other Ping stuff in iTunes
defaults write com.apple.iTunes disablePing -bool true

# Disable the Ping sidebar in iTunes
defaults write com.apple.iTunes disablePingSidebar -bool true


# Kill affected applications
for app in Finder Dock SystemUIServer
do
	killall "$app" >/dev/null 2>&1
done
