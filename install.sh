#!/usr/bin/env bash

main() {
    install_pikaur_package
    configure_git
    git_aliases
    git_editor
    symlink_neovim
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
    ln -s "$DOTFILES_REPO/init.vim" ~/.config/nvim/init.vim
}

function install_pikaur_package() {
  pikaur -S --needed $(cat Pikaur)
}

main "$@"
