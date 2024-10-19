#!/bin/bash

# Define color for success messages
GREEN='\033[0;32m'
BOLD='\033[1m'
NC='\033[0m' # No Color

relink() {
  local src="$1"
  local dst="$2"

  mkdir -p "$(dirname "$dst")"
  rm -rf "$dst"
  ln -s "$src" "$dst"
}

# Function to confirm actions
confirm_action() {
  read -p "$1 (Y/n): " choice
  case "$choice" in
  y | Y | "") # Default to Yes
    return 0
    ;;
  n | N)
    return 1
    ;;
  *)
    echo "Invalid choice, skipping."
    return 1
    ;;
  esac
}

# Function to install starship.rs
install_starship() {
  # Check if starship is already installed
  if ! command -v starship &>/dev/null; then
    # Install starship.rs
    curl -fsSL https://starship.rs/install.sh | bash
  else
    echo "starship.rs is already installed."
  fi
}

# Function to setup zsh configuration
setup_zsh() {
  # Symlink zshrc
  relink ~/.dotfiles/zsh/.zshrc ~/.zshrc

  # Install and symlink starship.rs if chosen
  if [[ -d ~/.config ]]; then
    install_starship
    relink ~/.dotfiles/zsh/starship/starship.toml ~/.config/starship.toml

    echo -e "${GREEN}${BOLD}zsh${NC} successfully configured!$"
  fi
}

# Function to setup tmux configuration
setup_tmux() {
  # Symlink tmux.conf and tmux folder
  relink ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf
  relink ~/.dotfiles/tmux ~/.tmux

  echo -e "${GREEN}${BOLD}tmux${NC} successfully configured!"
}

# Function to setup mpv configuration
setup_mpv() {
  # Symlink mpv configuration folder
  relink ~/.dotfiles/mpv ~/.config/mpv

  echo -e "${GREEN}${BOLD}mpv${NC} successfully configured!"
}

# Function to setup nvim configuration
setup_nvim() {
  # Symlink nvim configuration folder
  relink ~/.dotfiles/nvim/lua ~/.config/nvim/lua

  echo -e "${GREEN}${BOLD}nvim${NC} successfully configured!"
}

# Function to setup additional configurations
setup_additional() {
  if confirm_action "Setup fastfetch?"; then
    # Symlink config.jsonc
    relink ~/.dotfiles/confs/fastfetch/config.jsonc ~/.config/fastfetch/config.jsonc

    echo -e "${GREEN}fastfetch${NC} successfully configured!"
  else
    echo "Skipping fastfetch setup."
  fi

  # if confirm_action "Setup Logiops (for MX Master 3S)?"; then
  #   # Symlink logid.cfg
  #   sudo relink ~/.dotfiles/confs/logid.cfg /etc/logid.cfg

  #   echo -e "${GREEN}logiops${NC} successfully configured!"
  # else
  #   echo "Skipping Logiops setup."
  # fi
}

# Main script execution
setup_zsh
setup_tmux
setup_mpv
setup_nvim
setup_additional

# Start zsh
exec zsh
