#!/usr/bin/env bash

. scripts/functions.sh

function git_aliases() {
    git config --global alias.co checkout
    git config --global alias.br branch
    git config --global alias.ci commit
    git config --global alias.st status
}

info "Adding git aliases"
if git_aliases; then
  success "Adding git aliases succeded"
else
  error "Adding git aliases failed"
fi
