# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/dominik/.oh-my-zsh"

ZSH_THEME="robbyrussell"

# History Settings
HISTFILE=~/.local/share/zsh/zsh_history
setopt hist_ignore_all_dups

## Plugin Settings ##

# tmux
ZSH_TMUX_AUTOSTART=true

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git tmux)

source $ZSH/oh-my-zsh.sh

# User configuration

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Enable fzf
[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh

# Enable jump https://github.com/gsamokovarov/jump
# AUR package: jump-bin
eval "$(jump shell --bind=z)"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# force fzf to use ripgrep
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'

