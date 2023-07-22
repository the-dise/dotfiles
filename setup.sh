#!/bin/bash

# Global variables
current_shell=$(basename "$SHELL")
red=$(tput setaf 1)
green=$(tput setaf 2)
reset=$(tput sgr0)

# Function to check the Linux distribution
check_system() {
    if [ -f "/etc/os-release" ]; then
        . /etc/os-release
        if [ "$ID" != "ubuntu" ] && [ "$ID" != "debian" ]; then
            echo "This script is intended to run only on Debian-based systems."
            exit 1
        fi
    else
        echo "Unable to determine the Linux distribution. This script requires Ubuntu or Debian."
        exit 1
    fi
}

check_system

# Check updates
echo -e "\033[1mUpdating the package list and updating the system...\033[0m"
sudo apt update && apt upgrade -y

# Checking for a package and installing it (if not installed)
check_and_install_package() {
    package_name=$1
    if ! command -v "$package_name" &> /dev/null; then
        echo -n "Installing the package $package_name..."
        sudo apt install -y "$package_name" > /dev/null 2>&1
        echo "done."
    else
        echo "Package $package_name is already installed."
    fi
}

echo -e "\033[1mInstalling useful packages...\033[0m"
check_and_install_package "curl" # scripts to transfer data
check_and_install_package "zsh" # unix shell
check_and_install_package "tmux" # terminal multiplexer
check_and_install_package "git" # version control system
check_and_install_package "vim" # highly configurable text editor 
check_and_install_package "htop" # interactive process viewer
check_and_install_package "exa" # modern replacement for ls
check_and_install_package "ncdu" # disk utility for unix systems
check_and_install_package "batcat" # cat clone with syntax highlighting

echo -e "\033[1mInstall ZSH as default shell and install Oh My ZSH... \033[0m"

# Installing zsh by default
chsh -s /bin/zsh

# Checking Oh My Zsh Availability and install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "Oh My Zsh is already installed on the system."
fi

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