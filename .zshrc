# Connecting Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"
plugins=(git zsh-syntax-highlighting)

# Options
setopt 'auto_cd'               # Navigating to a directory if the name is entered without the cd command
setopt 'extended_glob'         # Enhanced file search capabilities
setopt 'hist_ignore_dups'      # Ignore repetitive commands in the history
setopt 'hist_ignore_space'     # Ignore commands that start with a space
setopt 'hist_verify'           # Show the command to be executed from the history before executing
setopt 'interactive_comments'  # Allow comments in interactive mode
setopt 'noclobber'             # Protect against accidentally overwriting files
setopt 'share_history'         # Use one story for all sessions
setopt 'notify'                # Notification of the end of long tasks

# Alias
alias ls='ls -F --color=auto'
alias ll='ls -lh'
alias lla='ls -lah'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias cls='clear'

# Exporting environment variables
export EDITOR='vim'
export HISTSIZE=10000
export HISTFILESIZE=20000
export PATH=$PATH:/usr/local/bin

source $ZSH/oh-my-zsh.sh
export LANG=en_US.UTF-8

# Alias Oh My Zsh
alias zshconf="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"

# Characters
ARR=""
ERR=""

# Colors
XB="33" # BLUE
XG="40" # GREEN
XR="160" # RED
XY="178" #YELLOW
XC="50" # CYAN
XP="93" # PUPRLE

# The appearance of the command line
PROMPT="%F{$XB }[%f%n%F{$XB }@%f%m%F{$XB }]%f %(?:%{%F{$XG }%}$ARR :%{%F{$XR }%}$ERR )"
RPROMPT="%F{$XB }[%f%*%F{$XB }]%f"
PROMPT+='%{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[white]%}/ %{%F{$XP}%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[white]%} %{%F{$XY}%}$ERR"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[white]%}"

# Autoload
autoload -Uz compinit && compinit