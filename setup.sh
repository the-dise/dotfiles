#!/bin/bash

relink () {
  local src="$1"
  local dst="$2"

  mkdir -p "$(dirname "$dst")" # Checking the existence of the destination directory and creating it if necessary
  rm -rf "$dst" # To delete an existing symbolic link or file
  ln -s "$src" "$dst" #Creating a new symbolic link
}

XDG_CONFIG_HOME=$XDG_CONFIG_HOME:=$HOME/.config # Setting the XDG_CONFIG_HOME variable

# Recreating symbolic links
relink ~/.dotfiles/zsh/zshrc ~/.zshrc
relink ~/.dotfiles/zsh/dbox.zsh-theme ~/.oh-my-zsh/custom/themes/dbox.zsh-theme
relink ~/.dotfiles/vim ~/.vim
relink ~/.dotfiles/vim/vimrc ~/.vimrc
relink ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf
relink ~/.dotfiles/tmux ~/.tmux

exec zsh
