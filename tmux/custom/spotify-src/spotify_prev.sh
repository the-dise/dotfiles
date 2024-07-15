#!/bin/bash
GREEN_PREFIX="#[fg=green]"
WHITE_ON_GREEN="#[fg=#313131,bg=green]"
GREEN_SUFFIX="#[default]"

/usr/local/bin/spotifycli --prev 
status=$(/usr/local/bin/spotifycli --statusposition)
tmux display-message -t 5000 "${GREEN_PREFIX}${WHITE_ON_GREEN}󰓇 Spotify${GREEN_SUFFIX}${GREEN_PREFIX}${GREEN_SUFFIX} #[bold]󰒮 Previous track:#[default] $status"
