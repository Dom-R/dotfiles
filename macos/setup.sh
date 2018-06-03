#!/usr/bin/env bash

defaults write -g AppleInterfaceStyle 'Dark' # Turns Dark Mode on
defaults write -g AppleEnableSwipeNavigateWithScrolls -bool false # removes two-finger back/forward navigation

# Dock
defaults write com.apple.Dock persistent-apps -array # Wipe all (default) app icons from the Dock

# Menu Bar and Dock
defaults write com.apple.UniversalAccess reduceTransparency -bool true # Disable Menu Bar and Dock transparency
