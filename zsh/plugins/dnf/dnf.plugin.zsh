# dnf.plugin.zsh
#
# This file contains aliases for package management using DNF and Flatpak.
# The goal is to simplify common tasks for system updates, cleanup, and
# package management.
#
# Author: @the_dise
#
# -- determine DNF program version -------------------------------------------
local dnfprog="dnf"
command -v dnf5 &>/dev/null && dnfprog=dnf5

# -- system update and cleanup -----------------------------------------------
alias up="sudo ${dnfprog} upgrade --refresh --best --allowerasing -y && \
flatpak update -y"
alias cc="sudo ${dnfprog} autoremove && sudo ${dnfprog} clean all && \
flatpak uninstall --unused -y && flatpak remove --delete-data && \
sudo journalctl --vacuum-time=1weeks"

# -- DNF aliases -------------------------------------------------------------
alias dnfl="${dnfprog} list"                 # List packages
alias dnfli="${dnfprog} list installed"      # List installed packages
alias dnfgl="${dnfprog} grouplist"           # List package groups
alias dnfmc="${dnfprog} makecache"           # Generate metadata cache
alias dnfp="${dnfprog} info"                 # Show package information
alias dnfs="${dnfprog} search"               # Search package

# -- DNF package management --------------------------------------------------
alias dnfu="sudo ${dnfprog} upgrade"         # Upgrade package
alias dnfi="sudo ${dnfprog} install"         # Install package
alias dnfgi="sudo ${dnfprog} groupinstall"   # Install package group
alias dnfr="sudo ${dnfprog} remove"          # Remove package
alias dnfgr="sudo ${dnfprog} groupremove"    # Remove package group
alias dnfc="sudo ${dnfprog} clean all"       # Clean cache
