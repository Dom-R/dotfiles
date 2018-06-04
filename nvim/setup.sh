#! /usr/bin/env sh

symlink() {
    OVERWRITTEN=""
    if [ -e "$2" ] || [ -h "$2" ]; then
        OVERWRITTEN="(Overwritten)"
        if ! rm -r "$2"; then
          error "Failed to remove existing file(s) at $2."
          exit 1
        fi
    fi
    if ln -s "$1" "$2"; then
        success "Symlinked $2 to $1. $OVERWRITTEN"
    else
        error "Symlinking $2 to $1 failed."
        exit 1
    fi
}

symlink init.vim ~/.config/nvim/init.vim
