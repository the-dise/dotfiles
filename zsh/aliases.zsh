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

fzf-nvim() {
  local file
  file=$(fzf) || return 1
  [ -n "$file" ] && nvim "$file"
}

alias vifz='fzf_open_nvim'

# -- miscellaneous -----------------------------------------------------------
alias c='clear'
alias sn='sudo nautilus'

# -- mpv ---------------------------------------------------------------------
mpv-torrent() {
  command -v webtorrent &>/dev/null && webtorrent "$1" --mpv --playlist ||
    echo "webtorrent not installed"
}

# -- system info -------------------------------------------------------------
alias ff='fastfetch'
alias ffa="fastfetch -c all.jsonc"
alias k='uname -rs'
alias age='stat / | grep Birth'

# -- clipboard operations ----------------------------------------------------
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'

# -- adb ---------------------------------------------------------------------
alias adb-restart='adb kill-server && adb start-server'
alias adb-dev='adb devices -l'
alias adb-logcat='adb logcat -s AndroidRuntime -s System.err -s main -v time'
