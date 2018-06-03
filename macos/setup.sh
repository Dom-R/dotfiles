#!/usr/bin/env bash

defaults write -g AppleInterfaceStyle 'Dark' # Turns Dark Mode on
defaults write -g AppleEnableSwipeNavigateWithScrolls -bool false # removes two-finger back/forward navigation
defaults write -g ApplePressAndHoldEnabled -bool false

# Sleep Mode
sudo systemsetup -setcomputersleep Never # Computer never sleep
sudo systemsetup -setdisplaysleep 5 # Display sleeps after 5 minutes 
sudo pmset -a hibernatemode 0 # Disable hibernation

# Dock
defaults write com.apple.Dock persistent-apps -array # Wipe all (default) app icons from the Dock
defaults write com.apple.dock autohide -bool true # Enable autohide

# Menu Bar and Dock
defaults write com.apple.UniversalAccess reduceTransparency -bool true # Disable Menu Bar and Dock transparency

# Login screen
defaults write com.apple.screensaver askForPassword -bool true
defaults write com.apple.screensaver askForPasswordDelay -int 0
