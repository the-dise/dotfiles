# ~/.fzf.zsh

# -- plugin's directory ------------------------------------------------------
local FZF_PLUGINS="${0:h:h:h:h}/fzf"
if [[ ! "$path" == *${FZF_PLUGINS}* ]]; then
  path+=(${FZF_PLUGINS})
fi
unset FZF_PLUGINS

# -- preview command ---------------------------------------------------------
_fzf_preview() {
  foolproofPreview='([[ -f {} ]] && (bat --style=numbers \
    --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) \
    || echo {} 2>/dev/null | head -n 200'

  local preview
  preview="fzf-preview {}" ||
    preview="$foolproofPreview"
  echo "$preview"
}

export FZF_PREVIEW="$(_fzf_preview)"

# -- fzgrep ------------------------------------------------------------------
fzgrep() {
    local editor="$EDITOR"
    local pattern=""
    local preview_cmd="bat --style=numbers --color=always {}"
    
    # Help message
    show_help() {
        echo "Usage: fzgrep [-e editor | --editor editor] <search_pattern>"
        echo ""
        echo "Options:"
        echo "  -e, --editor  Specify the editor to open the files (default: \$EDITOR)"
        echo "  --help        Show this help message"
        return 0
    }

    # Checking the availability of BAT
    if ! command -v bat &> /dev/null; then
        preview_cmd="cat {}"
    fi
    
    # Options
    while [[ "$#" -gt 0 ]]; do
        case "$1" in
            -e|--editor)
                shift
                editor="$1"
                ;;
            --help)
                show_help
                return 0
                ;;
            -*)
                echo "Unknown option: $1"
                show_help
                return 1
                ;;
            *)
                pattern="$1"
                break
                ;;
        esac
        shift
    done
    
    if [ -z "$pattern" ]; then
        echo "Error: search pattern is required"
        show_help
        return 1
    fi
    
    rg --files-with-matches --no-heading --line-number --color=auto "$pattern" | \
    fzf --delimiter ':' --nth 2.. --preview "$preview_cmd" | \
    cut -d':' -f1 | \
    xargs -r "$editor"
}

# -- fzf options -------------------------------------------------------------
fzf_default_opts+=(
  "--layout=reverse"
  "--info=inline-right"
  "--height=80%"
  "--multi"
  "--preview='${FZF_PREVIEW}'"
  # "--preview-window=':hidden'"
  "--color=bg+:#313131,bg:#1e1e1e,spinner:#eeeeee,hl:#f38ba8"
  "--color=fg:#b3b3b3,header:#f38ba8,info:#cba6f7,pointer:#cba6f7"
  "--color=marker:#a6e3a1,fg+:#eeeeee,prompt:#cba6f7,hl+:#f38ba8"
  "--color=bg+:-1,bg:-1,spinner:#f38ba8,hl:#f38ba8"
  "--prompt='∷ '"
  "--pointer='󰁔 '"
  "--marker='󰄬 '"
  "--bind '?:toggle-preview'"
  "--bind 'ctrl-a:select-all'"
  "--bind 'ctrl-e:execute(nvim {+} >/dev/tty)'"
  "--bind 'ctrl-v:execute(code {+})'"
)

export FZF_DEFAULT_OPTS=$(printf '%s\n' "${fzf_default_opts[@]}")

# -- enable fzf fuzzy completion ---------------------------------------------
[[ $- == *i* ]] && source "/usr/share/fzf/shell/completion.zsh" 2>/dev/null
[[ $- == *i* ]] && source "/usr/share/fzf/shell/key-bindings.zsh"
