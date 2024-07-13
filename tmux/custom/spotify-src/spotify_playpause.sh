#!/bin/bash
GREEN_PREFIX="#[fg=green]"
WHITE_ON_GREEN="#[fg=#313131,bg=green]"
GREEN_SUFFIX="#[default]"

/usr/local/bin/spotifycli --playpause
playback=$(/usr/local/bin/spotifycli --playbackstatus)
status=$(/usr/local/bin/spotifycli --statusposition)

case "$playback" in
    "󰐊") playback="󰐊 Play:" ;;
    "󰏤") playback="󰏤 Paused:" ;;
    "󰓛") playback="󰓛 Stopped:" ;;
    *) playback="Unknown" ;;
esac

tmux display-message -t 5000 "${GREEN_PREFIX}${WHITE_ON_GREEN}󰓇 Spotify${GREEN_SUFFIX}${GREEN_PREFIX}${GREEN_SUFFIX} #[bold]$playback#[default] $status"

