#!/usr/bin/env bash

main() {
    configure_git
    git_aliases
    git_editor
    symlink_neovim
    symlink_zshrc
    symlink_tmux_conf
    symlink_sway
    symlink_waybar
    symlink_rofi
    symlink_alacritty
}

DOTFILES_REPO=~/.dotfiles

function configure_git() {
    username="Dominik Reller"
    email="Dom-R@users.noreply.github.com"

    git config --global user.name "$username"
    git config --global user.email "$email"
}

function git_aliases() {
    git config --global alias.co checkout
    git config --global alias.br branch
    git config --global alias.ci commit
    git config --global alias.st status
}

function git_editor() {
    git config --global core.editor "nvim"
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
