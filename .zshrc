# Lines configured by zsh-newuser-install
HISTFILE=~/.local/share/zsh/zsh_history
HISTSIZE=5000
SAVEHIST=5000
setopt hist_ignore_all_dups
setopt share_history
setopt appendhistory
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/dominik/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Enable fzf
[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh

# Enable jump https://github.com/gsamokovarov/jump
# AUR package: jump-bin
eval "$(jump shell --bind=z)"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# force fzf to use ripgrep
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'

