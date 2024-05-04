# vim:ft=zsh ts=2 sw=2 sts=2
#
# DBox's Theme
#
# This is a fork of the popular Agnoster's Theme, a zsh shell theme designed to show relevant information quickly,
# with lean status segments and a powerline-style visual look.
#
# The original Agnoster's Theme was created by [agnoster](https://github.com/agnoster/agnoster-zsh-theme),
# and this fork includes some minor tweaks and customizations that I have added.

# https://gnome.pages.gitlab.gnome.org/libadwaita/doc/main/named-colors.html
BLUE_2='51a1ff' 		#51a1ff
BLUE_4='1e78e4'   	#1e78e4
GREEN_2='57E389' 		#57E389
GREEN_4='2EC27E' 		#2EC27E
YELLOW_2='F8E45C' 	#F8E45C
YELLOW_4='F5C211' 	#F5C211
ORANGE_2='FFA348' 	#FFA348
ORANGE_4='E66100' 	#E66100
RED_2='ED333B' 	  	#ED333B
RED_4='C01C28' 	  	#C01C28
PURPLE_2='C061CB' 	#C061CB
PURPLE_4='813D9C' 	#813D9C
BROWN_2='B5835A' 		#B5835A
BROWN_4='865E3C' 		#865E3C
LIGHT_2='F6F5F4' 		#F6F5F4
LIGHT_4='C0BFBC' 		#C0BFBC
DARK_2='5E5C64' 		#5E5C64
DARK_4='241F31' 		#303030

CURRENT_BG='NONE'
if [[ -z "$DARK_4" ]]; then
	DARK_4
fi


LDIV="\ue0b0" #  \ue0b0" # 
RDIV="\ue0b2" #  \ue0b2" # 
ROOT="\uf0ad" # 
GEAR="\uf013" # 
ERRO="\uf00d" # 
BRAN="\ue0a0" # 
DETA="\u27a6" # ➦
EDIT="\uf044" # 
IDEN="\u2262" # ≡

# GNU/Linux distribution icons
if [[ $(uname) == Linux && $(uname -o) == Android ]]; then
    ICON="\uf17b" # 
else
    if [[ -r /etc/os-release ]]; then
        os_release_id=$(awk -F= '/^ID=/{print $2}' /etc/os-release)
        case $os_release_id in
            arch) ICON="\uf303" ;;          # 
            debian) ICON="\uebc5" ;;        # 
            raspbian) ICON="\uf315" ;;      # 
            ubuntu) ICON="\uebc9" ;;        # 
            fedora) ICON="\uf30a" ;;        # 
            kali) ICON="\uf327" ;;          # 
            gentoo) ICON="\udb82\udce8" ;;  # 󰣨
            opensuse) ICON="\uf314" ;;      # 
            manjaro) ICON="\uf312" ;;       # 
            *) ICON="\ue712" ;;             # 
        esac
    else
        ICON="\ue712" # Default icon for Linux
    fi
fi

typeset -aHg PROMPT_SEGMENTS=(
	prompt_context
  prompt_virtualenv
  prompt_dir
  prompt_git
  prompt_root
  prompt_python
  prompt_end
)

prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{#$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{#$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    print -n "%{$bg%F{$CURRENT_BG}%}$LDIV%{$fg%}"
  else
    print -n "%{$bg%}%{$fg%}"
  fi
  CURRENT_BG=#$1
  [[ -n $3 ]] && print -n $3
}

prompt_context() {
  # local user=`whoami`
  # if [[ "$user" != "$DEFAULT_USER" || -n "$SSH_CONNECTION" ]]; then
    prompt_segment '3a3a3a' default " ${ICON} " # %(!.%{%F{yellow}%}.)$user@%m "
  # fi
}

prompt_dir() {
  prompt_segment $BLUE_2 $DARK_4 ' %~ '
}

prompt_main() {
  RETVAL=$?
  CURRENT_BG='NONE'
  for prompt_segment in "${PROMPT_SEGMENTS[@]}"; do
    [[ -n $prompt_segment ]] && $prompt_segment
  done
}

prompt_precmd() {
  vcs_info
  PROMPT='%{%f%b%k%}$(prompt_main) '
  # RPROMPT="%T" # Show time of command
}

prompt_setup() {
  autoload -Uz add-zsh-hook
  autoload -Uz vcs_info

  prompt_opts=(cr subst percent)

  add-zsh-hook precmd prompt_precmd

  zstyle ':vcs_info:*' enable git
  zstyle ':vcs_info:*' check-for-changes false
  zstyle ':vcs_info:git*' formats '%b'
  zstyle ':vcs_info:git*' actionformats '%b (%a)'
}

prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    print -n "%{%k%F{$CURRENT_BG}%}$LDIV"
  else
    print -n "%{%k%}"
  fi
  print -n "%{%f%}"
  CURRENT_BG=''
}

prompt_root() {
  local symbols=()
  [[ $UID -eq 0 ]] && symbols+="%F{0}$ROOT%f"
  [[ -n "$symbols" ]] && prompt_segment $RED_2 default " $symbols "
}

prompt_git() {
  local color ref
  is_dirty() {
    test -n "$(git status --porcelain --ignore-submodules)"
  }
  ref="$vcs_info_msg_0_"
  if [[ -n "$ref" ]]; then
    if is_dirty; then
      color=$ORANGE_2
      ref="${ref} $EDIT "
    else
      color=$GREEN_4
      ref="${ref} $IDEN "
    fi
    if [[ "${ref/.../}" == "$ref" ]]; then
      ref="$BRAN $ref"
    else
      ref="$DETA ${ref/.../}"
    fi
    prompt_segment $color $DARK_4
    print -n " $ref"
  fi
}

prompt_python() {
  if [ -f setup.py ] || [ -f pyproject.toml ] || [ -f main.py ] || [ -d venv ]; then
    local python_info
    if command -v python &>/dev/null; then
      python_info=$(python --version 2>&1 | cut -d " " -f 2)
      if [ -n "$python_info" ]; then
        prompt_segment $YELLOW_2 $DARK_4 " \ue606 $python_info "
      fi
    fi
  fi
}

prompt_virtualenv() {
  if [[ -n $VIRTUAL_ENV ]]; then
    color='00ffff'
    prompt_segment $color $DARK_44
    print -Pn " $(basename $VIRTUAL_ENV) "
  fi
}

prompt_setup "$@"
