# tmux.plugin.zsh
# 
# Description: A plugin to manage tmux sessions in zsh.
# Author: @the_dise
# Original: https://github.com/glennreyes/oh-my-zsh/tree/master/plugins/tmux

# -- variables ---------------------------------------------------------------
DEFAULT_SESSION="default"

# -- aliases -----------------------------------------------------------------
alias ta='tmux attach -t'
alias tad='tmux attach -d -t'
alias ts='tmux new-session -s'
alias tl='tmux list-sessions'
alias tksv='tmux kill-server'
alias tkss='tmux kill-session -t'

# -- default session on tmux -------------------------------------------------
tmux-default() {
    if command -v tmux &> /dev/null && [ -n "$PS1" ]; then
        if [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
            tmux attach-session -t $DEFAULT_SESSION || tmux new-session -s $DEFAULT_SESSION
        fi
    fi
}

# -- tmux autostart or autoconnect -------------------------------------------
if which tmux &> /dev/null; then
  # auto start tmux
  [[ -n "$AUTOSTART_TMUX" ]] || AUTOSTART_TMUX=false
  # only autostart once
  [[ -n "$AUTOSTART_ONCE" ]] || AUTOSTART_ONCE=true
  # auto connect to a previous session
  [[ -n "$AUTOCONNECT" ]] || AUTOCONNECT=true
  # auto close the terminal when tmux exits
  [[ -n "$AUTOQUIT" ]] || AUTOQUIT=$AUTOSTART_TMUX
  # Set term to screen or screen-256color
  [[ -n "$FIXTERM" ]] || FIXTERM=true
  
  # Get the absolute path to the current directory
  local tmux_plugin_path="$(cd "$(dirname "$0")" && pwd)"

  # Determine if the terminal supports 256 colors
  if [[ $(tput colors) == "256" ]]; then
    export TMUX_TERM="screen-256color"
  else
    export TMUX_TERM="screen"
  fi

  # Set the correct local config file to use
  if [[ -f $HOME/.tmux.conf || -L $HOME/.tmux.conf ]]; then
    export _TMUX_FIXED_CONFIG="$tmux_plugin_path/tmux.extra.conf"
  else
    export _TMUX_FIXED_CONFIG="$tmux_plugin_path/tmux.only.conf"
  fi

  # Wrapper function for tmux
  function _zsh_tmux_plugin_run() {
    # We have other arguments, just run them
    if [[ -n "$@" ]]; then
      \tmux $@
    # Try to connect to an existing session
    elif [[ "$AUTOCONNECT" == "true" ]]; then
      \tmux attach || \
      \tmux $([[ "$FIXTERM" == "true" ]] && \
        echo '-f '$_TMUX_FIXED_CONFIG) new-session -s $DEFAULT_SESSION
      [[ "$AUTOQUIT" == "true" ]] && exit
    # Just run tmux, fixing the TERM variable if requested
    else
      \tmux $([[ "$FIXTERM" == "true" ]] && \
        echo '-f '$_TMUX_FIXED_CONFIG)
      [[ "$AUTOQUIT" == "true" ]] && exit
    fi
  }

  # Alias tmux to our wrapper function
  alias tmux=_zsh_tmux_plugin_run

  # Autostart if not already in tmux and enabled
  if [[ ! -n "$TMUX" && "$AUTOSTART_TMUX" == "true" ]]; then
    # Don't autostart if already did and multiple autostarts are disabled
    if [[ "$AUTOSTART_ONCE" == "false" || "$AUTOSTARTED" != "true" ]]; then
      export AUTOSTARTED=true
      _zsh_tmux_plugin_run
    fi
  fi
else
  print "zsh tmux plugin: tmux not found"
fi
