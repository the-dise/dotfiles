# -- set environment variables -----------------------------------------------
AUTOSTART_TMUX=true
LC_ALL="en_US.UTF-8"
LANG="en_US.UTF-8"
EDITOR='nvim'
VISUAL='nvim'
DOTFILES="$HOME/.dotfiles"
PATH="$PATH:$HOME/.local/bin"
export LC_ALL LANG EDITOR VISUAL DOTFILES PATH

# Load local environment variables
if [ -f "$HOME/.zsh_local" ]; then
    . "$HOME/.zsh_local"
fi

# -- initialize starship prompt ----------------------------------------------
eval "$(starship init zsh)"

# -- setup zinit -------------------------------------------------------------
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

(( ${+_comps} )) && _comps[zinit]=_zinit
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
ZVM_VI_INSERT_ESCAPE_BINDKEY=jk

# -- load fzf search plugin --------------------------------------------------
zinit ice lucid wait'0'
zinit light joshskidmore/zsh-fzf-history-search

# -- add in snippets ---------------------------------------------------------
zinit snippet OMZP::git
zinit snippet OMZP::command-not-found
zinit snippet OMZP::colorize
zinit snippet OMZP::colored-man-pages
zinit snippet OMZP::sudo
zinit snippet OMZP::docker
zinit snippet OMZP::docker-compose

# -- setup history, styles, aliases and plugins ------------------------------
. $DOTFILES/zsh/history.zsh
. $DOTFILES/zsh/zstyles.zsh
. $DOTFILES/zsh/aliases.zsh
. $DOTFILES/zsh/plugins/fzf/fzf.plugin.zsh
. $DOTFILES/zsh/plugins/tmux/tmux.plugin.zsh
. $DOTFILES/zsh/plugins/dnf/dnf.plugin.zsh

# -- initialize completion ---------------------------------------------------
autoload -Uz compinit && compinit

# -- sysinfo on startup ------------------------------------------------------
fastfetch
