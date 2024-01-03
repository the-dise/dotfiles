#!/bin/bash

# Global variables
current_shell=$(basename "$SHELL")
red=$(tput setaf 1)
green=$(tput setaf 2)
reset=$(tput sgr0)

# Install oh My ZSH plugins
check_and_install_plugin() {
    local plugin_name="$1"
    local repo_url="$2"
    local plugin_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/$plugin_name"

    if [ -d "$plugin_dir" ]; then
        echo "The $plugin_name plugin already exists."
    else
        git clone "$repo_url" "$plugin_dir"
    fi
}

check_and_install_plugin "zsh-autosuggestions" "https://github.com/zsh-users/zsh-autosuggestions.git"
check_and_install_plugin "zsh-syntax-highlighting" "https://github.com/zsh-users/zsh-syntax-highlighting.git"


# Install Dise's dotfiles
relink () {
  local src="$1"
  local dst="$2"

  mkdir -p "$(dirname "$dst")" # Checking the existence of the destination directory and creating it if necessary
  rm -rf "$dst" # To delete an existing symbolic link or file
  ln -s "$src" "$dst" #Creating a new symbolic link
}

XDG_CONFIG_HOME=$XDG_CONFIG_HOME:=$HOME/.config # Setting the XDG_CONFIG_HOME variable

# Recreating symbolic links
relink ~/dotfiles/zsh/zshrc ~/.zshrc
relink ~/dotfiles/zsh/dbox.zsh-theme ~/.oh-my-zsh/custom/themes/dbox.zsh-theme
relink ~/dotfiles/vim ~/.vim
relink ~/dotfiles/vim/vimrc ~/.vimrc
relink ~/dotfiles/tmux/tmux.conf ~/.tmux.conf
relink ~/dotfiles/tmux ~/.tmux

exec zsh