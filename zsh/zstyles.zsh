# vim: ft=zsh

# Customize completion menu behavior
zstyle ':completion:*' menu select

# Use colors from LS_COLORS for completion list
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Enable verbose completion
zstyle ':completion:*' verbose yes

# Customize completion descriptions format
zstyle ':completion:*:descriptions' format "$fg[yellow]%B--- %d%b"

# Customize completion messages format
zstyle ':completion:*:messages' format '%d'

# Customize completion warnings format
zstyle ':completion:*:warnings' format "$fg[red]No matches for:$reset_color %d"

# Customize completion corrections format
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'

# Disable grouping of completion results
zstyle ':completion:*' group-name ''
