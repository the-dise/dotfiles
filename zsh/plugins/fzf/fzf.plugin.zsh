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
