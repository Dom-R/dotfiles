#!/usr/bin/env bash

. scripts/functions.sh

# Install HACK font
function download_hack() {
    info "downloading HACK font"
    if wget $(curl -s https://api.github.com/repos/source-foundry/Hack/releases/latest | grep -E '.*browser_.*ttf.zip' | cut -d\" -f4) -P $DOTFILES_REPO/fonts; then
        success "HACK font downloaded"
    else
        error "There was an error downloading HACK font"
        exit 1
    fi
}

function unzip_hack() {
    info "uzipping HACK font"
    if unzip -j $DOTFILES_REPO/fonts/*.zip -d $DOTFILES_REPO/fonts/; then
        success "Unzipped font"
    else
        error "Could not unzip font"
    fi
}

function move_font {
    info "Moving fonts to /Library/Fonts/"
    if cp $DOTFILES_REPO/fonts/*.ttf /Library/Fonts/; then
        success "Installed fonts"
    else
        error "Unable to install fonts"
    fi
}

download_hack
unzip_hack
move_font
