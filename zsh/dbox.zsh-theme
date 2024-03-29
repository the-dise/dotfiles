# vim:ft=zsh ts=2 sw=2 sts=2
#
# DBox's Theme
#
# This is a fork of the popular Agnoster's Theme, a zsh shell theme designed to show relevant information quickly,
# with lean status segments and a powerline-style visual look.
#
# The original Agnoster's Theme was created by [agnoster](https://github.com/agnoster/agnoster-zsh-theme),
# and this fork includes some minor tweaks and customizations that I have added.

CURRENT_BG='NONE'
if [[ -z "$PRIMARY_FG" ]]; then
	PRIMARY_FG='303030' 
fi

LDIV="\ue0b0" # 
RDIV="\ue0b2" # 
ROOT="\uf0ad" # 
GEAR="\uf013" # 
ERRO="\uf00d" # 
BRAN="\ue0a0" # 
DETA="\u27a6" # ➦
EDIT="\uf044" # 
IDEN="\u2262" # ≡

# GNU/Linux distribution icons
if [[ $(uname) == Linux && $(uname -o) == Android ]]; then
    ICON="\uf17b"
else
    os='Linux'
    local os_release_id
    if [[ -r /etc/os-release ]]; then
        local lines=(${(f)"$(</etc/os-release)"})
        lines=(${(@M)lines:#ID=*})
        (( $#lines == 1 )) && os_release_id=${lines[1]#ID=}
    fi
    case $os_release_id in
        *arch*) ICON="\uf303" ;;          # 
        *debian*) ICON="\uebc5" ;;        # 
        *raspbian*) ICON="\uf315" ;;      # 
        *ubuntu*) ICON="\uebc9" ;;        # 
        *fedora*) ICON="\uf30a" ;;        # 
        *kali*) ICON="\uf327" ;;          # 
        *gentoo*) ICON="\udb82\udce8" ;;  # 󰣨
        *opensuse*) ICON="\uf314" ;;      # 
        *manjaro*) ICON="\uf312" ;;       # 
        *) ICON="\ue712" ;;               # 
    esac
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
    prompt_segment $PRIMARY_FG default " ${ICON} " # %(!.%{%F{yellow}%}.)$user@%m "
  # fi
}

prompt_dir() {
  prompt_segment '5fafaf' $PRIMARY_FG ' %~ '
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
  [[ -n "$symbols" ]] && prompt_segment 'ffff5f' default " $symbols "
}

prompt_git() {
  local color ref
  is_dirty() {
    test -n "$(git status --porcelain --ignore-submodules)"
  }
  ref="$vcs_info_msg_0_"
  if [[ -n "$ref" ]]; then
    if is_dirty; then
      color='ff875f'
      ref="${ref} $EDIT "
    else
      color='87af5f'
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

prompt_python() {
  if [ -f setup.py ] || [ -f pyproject.toml ] || [ -f main.py ] || [ -d venv ]; then
    local python_info
    if command -v python &>/dev/null; then
      python_info=$(python --version 2>&1 | cut -d " " -f 2)
      if [ -n "$python_info" ]; then
        prompt_segment 'ffde57' $PRIMARY_FG " \ue606 $python_info "
      fi
    fi
  fi
}

prompt_virtualenv() {
  if [[ -n $VIRTUAL_ENV ]]; then
    color='00ffff'
    prompt_segment $color $PRIMARY_FG
    print -Pn " $(basename $VIRTUAL_ENV) "
  fi
}

prompt_setup "$@"
