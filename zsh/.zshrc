# -- set environment variables -----------------------------------------------
export AUTOSTART_TMUX=true
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"
export EDITOR='nvim'
export VISUAL='nvim'
export DOTFILES="$HOME/.dotfiles"
export ANDROID_HOME="$HOME/Android"

# Correctly set GOPATH and add it to PATH
export GOPATH="/usr/local/go/bin:$PATH"

# Ensure ANDROID_NDK_HOME is correctly defined if used
export ANDROID_NDK_HOME="$HOME/Android/ndk/27.1.12297006/"

# Update PATH
export PATH="$PATH:$HOME/.local/bin:$GOPATH/bin:$ANDROID_NDK_HOME"

# Load local environment variables
if [ -f "$DOTFILES/zsh/.zsh_local" ]; then
    source "$DOTFILES/zsh/.zsh_local"
fi

# -- initialize starship prompt ----------------------------------------------
eval "$(starship init zsh)"

# -- setup zinit -------------------------------------------------------------
export ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname "$ZINIT_HOME")"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# Ensure _comps is defined before using
if (( ${+_comps} )); then
    _comps[zinit]=_zinit
fi
autoload -Uz _zinit

# -- load plugins ------------------------------------------------------------
zinit load zsh-users/zsh-syntax-highlighting
zinit load zsh-users/zsh-completions
zinit load zsh-users/zsh-autosuggestions
zinit load Aloxaf/fzf-tab
zinit load Freed-Wu/fzf-tab-source

# -- load vi mode ------------------------------------------------------------
zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode
export ZVM_VI_INSERT_ESCAPE_BINDKEY=jk

# -- load fzf search plugin --------------------------------------------------
zinit ice lucid wait'0'
zinit light joshskidmore/zsh-fzf-history-search

# -- add in snippets ---------------------------------------------------------
zinit snippet OMZP::git
zinit snippet OMZP::command-not-found
zinit snippet OMZP::colorize
zinit snippet OMZP::colored-man-pages
zinit snippet OMZP::sudo
zinit snippet OMZP::z
zinit snippet OMZP::docker
zinit snippet OMZP::docker-compose

# -- setup history, styles, aliases, and plugins ------------------------------
source "$DOTFILES/zsh/history.zsh"
source "$DOTFILES/zsh/zstyles.zsh"
source "$DOTFILES/zsh/aliases.zsh"
source "$DOTFILES/zsh/plugins/fzf/fzf.plugin.zsh"
source "$DOTFILES/zsh/plugins/tmux/tmux.plugin.zsh"
source "$DOTFILES/zsh/plugins/dnf/dnf.plugin.zsh"

# -- initialize completion ---------------------------------------------------
autoload -Uz compinit && compinit

# -- sysinfo on startup ------------------------------------------------------
fastfetch
