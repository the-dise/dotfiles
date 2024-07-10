# -- exit shell --------------------------------------------------------------
alias :q='exit'

# -- file operations with safety prompts -------------------------------------
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

# -- npm ---------------------------------------------------------------------
alias nukenode="rm -rf package-lock.json && rm -rf node_modules"
alias restnode="rm -rf package-lock.json && rm -rf node_modules && npm install"

alias npmg="npm i -g "                    # Install dependencies globally
alias npmS="npm i -S "                    # Add and save to dependencies in package.json
alias npmD="npm i -D "                    # Install and save to dev-dependencies in your package.json
alias npmE='PATH="$(npm bin)":"$PATH"'    # Execute command from node_modules folder based on current directory
alias npmO="npm outdated"                 # Check which npm modules are outdated
alias npmV="npm -v"                       # Check package versions
alias npmL="npm list"                     # List packages
alias npmst="npm start"                   # Run npm start
alias npmt="npm test"                     # Run npm test

# -- use neovim instead of vim -----------------------------------------------
alias vi='nvim'
alias vim='nvim'

# -- miscellaneous -----------------------------------------------------------
alias c='clear'                            # Clear terminal
alias sn='sudo nautilus'                   # Open Nautilus as root

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

alias def='if command -v tmux &> /dev/null && [ -n "$PS1" ] && \
 [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then \
 tmux attach-session -t default || tmux new-session -s default; fi'

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
