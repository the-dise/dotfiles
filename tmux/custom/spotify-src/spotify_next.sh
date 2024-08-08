#!/bin/bash
GREEN_PREFIX="#[fg=green]"
WHITE_ON_GREEN="#[fg=#313131,bg=green]"
GREEN_SUFFIX="#[default]"

/usr/local/bin/spotifycli --next 
status=$(/usr/local/bin/spotifycli --statusposition)
tmux display-message -d 2000 "${GREEN_PREFIX}${WHITE_ON_GREEN}#[bold]󰓇 Spotify#[default]${GREEN_SUFFIX}${GREEN_PREFIX}${GREEN_SUFFIX} #[bold]󰒭 Next track:#[default] $status"

