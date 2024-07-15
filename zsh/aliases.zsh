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
alias lsa='eza --all --git --header --long --color=always --icons'
alias l='eza --all --git --header --long --color=always --icons'
alias ll='eza --git --header --color=always --icons'
alias la='eza -all --git --header --long --color=always --icons'

# -- colorize ----------------------------------------------------------------
alias bat="bat --color=always"
alias ncdu="ncdu --color=dark --extended --fast-ui-updates --enable-delete"
alias grep="grep --color=always"

# -- use neovim instead of vim -----------------------------------------------
alias vi='nvim'
alias vim='nvim'

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

# -- tmux session management -------------------------------------------------
tas() { tmux attach-session -t "$1"; }
tns() { tmux new-session -s "$1"; }

# -- default session on tmux -------------------------------------------------
def() {
    if command -v tmux &> /dev/null && [ -n "$PS1" ]; then
        if [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
            tmux attach-session -t default || tmux new-session -s default
        fi
    fi
}

# -- determine DNF program version -------------------------------------------
local dnfprog="dnf"
command -v dnf5 &> /dev/null && dnfprog=dnf5

# -- system update and cleanup -----------------------------------------------
alias up="sudo ${dnfprog} upgrade --refresh --best --allowerasing -y && flatpak update -y"
alias cc="sudo ${dnfprog} autoremove && sudo ${dnfprog} clean all && flatpak uninstall --unused -y && flatpak remove --delete-data && sudo journalctl --vacuum-time=1weeks"

# -- DNF aliases -------------------------------------------------------------
alias dnfl="${dnfprog} list"                # List packages
alias dnfli="${dnfprog} list installed"     # List installed packages
alias dnfgl="${dnfprog} grouplist"          # List package groups
alias dnfmc="${dnfprog} makecache"          # Generate metadata cache
alias dnfp="${dnfprog} info"                # Show package information
alias dnfs="pkgsearch"                      # Search package

# -- DNF package management --------------------------------------------------
alias dnfu="sudo ${dnfprog} upgrade"        # Upgrade package
alias dnfi="sudo ${dnfprog} install"        # Install package
alias dnfgi="sudo ${dnfprog} groupinstall"  # Install package group
alias dnfr="sudo ${dnfprog} remove"         # Remove package
alias dnfgr="sudo ${dnfprog} groupremove"   # Remove package group
alias dnfc="sudo ${dnfprog} clean all"      # Clean cache
