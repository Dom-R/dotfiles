# rbenv compatibility
status --is-interactive; and source (rbenv init -|psub)

# force fzf to use ripgrep
set --export FZF_DEFAULT_COMMAND 'rg --files --no-ignore --hidden --follow --glob "!.git/*"'

# Set locale due to nvim error message related to locale. More here https://stackoverflow.com/questions/56716993
set --export LC_ALL 'en_US.UTF-8'
