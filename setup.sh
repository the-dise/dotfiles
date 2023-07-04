#!/bin/bash

current_shell=$(basename "$SHELL")
red=$(tput setaf 1)
green=$(tput setaf 2)
reset=$(tput sgr0)

# Check updates
# echo "Updating the package list..."
# sudo apt update
# echo "System update..."
# sudo apt upgrade -y

echo ""
echo -e "\033[1mInstalling useful packages...\033[0m"

# Checking for a package and installing it (if not installed)
#!/bin/bash

# Проверка наличия пакета и его установка (если не установлен)
check_and_install_package() {
    package_name=$1
    if ! command -v "$package_name" &> /dev/null; then
    # if ! dpkg -s "$package_name" >/dev/null 2>&1; then
        echo -n "Installing the package $package_name"
        (
        while true; do
            echo -n "."
            sleep 0.5
        done
    ) &
        sudo apt install -y "$package_name" > /dev/null 2>&1
         kill $! >/dev/null 2>&1
        echo -e "\nPackage $package_name is installed."
    else
        echo "Package $package_name is already installed."
    fi
}

# Checking and installing packages
check_and_install_package "curl"
check_and_install_package "zsh"
check_and_install_package "tmux"
check_and_install_package "git"
check_and_install_package "vim"
check_and_install_package "htop"

echo ""
echo -e "\033[1mInstall ZSH as default shell and install Oh My ZSH... \033[0m"

# Checking Oh My Zsh Availability
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Oh My Zsh не установлен в системе."

    # Installation offer Oh My Zsh
    read -p "Do you want to install Oh My Zsh? (Y/n): " answer

    case "$answer" in
        [yY] | "" )
            # Install Oh My Zsh
            sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
            echo "Oh My Zsh installed."
            ;;
        *)
            echo "Installation Oh My Zsh has been cancelled."
            ;;
    esac
else
    echo "Oh My Zsh is already installed on the system."
fi


case "$current_shell" in
  bash)
    read -p "Current default shell is ${red}bash${reset}. Do you want to set ${green}zsh${reset} as the default shell? (y/n): " answer

    case "$answer" in
      y|Y)
        # Installing zsh by default
        chsh -s /bin/zsh

        if [ $? -eq 0 ]; then
          echo -e "Default shell has been set to ${green}zsh${reset}."
          read -p "Shell change requires a restart. Restart now? (y/n): " restart

          case "$restart" in
            y|Y)
              exec /bin/zsh
              ;;
            *)
              ;;
          esac
        else
          echo -e "Failed to set default shell to ${green}zsh${reset}."
        fi
        ;;
      *)
        echo -e "Default shell remains as ${red}bash${reset}."
        ;;
    esac
    ;;
  zsh)
    read -p "Current default shell is ${green}zsh${reset}. Do you want to set ${red}bash${reset} as the default shell? (y/n): " answer

    case "$answer" in
      y|Y)
        # Installing bash by default
        chsh -s /bin/bash

        if [ $? -eq 0 ]; then
          echo -e "Default shell has been set to ${red}bash${reset}."
          read -p "Shell change requires a restart. Restart now? (y/n): " restart

          case "$restart" in
            y|Y)
              exec /bin/bash
              ;;
            *)
              ;;
          esac
        else
          echo -e "Failed to set default shell to ${red}bash${reset}."
        fi
        ;;
      *)
        echo -e "Default shell remains as ${green}zsh${reset}."
        ;;
    esac
    ;;
  *)
    echo "Unsupported shell: $current_shell"
    ;;

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