#!/usr/bin/env bash

main() {
    configure_git
    symlink_neovim
    symlink_zshrc
    symlink_tmux_conf
#    symlink_sway
#    symlink_waybar
#    symlink_rofi
    symlink_alacritty
}

DOTFILES_REPO=~/.dotfiles

function configure_git() {
    ln -fs "$DOTFILES_REPO/gitconfig" ~/.gitconfig
}

function symlink_neovim() {
    cp -fprsT "$DOTFILES_REPO/nvim" ~/.config/nvim/
}

function symlink_zshrc() {
    ln -fs "$DOTFILES_REPO/zshrc" ~/.zshrc
}

function symlink_tmux_conf() {
    ln -fs "$DOTFILES_REPO/tmux.conf" ~/.tmux.conf
}

function symlink_sway() {
    cp -fprsT "$DOTFILES_REPO/sway/" ~/.config/sway/
}

function symlink_waybar() {
    cp -fprsT "$DOTFILES_REPO/waybar/" ~/.config/waybar/
}

function symlink_rofi() {
    cp -fprsT "$DOTFILES_REPO/rofi/" ~/.config/rofi/
}

function symlink_alacritty() {
    cp -fprsT "$DOTFILES_REPO/alacritty/" ~/.config/alacritty/
}

main "$@"
