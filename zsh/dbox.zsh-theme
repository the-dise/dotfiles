typeset -aHg DBOX_PROMPT_SEGMENTS=(
  prompt_status
	prompt_context
  prompt_virtualenv
  prompt_dir
  prompt_git
  prompt_end
)

### Segment drawing
# A few utility functions to make it easy and re-usable to draw segmented prompts

CURRENT_BG='NONE'
if [[ -z "$PRIMARY_FG" ]]; then
	PRIMARY_FG=237 
fi

# Characters
SEPARATOR="\ue0b0" # 

LIGHTNING="\u26a1" # ⚡
GEAR="\u2699" # ⚙

BRANCH="\ue0a0" # 
DETACHED="\u27a6" # ➦
EDIT="\uf044" # 

IDENTICAL="\u2262" 

CHECK="\uf046" # 
SAVE="\uf692" # 

# Dist icons
case $(uname) in
  Linux)
  	local os_release_id
        if [[ -r /etc/os-release ]]; then
          local lines=(${(f)"$(</etc/os-release)"})
          lines=(${(@M)lines:#ID=*})
          (( $#lines == 1 )) && os_release_id=${lines[1]#ID=}
        elif [[ -e /etc/artix-release ]]; then
          os_release_id=artix
        fi
    case $os_release_id in
      *Arch*) ICON="\uf303" ;;
      *Debian*) ICON="\uebc5" ;;
      *Raspbian*) ICON="\uf315" ;;
      *Ubuntu*) ICON="\uebc9" ;;
      *ElementaryOS*) ICON="\uf309" ;;
      *Fedora*) ICON="\uf30a" ;;
      *CoreOS*) ICON="\uf305" ;;
      *Kali*) ICON="\uf327" ;;
      *Gentoo*) ICON="\udb82\udce8" ;;
      *Mageia*) ICON="\uf310" ;;
      *CentOS*) ICON="\uf304" ;;
      *openSUSE*) ICON="\uf314" ;;
      *Sabayon*) ICON="\uf317" ;;
      *Slackware*) ICON="\uf318" ;;
      *LinuxMint*) ICON="\udb82\udced" ;;
      *Alpine*) ICON="\uf300" ;;
      *AOSC*) ICON="\uf301" ;;
      *NixOS*) ICON="\uf313" ;;
      *Devuan*) ICON="\uf307" ;;
      *Manjaro*) ICON="\uf312" ;;
      *Void*) ICON="\uf32e" ;;
      *Artix*) ICON="\uf31f" ;;
      *) ICON="\ue712" ;;
    esac
    ;;
  Darwin) ICON="\uf302" ;;
  *) ICON="\ue712" ;;
esac


# Begin a segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    print -n "%{$bg%F{$CURRENT_BG}%}$SEPARATOR%{$fg%}"
  else
    print -n "%{$bg%}%{$fg%}"
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && print -n $3
}

# End the prompt, closing any open segments
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    print -n "%{%k%F{$CURRENT_BG}%}$SEPARATOR"
  else
    print -n "%{%k%}"
  fi
  print -n "%{%f%}"
  CURRENT_BG=''
}

### Prompt components
# Each component will draw itself, and hide itself if no information needs to be shown

# Context: user@hostname (who am I and where am I)
# prompt_context() {
#   local user=`whoami`

#   if [[ "$user" != "$DEFAULT_USER" || -n "$SSH_CONNECTION" ]]; then
#     prompt_segment $PRIMARY_FG default "  " # %(!.%{%F{yellow}%}.)$user@%m
#   fi
# }

prompt_context() {
  local user=`whoami`

  if [[ "$user" != "$DEFAULT_USER" || -n "$SSH_CONNECTION" ]]; then
    prompt_segment $PRIMARY_FG default " ${ICON} "
  fi
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
      color=209	#ff875f
      ref="${ref} $EDIT "
    else
      color=100 
      ref="${ref} $IDENTICAL "
    fi
    if [[ "${ref/.../}" == "$ref" ]]; then
      ref="$BRANCH $ref"
    else
      ref="$DETACHED ${ref/.../}"
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
# - was there an error
# - am I root
# - are there background jobs?
prompt_status() {
  local symbols
  symbols=()
  # [[ $RETVAL -ne 0 ]] && symbols+="%B%F{124}%f%b"
  [[ $UID -eq 0 ]] && symbols+="%B%F{221}%f%b"
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%B%F{221}%f%b"

  [[ -n "$symbols" ]] && prompt_segment $PRIMARY_FG default " $symbols "
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
