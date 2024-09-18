
# If this module depends on an external Tmux plugin, say so in a comment.
# E.g.: Requires https://github.com/aaronpowell/tmux-weather

show_proxy() { # This function name must match the module name!
  local index icon color text module
  
  local proxy_host="127.0.0.1"
  local proxy_port="2080"

  index=$1 # This variable is used internally by the module loader in order to know the position of this module

  if nc -z $proxy_host $proxy_port; then
    icon="$(  get_tmux_option "@catppuccin_proxy_icon"  "󰞉" )"
    color="$( get_tmux_option "@catppuccin_proxy_color" "$thm_cyan" )"
    text="$(  get_tmux_option "@catppuccin_proxy_text"  "On" )"
  else
    icon="$(  get_tmux_option "@catppuccin_proxy_icon"  "󰕑" )"
    color="$( get_tmux_option "@catppuccin_proxy_color" "$thm_red" )"
    text="$(  get_tmux_option "@catppuccin_proxy_text" "Off" )"
  fi
  module=$( build_status_module "$index" "$icon" "$color" "$text" )

  echo "$module"
}
