# rbenv compatibility
status --is-interactive; and source (rbenv init -|psub)

set --export FZF_DEFAULT_COMMAND 'ag --hidden --ignore .git -g ""'
