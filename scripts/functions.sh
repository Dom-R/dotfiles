#! /usr/bin/env sh

DOTFILES_REPO=~/.dotfiles

symlink() {
    dir=$(dirname "$2")

    if test ! -e "$dir"; then
       info "Creating folder path for $2"
       if mkdir -p "$dir"; then
           success "Created folder path successfully."
       else
           error "Created folder path failed."
       fi
    fi
    if ln -s "$1" "$2"; then
        success "Symlinked $2 to $1."
    else
        error "Symlinking $2 to $1 failed."
        exit 1
    fi
}

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

function substep() {
    coloredEcho "$1" magenta "===="
}

function success() {
    coloredEcho "$1" green "========>"
}

function error() {
    coloredEcho "$1" red "========>"
}
