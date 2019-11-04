# Lines configured by zsh-newuser-install
HISTFILE=~/.local/share/zsh/zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/dominik/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
#

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Add rbenv
export PATH="$HOME/.rbenv/bin:$PATH"

# Load rbenv automatically
eval "$(rbenv init -)"

# force fzf to use ripgrep
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
