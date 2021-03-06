# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/dominik/.oh-my-zsh"

ZSH_THEME="robbyrussell"

# History Settings
HISTFILE=~/.local/share/zsh/zsh_history
setopt hist_ignore_all_dups
setopt hist_ignore_space

## Plugin Settings ##

# tmux
ZSH_TMUX_AUTOSTART=true

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git tmux fzf asdf)

source $ZSH/oh-my-zsh.sh

# User configuration

# Enable jump https://github.com/gsamokovarov/jump
# AUR package: jump-bin
eval "$(jump shell --bind=z)"

# force fzf to use ripgrep
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'

# fd alias for ubuntu
alias fd=fdfind

export EDITOR=nvim
