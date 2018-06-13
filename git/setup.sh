#!/usr/bin/env bash

. scripts/functions.sh

function configure_git() {
      username="Dom-R"
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

configure_git
info "Adding git aliases"
if git_aliases; then
  success "Adding git aliases succeded"
else
  error "Adding git aliases failed"
fi
