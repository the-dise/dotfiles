# -- history settings --------------------------------------------------------
SAVEHIST=1000                  # Number of history entries to save
HISTSIZE=5000                  # Maximum number of lines of history to save in memory
HISTFILE=~/.zhistory           # Location of the history file
HISTDUP=erase                  # Erase duplicates in the history file

# -- extended history options ------------------------------------------------
setopt append_history          # Append commands to the history file, rather than overwriting it
setopt extended_history        # Record timestamp of command in HISTFILE
setopt share_history           # Share command history data among all sessions
setopt inc_append_history      # Add commands to HISTFILE in the order of execution

setopt hist_expire_dups_first  # Delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups        # Ignore duplicated commands in history list
setopt hist_ignore_all_dups    # Ignore all duplicated commands in history list
setopt hist_save_no_dups       # Do not save duplicated commands in history file
setopt hist_find_no_dups       # Do not display duplicates when searching history
setopt hist_ignore_space       # Ignore commands that start with a space
setopt hist_verify             # Show command with history expansion to the user before running it

