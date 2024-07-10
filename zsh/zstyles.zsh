# -- styles settings ---------------------------------------------------------
zstyle ':completion:*' menu select                                               # Enable menu selection for completion
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}                            # Use colors from LS_COLORS for completion list
zstyle ':completion:*' verbose yes                                               # Enable verbose completion
zstyle ':completion:*' group-name ''                                             # Disable grouping of completion results
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}                            # Set list-colors to enable filename colorizing
zstyle ':completion:*' menu no                                                   # Force zsh not to show completion menu

zstyle ':completion:*:messages' format '%d'                                      # Customize completion messages format
zstyle ':completion:*:warnings' format "$fg[red]No matches for:$reset_color %d"  # Customize completion warnings format
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'                  # Customize completion corrections format
zstyle ':completion:*descriptions' format "$fg[yellow]%B--- %d%b"                # Customize completion descriptions forma
zstyle ':completion:*:descriptions' format '[%d]'                                # Set descriptions format to enable group support

# -- fzf-tab styles ---------------------------------------------------------
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always --icons $realpath'                                              # Preview directory's content with eza
zstyle ':fzf-tab:complete:fzf:*' fzf-preview 'eza -1 --color=always --icons $realpath'                                              # Preview directory's content with eza
zstyle ':fzf-tab:*' switch-group '<' '>'                                         # Switch group using `<` and `>`
zstyle ':fzf-tab:*' height '80%'                                                 # Set height of popup
