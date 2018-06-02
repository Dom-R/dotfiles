#! /usr/bin/env bash

main() {
    install_brew
    brew_install git
    clone_repo
    install_brewfiles
}

DOTFILES_REPO=~/.dotfiles

# Install specific package
function brew_install() {
    package_to_install="$1"
    info "brew install ${package_to_install}"
    if hash "$package_to_install" 2>/dev/null; then
        success "${package_to_install} already exists."
    else
        if brew install "$package_to_install"; then
            success "Package ${package_to_install} installation succeeded."
        else
            error "Package ${package_to_install} installation failed."
            exit 1
        fi
    fi
}

function clone_repo() {
    info "Cloning dotfiles into ${DOTFILES_REPO} ..."
    if test -e $DOTFILES_REPO; then
        substep "${DOTFILES_REPO} already exists."
    else
        url=https://github.com/Sajjadhosn/dotfiles.git
        if git clone "$url" $DOTFILES_REPO; then
            success "Cloning into ${DOTFILES_REPO} succeded."
        else
            error "Cloning into ${DOTFILES_REPO} failed."
            exit 1
        fi
    fi
}

# Install Homebrew
function install_brew() {
    info "Installing Homebrew..."
    if [[ $(which brew) == "/usr/local/bin/brew" ]]
    then
        info "Homebrew installed already, skipping"
    else
        if /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"; then
            success "Homebrew installed succeded."
        else
            error "Homebrew installation failed."
            exit 1
        fi
    fi
}

function install_brewfiles() {
    info "Installing packages from Brewfile"
    if brew bundle --file=$DOTFILES_REPO/Brewfile; then
            success "Brewfile installation succeeded."
        else
            error "Brewfile installation failed."
            exit 1
    fi
}

# Coloring info
function coloredEcho() {
    local exp="$1";
    local color="$2";
    local arrow="$3";
    if ! [[ $color =~ '^[0-9]$' ]] ; then
       case $(echo $color | tr '[:upper:]' '[:lower:]') in
        black) color=0 ;;
        red) color=1 ;;
        green) color=2 ;;
        yellow) color=3 ;;
        blue) color=4 ;;
        magenta) color=5 ;;
        cyan) color=6 ;;
        white|*) color=7 ;; # white or invalid color
       esac
    fi
    tput bold;
    tput setaf "$color";
    echo "$arrow $exp";
    tput sgr0;
}

function info() {
    coloredEcho "$1" blue "========>"
}

function success() {
    coloredEcho "$1" green "========>"
}

function error() {
    coloredEcho "$1" red "========>"
}

main "$@"
