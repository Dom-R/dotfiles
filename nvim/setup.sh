#! /usr/bin/env sh

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

symlink init.vim ~/.config/nvim/init.vim
