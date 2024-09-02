# -- exit shell --------------------------------------------------------------
alias :q='exit'

# -- file operations with safety prompts -------------------------------------
alias ..='cd ..'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -ri'
alias md='mkdir -p'
alias rd='rmdir'

# -- list directory contents -------------------------------------------------
alias l='eza --git --header --long --color=always --icons'
alias ll='eza --git --header --color=always --icons'
alias la='eza -all --git --header --long --color=always --icons'

# -- colorize ----------------------------------------------------------------
alias bat="bat --color=always"
alias ncdu="ncdu --color=dark --extended --fast-ui-updates --enable-delete"
alias grep="grep --color=always"
alias diff="diff --color=auto"

# -- use neovim instead of vim -----------------------------------------------
alias vi='nvim'
alias vim='nvim'

fzf_open_nvim() {
  local file
  file=$(fzf) || return 1
  [ -n "$file" ] && nvim "$file"
}

alias vifz='fzf_open_nvim'

# -- miscellaneous -----------------------------------------------------------
alias c='clear'                            # Clear terminal
alias sn='sudo nautilus'                   # Open Nautilus as root

# -- mpv ---------------------------------------------------------------------
mpv-torrent() { webtorrent "$1" --mpv --playlist; }

# -- system info -------------------------------------------------------------
alias ff='fastfetch'                       # Display system information
alias ffa="fastfetch -c all.jsonc"
alias k='uname -rs'                        # Display kernel name and version
alias age='stat / | grep Birth'            # Display system installation date

# -- clipboard operations ----------------------------------------------------
alias pbcopy='xsel --clipboard --input'    # Copy to clipboard
alias pbpaste='xsel --clipboard --output'  # Paste from clipboard
