# -- exit shell --------------------------------------------------------------
alias :q='exit'

# -- file operations with safety prompts -------------------------------------
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -ri'
alias -- -='cd -'
alias md='mkdir -p'
alias rd='rmdir'

# -- list directory contents -------------------------------------------------
alias lsa='ls -lah'
alias l='ls -lah'
alias ll='ls -lh'
alias la='ls -lAh'

# -- use neovim instead of vim -----------------------------------------------
alias vi='nvim'
alias vim='nvim'

# -- miscellaneous -----------------------------------------------------------
alias c='clear'                            # Clear terminal
alias sn='sudo nautilus'                   # Open Nautilus as root

# -- system info -------------------------------------------------------------
alias n='neofetch'                         # Display system information
alias k='uname -rs'                        # Display kernel name and version
alias age='stat / | grep Birth'            # Display system installation date

# -- clipboard operations ----------------------------------------------------
alias clipcopy='xsel --clipboard --input'  # Copy to clipboard

# -- tmux session management -------------------------------------------------
tas() { tmux attach-session -t "$1"; }
tns() { tmux new-session -s "$1"; }

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
alias dnfs="${dnfprog} search"              # Search package

# -- DNF package management --------------------------------------------------
alias dnfu="sudo ${dnfprog} upgrade"        # Upgrade package
alias dnfi="sudo ${dnfprog} install"        # Install package
alias dnfgi="sudo ${dnfprog} groupinstall"  # Install package group
alias dnfr="sudo ${dnfprog} remove"         # Remove package
alias dnfgr="sudo ${dnfprog} groupremove"   # Remove package group
alias dnfc="sudo ${dnfprog} clean all"      # Clean cache
