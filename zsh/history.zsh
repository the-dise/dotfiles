# -- history settings --------------------------------------------------------
SAVEHIST=1000                  # Number of history entries to save
HISTSIZE=5000                  # Maximum number of lines of history to save in memory
HISTFILE=~/.zhistory           # Location of the history file

# -- extended history options ------------------------------------------------
setopt extended_history        # Record timestamp of command in HISTFILE
setopt hist_expire_dups_first  # Delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups        # Ignore duplicated commands in history list
setopt hist_ignore_space       # Ignore commands that start with a space
setopt hist_verify             # Show command with history expansion to the user before running it
setopt inc_append_history      # Add commands to HISTFILE in the order of execution
setopt share_history           # Share command history data among all sessions
