# rbenv compatibility
status --is-interactive; and source (rbenv init -|psub)

set --export FZF_DEFAULT_COMMAND 'rg --files --no-ignore --hidden --follow --glob "!.git/*"'
