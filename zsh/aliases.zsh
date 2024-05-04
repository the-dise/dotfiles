# vim: ft=zsh
alias :q="exit"

# General
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias vi='nvim'

# Clipboard
alias copy='xsel --clipboard --input'
alias paste='xsel --clipboard --output'

# yt-dlp
alias yt='yt-dlp --add-metadata -ic' # Download video
alias yta='yt-dlp --add-metadata -xic' # Download audio

# tmux sessions
tas() {
    tmux attach-session -t "$1"
}
tns() {
    tmux new-session -s "$1"
}

# Package management
alias up="sudo dnf upgrade --refresh --best --allowerasing -y && flatpak update -y"
alias cc="sudo dnf autoremove && dnf clean all && flatpak uninstall --unused -y && flatpak remove --delete-data && sudo journalctl --vacuum-time=1weeks"

# tarball
alias tarball="tar -C ~/Applications -xvf"

# Etcx
alias c="clear"
alias sn="sudo nautilus"

# Neofetch
alias n="neofetch"    
alias k="uname -rs"
alias age="stat / | grep Birth"

# Quick go to USB devices
_usb() {
    local user
    user=$(whoami)
    local devices
    devices=$(ls /run/media/$user/)
    COMPREPLY=($(compgen -W "$devices" -- "${COMP_WORDS[COMP_CWORD]}"))
}
complete -F _usb usb

usb() {
    local user
    user=$(whoami)
    cd "/run/media/$user/$1" || return 1
}