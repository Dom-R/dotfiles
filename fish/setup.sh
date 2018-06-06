#!/usr/bin/env bash

. scripts/functions.sh

function change_shell_to_fish() {
    info "Fish shell setup..."
    if grep --quiet fish <<< "$SHELL"; then
        success "Fish shell already exists."
    else
        user=$(whoami)
        substep "Adding Fish executable to /etc/shells"
        if grep --fixed-strings --line-regexp --quiet \
            "/usr/local/bin/fish" /etc/shells; then
            substep "Fish executable already exists in /etc/shells"
        else
            if echo /usr/local/bin/fish | sudo tee -a /etc/shells > /dev/null;
            then
                substep "Fish executable successfully added to /etc/shells"
            else
                error "Failed to add Fish executable to /etc/shells"
                return 1
            fi
        fi
        substep "Switching shell to Fish for \"${user}\""
        if sudo chsh -s /usr/local/bin/fish "$user"; then
            success "Fish shell successfully set for \"${user}\""
        else
            error "Please try setting the Fish shell again."
            return 2
        fi
    fi
}

function install_oh_my_fish() {
    info "Installing oh-my-fish..."
    if test -d "$OMF_PATH"; then
        success "Oh-my-fish already exists."
    else
        if curl -L https://get.oh-my.fish | fish; then
            success "Oh-my-fish installation succeeded."
        else
            error "Oh-my-fish installation failed."
        fi
    fi
}

if change_shell_to_fish; then
    success "Successfully set up fish shell."
else
    error "Failed setting up fish shell."
fi

install_oh_my_fish
