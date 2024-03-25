# vim:ft=zsh ts=2 sw=2 sts=2
#
# DBox's Theme
#
# This is a fork of the popular Agnoster's Theme, a zsh shell theme designed to show relevant information quickly, 
# with lean status segments and a powerline-style visual look. 
#
# The original Agnoster's Theme was created by [agnoster](https://github.com/agnoster/agnoster-zsh-theme), 
# and this fork includes some minor tweaks and customizations that I have added.


typeset -aHg DBOX_PROMPT_SEGMENTS=(
	prompt_context
  prompt_virtualenv
  prompt_dir
  prompt_git
  prompt_status_root
  prompt_end
)

### Segment drawing
# A few utility functions to make it easy and re-usable to draw segmented prompts

CURRENT_BG='NONE'
if [[ -z "$PRIMARY_FG" ]]; then
	PRIMARY_FG=237 
fi

# Characters
LDIV="\ue0b0" # 
RDIV="\ue0b2" # 

ROOT="\uf0ad" # 
GEAR="\uf013" # 
ERRO="\uf00d" # 

BRAN="\ue0a0" # 
DETA="\u27a6" # ➦
EDIT="\uf044" # 
IDEN="\u2262" 


# Dist icons
if [[ $(uname) == Linux && $(uname -o) == Android ]]; then
    ICON="\uf17b"
else
    os='Linux'
    local os_release_id
    if [[ -r /etc/os-release ]]; then
        local lines=(${(f)"$(</etc/os-release)"})
        lines=(${(@M)lines:#ID=*})
        (( $#lines == 1 )) && os_release_id=${lines[1]#ID=}
    elif [[ -e /etc/artix-release ]]; then
        os_release_id=artix
    fi
    case $os_release_id in
        *arch*) ICON="\uf303" ;;
        *debian*) ICON="\uebc5" ;;
        *raspbian*) ICON="\uf315" ;;
        *ubuntu*) ICON="\uebc9" ;;
        *elementaryos*) ICON="\uf309" ;;
        *fedora*) ICON="\uf30a" ;;
        *coreos*) ICON="\uf305" ;;
        *kali*) ICON="\uf327" ;;
        *gentoo*) ICON="\udb82\udce8" ;;
        *mageia*) ICON="\uf310" ;;
        *centos*) ICON="\uf304" ;;
        *opensuse*) ICON="\uf314" ;;
        *sabayon*) ICON="\uf317" ;;
        *slackware*) ICON="\uf318" ;;
        *linuxmint*) ICON="\udb82\udced" ;;
        *alpine*) ICON="\uf300" ;;
        *aosc*) ICON="\uf301" ;;
        *nixos*) ICON="\uf313" ;;
        *devuan*) ICON="\uf307" ;;
        *manjaro*) ICON="\uf312" ;;
        *void*) ICON="\uf32e" ;;
        *artix*) ICON="\uf31f" ;;
        *) ICON="\ue712" ;;
    esac
fi

# Begin a segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    print -n "%{$bg%F{$CURRENT_BG}%}$LDIV%{$fg%}"
  else
    print -n "%{$bg%}%{$fg%}"
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && print -n $3
}

# End the prompt, closing any open segments
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    print -n "%{%k%F{$CURRENT_BG}%}$LDIV"
  else
    print -n "%{%k%}"
  fi
  print -n "%{%f%}"
  CURRENT_BG=''
}

### Prompt components
# Each component will draw itself, and hide itself if no information needs to be shown
# Context: user@hostname (who am I and where am I)

prompt_context() {
  # local user=`whoami`
  # if [[ "$user" != "$DEFAULT_USER" || -n "$SSH_CONNECTION" ]]; then
    prompt_segment $PRIMARY_FG default " ${ICON} " # %(!.%{%F{yellow}%}.)$user@%m "
  # fi
}


# Git: branch/detached head, dirty status
prompt_git() {
  local color ref
  is_dirty() {
    test -n "$(git status --porcelain --ignore-submodules)"
  }
  ref="$vcs_info_msg_0_"
  if [[ -n "$ref" ]]; then
    if is_dirty; then
      color=209
      ref="${ref} $EDIT "
    else
      color=107 
      ref="${ref} $IDEN "
    fi
    if [[ "${ref/.../}" == "$ref" ]]; then
      ref="$BRAN $ref"
    else
      ref="$DETA ${ref/.../}"
    fi
    prompt_segment $color $PRIMARY_FG
    print -n " $ref"
  fi
}

# Dir: current working directory
prompt_dir() {
  prompt_segment 73 $PRIMARY_FG ' %~ '
}

# Status:
# - am I root
# - was there an error
##   [[ $RETVAL -ne 0 ]] && symbols+="%F{0}$ERRO%f"
##   [[ -n "$symbols" ]] && prompt_segment 202 default " $symbols "
# - are there background jobs?
##   [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%F{0}$GEAR%f"
##   [[ -n "$symbols" ]] && prompt_segment 148 default " $symbols "
prompt_status_root() {
  local symbols=()
  [[ $UID -eq 0 ]] && symbols+="%F{0}$ROOT%f"
  [[ -n "$symbols" ]] && prompt_segment 227 default " $symbols "
}

# Display current virtual environment
prompt_virtualenv() {
  if [[ -n $VIRTUAL_ENV ]]; then
    color=cyan
    prompt_segment $color $PRIMARY_FG
    print -Pn " $(basename $VIRTUAL_ENV) "
  fi
}

## Main prompt
prompt_dbox_main() {
  RETVAL=$?
  CURRENT_BG='NONE'
  for prompt_segment in "${DBOX_PROMPT_SEGMENTS[@]}"; do
    [[ -n $prompt_segment ]] && $prompt_segment
  done
}

prompt_dbox_precmd() {
  vcs_info
  PROMPT='%{%f%b%k%}$(prompt_dbox_main) '
  # RPROMPT="%T"
}

prompt_dbox_setup() {
  autoload -Uz add-zsh-hook
  autoload -Uz vcs_info

  prompt_opts=(cr subst percent)

  add-zsh-hook precmd prompt_dbox_precmd

  zstyle ':vcs_info:*' enable git
  zstyle ':vcs_info:*' check-for-changes false
  zstyle ':vcs_info:git*' formats '%b'
  zstyle ':vcs_info:git*' actionformats '%b (%a)'
}

prompt_dbox_setup "$@"
