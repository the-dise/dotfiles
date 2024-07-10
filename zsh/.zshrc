# -- set environment variables -----------------------------------------------
LC_ALL="en_US.UTF-8"
LANG="en_US.UTF-8"
EDITOR='nvim'
VISUAL='nvim'
DOTFILES="$HOME/.dotfiles"
PATH="$PATH:$HOME/.local/bin"
export LC_ALL LANG EDITOR VISUAL DOTFILES PATH

# -- initialize starship prompt ----------------------------------------------
eval "$(starship init zsh)"

# -- init brew ---------------------------------------------------------------  
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

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

# -- add in snippets ---------------------------------------------------------
zinit snippet OMZP::git
zinit snippet OMZP::command-not-found
zinit snippet OMZP::colorize
zinit snippet OMZP::colored-man-pages
zinit snippet OMZP::brew

# -- binds ------------------------------------------------------------------
bindkey -e                              # Enable zsh keybindings

bindkey '^[[1;5D' backward-word         # Ctrl + Arrow Left to move backward
bindkey '^[[1;5C' forward-word          # Ctrl + Arrow Right to move forward

bindkey '^[^?' backward-kill-word       # Alt + Backspace to delete the word 

# -- setup history, zsh styles, and aliases ----------------------------------
. $DOTFILES/zsh/history.zsh
. $DOTFILES/zsh/zstyles.zsh
. $DOTFILES/zsh/aliases.zsh
. $DOTFILES/zsh/fzf.zsh

# -- initialize completion ---------------------------------------------------
autoload -Uz compinit
compinit
fastfetch
