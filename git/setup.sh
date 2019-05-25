#!/usr/bin/env bash

. scripts/functions.sh

function configure_git() {
      username="Dominik Reller"
      email="Dom-R@users.noreply.github.com"

      info "Configuring git..."
      if git config --global user.name "$username" && \
         git config --global user.email "$email"; then
          success "Git configuration succeeded."
      else
          error "Git configuration failed."
      fi
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

configure_git
info "Adding git aliases"
if git_aliases; then
  success "Adding git aliases succeded"
else
  error "Adding git aliases failed"
fi
info "Changing git edit"
if git_editor; then
  success "Changing git editor succeded"
else
  error "Changing git editor failed"
fi
