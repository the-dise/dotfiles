show_proxy() { 
  local index icon color text module
  
  index=$1 

  if nc -z $PROXY_HOST $PROXY_PORT; then
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
