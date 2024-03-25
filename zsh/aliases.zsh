# vim: ft=zsh

# Oh My Zsh
alias zshrc="vim ~/.zshrc && exec zsh"
alias ohmyzsh="vim ~/.oh-my-zsh"

# Colorify
alias l='exa'
alias ls='exa -l'
alias lsa='exa -la'
alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn} --exclude-dir={.bundle,node_modules}'

# General
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

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

# System info
alias n="neofetch"
alias k="uname -rs"
alias g="gnome-shell --version"
alias age="stat / | grep Birth"

# Package management
alias fli="flatpak install --noninteractive -y flathub"
alias flr="flatpak remove --noninteractive -y"
alias fr="flatpak repair"
alias fl="flatpak list"
alias up="sudo dnf upgrade --refresh --best --allowerasing -y && flatpak update -y"
alias cc="sudo dnf autoremove && dnf clean all && flatpak uninstall --unused -y && flatpak remove --delete-data && sudo journalctl --vacuum-time=1weeks"


# Etc
alias ..="cd .."
alias c="clear"
alias sn="sudo nautilus"
alias help="tldr"
