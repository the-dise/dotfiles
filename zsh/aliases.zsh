# vim: ft=zsh

# Exit shell
alias :q="exit"

# General file operations
alias cp='cp -i'
alias mv='mv -i'
alias vi='nvim'

# Clipboard operations
alias copy='xsel --clipboard --input'
alias paste='xsel --clipboard --output'

# yt-dlp commands
alias yt='yt-dlp --add-metadata -ic' # Download video
alias yta='yt-dlp --add-metadata -xic' # Download audio

# Tmux sessions
tas() {
    tmux attach-session -t "$1"
}
_complete_sessions() {
    local sessions
    sessions=$(tmux list-sessions -F "#S" 2>/dev/null)
    COMPREPLY=($(compgen -W "$sessions" -- "${COMP_WORDS[COMP_CWORD]}"))
}
complete -F _complete_sessions tas

tns() {
    tmux new-session -s "$1"
}

# Package management
alias up="sudo dnf upgrade --refresh --best --allowerasing -y && flatpak update -y"
alias cc="sudo dnf autoremove && sudo dnf clean all && flatpak uninstall --unused -y && flatpak remove --delete-data && sudo journalctl --vacuum-time=1weeks"

# Tarball extraction
alias tarball="tar -C ~/Applications -xvf"

# Miscellaneous
alias c="clear"
alias sn="sudo nautilus"

# System info
alias n="neofetch"
alias k="uname -rs"
alias age="stat / | grep Birth"

# Quick go to USB devices
_usb() {
    local devices
    devices=$(ls /run/media/$(whoami)/)
    COMPREPLY=($(compgen -W "$devices" -- "${COMP_WORDS[COMP_CWORD]}"))
}
complete -F _usb usb

usb() {
    cd "/run/media/$(whoami)/$1" || return 1
}

# Fzf with ripgrep
alias fzf-rg='
    fzf-rg-helper() {
        rg --files-with-matches --no-heading --line-number --color=always "$1" | fzf --ansi --preview="rg --color=always -n $1 {1}" --bind "enter:execute(rg --color=always -n $1 {1})"; 
    }; fzf-rg-helper'
